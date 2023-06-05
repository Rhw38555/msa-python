FROM mongo:5.0.9

# COPY ./mongo/mysetup.sh /docker-entrypoint-initdb.d/
COPY ./mongo/mysetup.js /docker-entrypoint-initdb.d/
EXPOSE 27017
CMD ["mongod"]