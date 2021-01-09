#!/bin/bash

docker-compose -f docker-compose.nginx.yml -p nginx logs -f
