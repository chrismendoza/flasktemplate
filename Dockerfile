FROM python:3.7
LABEL maintainer="Austin Pets Alive technology volunteers"

RUN apt-get update
RUN apt-get install -y python3 python3-dev python3-pip nginx
RUN pip3 install uwsgi

#clear the default config so it doesn't conflict listening on 80
RUN rm /etc/nginx/sites-enabled/default

#establish our site in /app in the container
COPY ./ /app
WORKDIR /app

#copy our site config out to the docker image
RUN cp ./deploy/nginx.conf /etc/nginx/sites-available
RUN ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/nginx.conf

RUN pip3 install -r /app/src/requirements.txt

CMD service nginx start && uwsgi --socket /app/app.sock --mount /=src.app:app --chmod-socket=777 --touch-reload=/app/src/app.py