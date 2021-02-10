#!/bin/bash

IMAGE=s3mail

docker build -t $IMAGE .
docker rm -f $IMAGE
docker run -d \
  -h $(hostname -f) \
  --name $IMAGE \
  -p "25:25/tcp" \
  -p "587:587/tcp" \
  -v /etc/localtime:/etc/localtime:ro \
  -v $PWD/opendkim:/etc/opendkim:ro \
  -v $PWD/postfix:/etc/postfix:ro \
  $IMAGE

#  -v $PWD/letsencrypt:/etc/letsencrypt:ro \
#  --restart=always \
#  --net bridge \
