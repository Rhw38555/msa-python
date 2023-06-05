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

# user models
class User(db.Model):
    __tablename__ = 'user'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String())
    access_token = db.Column(db.String())