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

# alram models
class Alram(db.Model):
    __tablename__ = 'alarm'
    id = db.Column(db.Integer, primary_key=True)
    item_id = db.Column(db.Integer)
    user_id = db.Column(db.Integer)
    created = db.Column(db.TIMESTAMP, onupdate=func.timezone('KST', func.now()))
 