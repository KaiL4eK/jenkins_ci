#!/usr/bin/env bash

docker-compose -f docker-compose.jenkins.yml -f docker-compose.share.yml -p ci_cd stop
docker-compose -f docker-compose.jenkins.yml -f docker-compose.share.yml -p ci_cd up --build -d
