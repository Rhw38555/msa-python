import logging
import pymongo
from urllib.parse import quote_plus
from flask_cors import CORS
from sqlalchemy import desc
from sqlalchemy.sql import func
from flask import request

import log_property
from models import app, db, User

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

@app.route('/', methods = ['GET'])
def get():
    '''사용자 목록 API
사용자 전체 목록
    '''
    req_headers = request.headers

    # response variable
    res_dict = {}
    res_payload_list = []
    if req_headers.get('USER-TOKEN'):
        # 사용자 DB 조회
        user_model_list = db.session().query(User).order_by(desc(User.id)).all()
        for user in user_model_list:
            res_payload_list.append({'id': user.id, 'name' : user.name, 'access_token' : user.access_token})
        res_dict["count"] = len(user_model_list)
        res_dict["payload"] = res_payload_list

    return res_dict

@app.route('/visit', methods = ['GET'])
def get_current():
    '''최근 본 상품 목록 API
사용자가 방문한 상품 정보를 최근 순서로 최대 3개 보여줌
    '''
    req_headers = request.headers

    # response variable
    res_dict = {}
    res_payload_list = []
    res_dict['count']  = 0
    res_dict['payload'] = res_payload_list
    if req_headers.get('USER-TOKEN'):
        user_model = db.session().query(User).filter(User.access_token == req_headers.get('USER-TOKEN')).first()
        if user_model:
            user_id = user_model.id
            if user_id:
                ## 사용자 최신 방품 상품 조회(중복 제거, 최대3개 데이터 조회)
                current_item_list = pymongo_client['cqrs']['item_history'].aggregate([
                    {"$sort":{"created":1}},
                    {"$match":{"user_id":user_id}},
                    {"$group" : {"_id":{"item_id":"$item_id", "user_id":"$user_id" }, "doc": { "$last": "$$ROOT" }}},
                    {"$sort" : {'doc.created' : -1}},
                    {"$limit" : 3}
                ])

                # item id로 item 정보 생성
                for current_item in current_item_list:
                    item_id = current_item['doc']['item_id']
                    item_view_reuslt = pymongo_client['cqrs']['item'].find_one({ "item_id" : item_id})
                    tmp_dict = {'id' : item_id, 'name' : item_view_reuslt['name'], 'broadcaster' : item_view_reuslt['broadcaster'], 
                    'category' : item_view_reuslt['category'], 'price' : item_view_reuslt['price'], 'is_alarm_set' : False} 
                    # read view 알람세팅 발견 시 true 변경
                    alram_view_reuslt = pymongo_client['cqrs']['alram'].find_one({"$and" : [{ "item_id" : item_id}, {'user_id' : user_id }]})
                    if alram_view_reuslt:
                        tmp_dict["is_alarm_set"] = True
                    res_payload_list.append(tmp_dict)

            res_dict['count'] = len(res_payload_list)

    return res_dict

if __name__ == '__main__':
    app.run(host=app.config['HOST'],
            port=app.config['PORT'],
            debug=app.config['DEBUG'],
            threaded=True)
