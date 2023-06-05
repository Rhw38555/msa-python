import logging, datetime, json
import pymongo
from urllib.parse import quote_plus
from confluent_kafka import Producer
from flask_cors import CORS
from sqlalchemy import desc
from sqlalchemy.sql import func
from flask import request
import log_property

from models import app, db, Item

# 웹설정 추가
app.config.setdefault('PAGE_SIZE', 100)

# CORS 설정
CORS(app)

# Logger path 설정
log_path = '/app_log'

# root 로거
log_property.configure_logger(logging.getLogger(), log_path, log_filename='alarm.log',
                        log_level=app.config['ROOT_LOG_LEVEL'])
# sqlalchemy 로거
logging.getLogger('sqlalchemy').setLevel(app.config['SQLALCHEMY_LOG_LEVEL'])
logging.getLogger('sqlalchemy.orm').setLevel('WARN')

# cqrs view 조회 클라이언트
uri = "mongodb://%s:%s@%s" % (
    quote_plus('cqrs'), quote_plus('cqrs-assignment'), 'mongo-1')
pymongo_client = pymongo.MongoClient(uri)

# cqrs event produce client
conf_producer = {'bootstrap.servers': 'kafka1:19092'}
producer = Producer(conf_producer)

@app.route('/', methods = ['GET'])
def get():
    '''상품 목록 API
상품 전체 목록(사용자 알람 설정 여부 포함)
    '''
    req_headers = request.headers

    # response variable
    res_dict = {}
    res_payload_list = []
    header_token = req_headers.get('USER-TOKEN')
    if header_token:
        # hedaer 토큰 전달
        user_view_reuslt = pymongo_client['cqrs']['user'].find_one({'access_token':header_token})
        item_id_list = []
        item_model_list = db.session().query(Item).order_by(desc(Item.id)).all()
        for item in item_model_list:
            tmp_dict = {'id': item.id, 'name' : item.name, 'broadcaster' : item.broadcaster, 'category' : item.category, 'price' : item.price, 'is_alarm_set' : False}
            item_view_reuslt = pymongo_client['cqrs']['alram'].find_one({"$and" : [{ "item_id" : item.id}, {'user_id' : user_view_reuslt['user_id']}]})
            # read view 알람세팅 조회 시 true 변경
            if item_view_reuslt:
                tmp_dict["is_alarm_set"] = True
            res_payload_list.append(tmp_dict)

        res_dict["count"] = len(res_payload_list)
        res_dict["payload"] = res_payload_list

    return res_dict

@app.route('/<item_id>', methods = ['GET'])
def get_detail(item_id):
    '''단일 상품 상세보기 API
단일 상품 정보 조회, 조회 이력 추가
    '''
    req_headers = request.headers
    # response variable
    res_dict = {}
    res_code = 404
    header_token = req_headers.get('USER-TOKEN')
    if header_token:
        # hedaer 토큰 전달
        user_view_reuslt = pymongo_client['cqrs']['user'].find_one({'access_token':header_token})
        item_id_list = []
        item = db.session().query(Item).get(item_id)
        if item:
            new_item_id = int(item_id)
            tmp_dict = {'id': new_item_id, 'name' : item.name, 'broadcaster' : item.broadcaster, 'category' : item.category, 'price' : item.price, 'is_alarm_set' : False}
            item_view_reuslt = pymongo_client['cqrs']['alram'].find_one({"$and" : [{ "item_id" : new_item_id}, {'user_id' : user_view_reuslt['user_id']}]})
            # read view 알람세팅 조회 시 true 변경
            if item_view_reuslt:
                tmp_dict["is_alarm_set"] = True

            res_dict['payload'] = tmp_dict
            created_time = datetime.datetime.now()
            str_created_time = created_time.strftime('%Y-%m-%d %H:%M:%S')
            # kafka message produce, 사용자 상품 알람 삭제 
            producer.produce('item_history', value=json.dumps({ 'item_id' : new_item_id, 'user_id' : user_view_reuslt['user_id'], 'created' : str_created_time}))
            producer.flush()
            res_code = 200
    return res_dict, res_code

if __name__ == '__main__':
    app.run(host=app.config['HOST'],
            port=app.config['PORT'],
            debug=app.config['DEBUG'],
            threaded=True)
