#!/usr/bin/env python3
#-*- coding: utf-8 -*-

import json
import logging
import pymongo
from urllib.parse import quote_plus
from confluent_kafka import Producer, Consumer
from datetime import datetime
import sys

# cqrs view write 클라이언트
uri = "mongodb://%s:%s@%s" % (
    quote_plus('cqrs'), quote_plus('cqrs-assignment'), 'mongo-1')
pymongo_client = pymongo.MongoClient(uri)

logger = logging.getLogger()
logger.setLevel(logging.DEBUG)
logger.addHandler(logging.StreamHandler(sys.stdout))

conf_consumer = {'bootstrap.servers': 'kafka1:19092', 'group.id': 'alram_consumer_group', 'auto.offset.reset': 'earliest'}
consumer = Consumer(conf_consumer)

inbound_event_channel = 'alram'

def main():
    try:
        consumer.subscribe([inbound_event_channel])
        while True:
            message = consumer.poll(timeout=3)
            if message is None:
                continue

            event = message.value()
            if event:
                logging.debug(event)
                evt = json.loads(event)
                status = evt['status']
                item_id = evt['item_id']
                user_id = evt['user_id']

                if status == 'delete' :
                    pymongo_client['cqrs']['alram'].delete_one({ 'item_id' : item_id, 'user_id' : user_id})
                elif status == 'create':
                    created = evt['created']
                    convert_time = datetime.strptime(created, '%Y-%m-%d %H:%M:%S')
                    pymongo_client['cqrs']['alram'].insert_one({ 'item_id' : item_id, 'user_id' : user_id, 'created' : convert_time})

            else:
                continue

    finally:
        consumer.close()    

if __name__ == '__main__':
    main()