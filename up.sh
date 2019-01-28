#!/bin/bash
if [ -z "$1" ]; then
    echo 'setting tagname to "template"'
    tag_name=template
else
    tag_name=$1
fi
if [ -z "$2" ]; then
    echo 'setting tag number to "latest"'
    tag_number=latest
else
    tag_number=$2
fi

docker.exe build -f ./deploy/Dockerfile -t ${tag_name}:${tag_number} .
docker.exe run -d -p 1337:80 ${tag_name}:${tag_number}