FROM postgres:12.2-alpine

COPY ./postgres-alarm/init_database.sql /docker-entrypoint-initdb.d