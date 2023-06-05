import logging, datetime, json
import pymongo
from urllib.parse import quote_plus
from confluent_kafka import Producer
from flask_cors import CORS
from sqlalchemy.sql import func
from flask import request, Response
import log_property

from models import app, db, Alram


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
def list_alram():
    '''알람 목록 API
사용자 별 알람 기준으로 상품 리스트 조회
    '''
    req_headers = request.headers
    header_token = req_headers.get('USER-TOKEN')
    # response variable
    res_dict = {}
    res_payload_list = []
    res_dict['count'] = 0
    res_dict['payload'] = res_payload_list
    if header_token:
        # hedaer 토큰 전달
        user_view_reuslt = pymongo_client['cqrs']['user'].find_one({'access_token':header_token})
        get_user_alram_model = db.session().query(Alram).filter(Alram.user_id == user_view_reuslt['user_id']).all()
        item_list = []
        if len(get_user_alram_model) > 0:
            for alram_model in get_user_alram_model:
                item_list.append(alram_model.item_id)
            item_view_reuslt = pymongo_client['cqrs']['item'].find({ "item_id" : { '$in' : item_list} }).sort('item_id', -1 )
            for item_view in item_view_reuslt:
                res_payload_list.append({'id': item_view['item_id'], 'name' : item_view['name'], 'broadcaster' : item_view['broadcaster']
                , 'category' : item_view['category'], 'price' : item_view['price']})
            res_dict['count'] = len(res_payload_list)
            

    return res_dict

@app.route('/', methods = ['POST'])
def create_alram():
    '''알람 설정 API(생성)
사용자 별 상품의 알람 상태를 true로 변경
    '''
    req_headers = request.headers
    # response
    res = Response("{}", status=404, mimetype='application/json')
    header_token = req_headers.get('USER-TOKEN')
    if header_token:
        req_json_data = request.get_json(force=True)
        # hedaer 토큰 전달
        user_view_reuslt = pymongo_client['cqrs']['user'].find_one({'access_token':header_token})
        item_id = req_json_data.get('item_id')
        user_id = user_view_reuslt['user_id']
        created_time = datetime.datetime.now()
        if item_id :
            int_item_id = int(item_id)
            item_view_reuslt = pymongo_client['cqrs']['item'].find_one({'item_id':int_item_id})
            if item_view_reuslt:
                create_alram_model = Alram(item_id=int_item_id, user_id=user_id, created=created_time)
                
                # TODO kafka message produce
                db.session.add(create_alram_model)
                db.session.commit()
                # kafka message produce, 사용자 상품 알람 생성
                str_created_time = created_time.strftime('%Y-%m-%d %H:%M:%S')
                producer.produce('alram', value=json.dumps({ 'status' : 'create', 'item_id' : int_item_id, 'user_id' : user_id, 'created' : str_created_time}))
                producer.flush()
                res = Response("{}", status=201, mimetype='application/json')
    return res

@app.route('/', methods = ['DELETE'])
def delete_alram():
    '''알람 설정 API(삭제)
사용자 별 상품의 알람 상태를 false로 변경
    '''
    req_headers = request.headers
    # response
    res = Response("{}", status=404, mimetype='application/json')
    header_token = req_headers.get('USER-TOKEN')
    if header_token:
        header_token = str(header_token)
        req_json_data = request.get_json(force=True)
        # hedaer 토큰 전달
        user_view_reuslt = pymongo_client['cqrs']['user'].find_one({'access_token':header_token})
        item_id = req_json_data.get('item_id')
        user_id = user_view_reuslt['user_id']
        if item_id:
            new_item_id = int(item_id)
            delete_alram_model = db.session().query(Alram).filter(Alram.item_id == new_item_id, Alram.user_id == user_id).first()
            if delete_alram_model:
                db.session.delete(delete_alram_model)
                db.session.commit()
                # kafka message produce, 사용자 상품 알람 삭제 
                producer.produce('alram', value=json.dumps({ 'status' : 'delete', 'item_id' : new_item_id, 'user_id' : user_id}))
                producer.flush()
            res = Response("{}", status=200, mimetype='application/json')

    return res

if __name__ == '__main__':
    app.run(host=app.config['HOST'],
            port=app.config['PORT'],
            debug=app.config['DEBUG'],
            threaded=True)
