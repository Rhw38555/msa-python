FROM python:3.8.3-slim

COPY ./kafka-alram/requirements.txt /kafka/requirements.txt
COPY ./kafka-alram/sources /kafka

WORKDIR /kafka

RUN pip3 install -r /kafka/requirements.txt

# CMD ["python3" , "-m", "alarm_consumer"]
