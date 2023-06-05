FROM postgres:12.2-alpine

COPY ./postgres-user/init_database.sql /docker-entrypoint-initdb.d