FROM python:3
LABEL maintainer="Austin Pets Alive technology volunteers"

RUN apt-get update
RUN apt-get install -y python3 python3-dev python3-pip nginx
RUN pip3 install uwsgi

COPY ./ ./app
WORKDIR /app

RUN pip3 install -r /app/src/requirements.txt
CMD service nginx start -c /app/deploy/nginx.conf && uwsgi --socket unix:/app/app.sock --mount /=src.app:app