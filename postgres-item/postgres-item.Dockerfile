FROM postgres:12.2-alpine

COPY ./postgres-item/init_database.sql /docker-entrypoint-initdb.d