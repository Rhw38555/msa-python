FROM python:3.8.3-slim

COPY ./api-item/requirements.txt /api-item/requirements.txt
COPY ./api-item/sources /api-item

WORKDIR /api-item

RUN apt-get update && apt-get install -y build-essential libssl-dev libffi-dev libpq-dev python3-dev
RUN pip3 install -r /api-item/requirements.txt

ENTRYPOINT ["gunicorn", "--bind", "0.0.0.0:5001", "sample:app"]