# postgres alram config
class CommonConfig(object):

    pg_db_username = 'postgres'
    pg_db_password = 'cqrs-assignment'
    pg_db_name = ''
    pg_db_host = 'postgres-user'
    pg_db_port = '5432'

    DEBUG = False
    TESTING = False
    PORT = 7001
    HOST = '0.0' + '.0.0'
    ROOT_LOG_LEVEL = "DEBUG"
    SQLALCHEMY_LOG_LEVEL = "INFO"    
    SQLALCHEMY_ECHO = False
    SQLALCHEMY_DATABASE_URI = "postgresql+pygresql://{DB_USER}:{DB_PASS}@{DB_HOST}:{DB_PORT}/{DB_NAME}".format(
        DB_USER=pg_db_username,
        DB_PASS=pg_db_password,
        DB_HOST=pg_db_host,
        DB_PORT=pg_db_port,
        DB_NAME=pg_db_name)

