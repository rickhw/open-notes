

https://github.com/meilisearch/meilisearch


```bash
docker run -it --rm \
  -p 7700:7700 \
  -e MEILI_MASTER_KEY='MASTER_KEY'\
  -v $(pwd)/meili_data:/meili_data \
  getmeili/meilisearch:v1.11

```


```
curl \
  -X POST 'http://localhost:7700/indexes' \
  -H 'Content-Type: application/json' \
  --data-binary '{
    "uid": "movies",
    "primaryKey": "id"
  }'
```