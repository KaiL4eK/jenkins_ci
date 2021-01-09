#!/usr/bin/env bash

docker-compose -f docker-compose.nginx.yml -p nginx stop
docker-compose -f docker-compose.nginx.yml -p nginx up --build -d nginx
