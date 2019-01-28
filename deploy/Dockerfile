FROM python:3
LABEL maintainer="Austin Pets Alive technology volunteers"

RUN apt-get update
RUN apt-get install -y python3 python3-dev python3-pip nginx
RUN pip3 install uwsgi

COPY ./ ./app
WORKDIR ./app

RUN pip3 install -r ./src/requirements.txt
CMD service nginx start && uwsgi -s 127.0.0.1:4242 --manage-script-name --mount /=src.app:app