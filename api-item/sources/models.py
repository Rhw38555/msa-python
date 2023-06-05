import importlib
from flask import Flask
from sqlalchemy.sql import func
from flask_sqlalchemy import SQLAlchemy



def getConfig():
    
    '''properties 로더
    '''
    
    mod = importlib.import_module('property')
    cls = getattr(mod, 'CommonConfig')
    return cls


# Web/Shell 환경에서 동일하게 사용하기 위해서 flask_sqlalchemy객체로 생성
app = Flask(__name__)
app.config.from_object(getConfig())
db = SQLAlchemy(app)

# item models
class Item(db.Model):
    __tablename__ = 'item'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String())
    broadcaster = db.Column(db.String())
    category = db.Column(db.String())
    price = db.Column(db.Integer)