FROM python:3.8.3-slim

COPY ./api-alarm/requirements.txt /api-alarm/requirements.txt
COPY ./api-alarm/sources /api-alarm

WORKDIR /api-alarm

RUN apt-get update && apt-get install -y build-essential libssl-dev libffi-dev libpq-dev python3-dev
RUN pip3 install -r /api-alarm/requirements.txt

ENTRYPOINT ["gunicorn", "--bind", "0.0.0.0:6001", "sample:app"]