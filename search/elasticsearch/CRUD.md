

## Operate for Index

```bash
ES_HOST="http://es.gtcafe.corp"
INDEX_NAME="rick-index"
TYPE_NAME="Weight"

## List all indices
curl ${ES_HOST}/_cat/indices

## Specify Target IndexName
curl ${ES_HOST}/_cat/indices/${INDEX_NAME}

## Create
curl -XPUT "${ES_HOST}/${INDEX_NAME}"
curl ${ES_HOST}/_cat/indices/${INDEX_NAME}

curl -XPUT "${ES_HOST}/${INDEX_NAME}/${TYPE_NAME}"
curl -XPUT "${ES_HOST}/${INDEX_NAME}/type1"
curl -XPUT "${ES_HOST}/${INDEX_NAME}/type2"
{"error":"Incorrect HTTP method for uri [/rick-index/Weight] and method [PUT], allowed: [POST]","status":405}

## Delete Index
curl -XDELETE "${ES_HOST}/${INDEX_NAME}"
{"acknowledged":true}

curl -XDELETE "${ES_HOST}/metricbeat-7.6.0-2020.11.28-000001"
curl -XDELETE "${ES_HOST}/gtlab111-k1-19-3_nginx-ingress-*"
curl -XDELETE "${ES_HOST}/gtlab111-k1-19-3_portalshell-2020-11-07"
curl -XDELETE "${ES_HOST}/k1193_portal-shell-2020-11-30"

for i in graylog_307 graylog_308 graylog_309 graylog_311; do
 curl -XDELETE ${ES_HOST}/${i}
done
```


ref:

* https://computingforgeeks.com/easy-way-to-delete-elasticsearch-index-data/


## Operate of document

```bash
for i in {1..5}; do
    curl -XPOST \
        -H "Cache-Control: no-cache" \
        -H 'Content-Type: application/json' \
        "${ES_HOST}/${INDEX_NAME}/${TYPE_NAME}/${i}" \
        -d @./index/data${i}.json
done
```



## Put Multiple Record

```bash
curl -XPOST 'es.gtcafe.corp/_bulk?pretty' \
    -H 'Content-Type: application/json' \
    -d'
{ "update" : {"_id" : "1", "_type" : "type1", "_index" : "rick-index"} }
{ "doc" : {"field" : "value"} }
{ "update" : { "_id" : "0", "_type" : "type1", "_index" : "rick-index"} }
{ "script" : { "inline": "ctx._source.counter += params.param1", "lang" : "painless", "params" : {"param1" : 1}}, "upsert" : {"counter" : 1}}
{ "update" : {"_id" : "2", "_type" : "type1", "_index" : "rick-index"} }
{ "doc" : {"field" : "value"}, "doc_as_upsert" : true }
{ "update" : {"_id" : "3", "_type" : "type1", "_index" : "rick-index", "_source" : true} }
{ "doc" : {"field" : "value"} }
{ "update" : {"_id" : "4", "_type" : "type1", "_index" : "rick-index"} }
{ "doc" : {"field" : "value"}, "_source": true}
'
```