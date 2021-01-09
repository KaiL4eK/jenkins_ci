#!/bin/bash

## TODO - make python script with input

DUCKDNS_TOKEN=827c8dde-4c50-4dcb-a70a-ce7d1adcd893
TEXT=$1

echo "Set text: $TEXT"

curl -X GET \
    "https://www.duckdns.org/update?domains=coiot.duckdns.org&token=$DUCKDNS_TOKEN&txt=$TEXT&verbose=true"

sleep 5

echo
echo "Check!"
echo

dig txt _acme-challenge.coiot.duckdns.org
