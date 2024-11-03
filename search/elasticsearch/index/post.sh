#!/bin/bash

ES_HOST="http://es.gtcafe.corp"
INDEX_NAME="rick-index"
TYPE_NAME="Weight"

for i in {1..5}; do
    curl -XPOST \
        -H "Cache-Control: no-cache" \
        -H 'Content-Type: application/json' \
        "${ES_HOST}/${INDEX_NAME}/${TYPE_NAME}/${i}" \
        -d @data${i}.json

done