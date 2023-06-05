FROM python:3.8.3-slim

COPY ./api-user/requirements.txt /api-user/requirements.txt
COPY ./api-user/sources /api-user

WORKDIR /api-user

RUN apt-get update && apt-get install -y build-essential libssl-dev libffi-dev libpq-dev python3-dev
RUN pip3 install -r /api-user/requirements.txt

ENTRYPOINT ["gunicorn", "--bind", "0.0.0.0:7001", "sample:app"]

