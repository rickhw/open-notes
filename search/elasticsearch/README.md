

## Elastic

```bash
curl https://localhost:9200 --cacert /etc/elasticsearch/certs/http_ca.crt -u elastic


root@ip-172-31-5-147:/usr/share/elasticsearch/bin# curl https://localhost:9200 \
    --cacert /etc/elasticsearch/certs/http_ca.crt \
    -u elastic

Enter host password for user 'elastic':
{
  "name" : "ip-172-31-5-147",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "yIzeAJ2FRcSpYhv0VJaKZQ",
  "version" : {
    "number" : "8.14.1",
    "build_flavor" : "default",
    "build_type" : "deb",
    "build_hash" : "93a57a1a76f556d8aee6a90d1a95b06187501310",
    "build_date" : "2024-06-10T23:35:17.114581191Z",
    "build_snapshot" : false,
    "lucene_version" : "9.10.0",
    "minimum_wire_compatibility_version" : "7.17.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "You Know, for Search"
}
```

---

- https://linuxcapable.com/how-to-install-elasticsearch-8-on-ubuntu-linux/


----
## kibana

```bash
root@ip-172-31-5-147:/usr/share/elasticsearch/bin# ./elasticsearch-create-enrollment-token -s kibana
```

----

https://www.elastic.co/guide/en/elasticsearch/reference/current/reset-password.html