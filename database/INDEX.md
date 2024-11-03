
## NewSQL

- TiDB
- CockroachDB: https://www.cockroachlabs.com/
- https://github.com/apple/foundationdb
- VoltDB
- OceanBase
- guestdb: https://github.com/questdb/questdb
- mariadb



## Database

- Relation Database, OLTP, Row-Based
    - mysql
    - postgresql
    - mssql
- Relation Database, OLAP, Column-Based
    - [clickhouse](https://clickhouse.com/)
    - MongoDB
- new DB / HTAP (Hybrid Transactional and Analytical Processing)
    - [yugabyte](https://www.yugabyte.com/): OLAP / OLTP
    - [cockroachlabs](https://www.cockroachlabs.com/product/)
    - [TiDB](https://docs.pingcap.com/zh/tidb/stable): 中國產品, HTAP
    - [OceanBase](https://www.oceanbase.com/): 中國產品, HTAP
- k/v db
    - etcd
- time-series
    - inflexDB
- search
    - [quickwit](https://quickwit.io/): by rust, replace with Elasticsearch
    - elk
    - https://github.com/meilisearch/meilisearch
    - https://www.meilisearch.com/
- event
    - [KEDA](https://keda.sh/): Kubernetes Event-driven Autoscaling
- statis
    - apache superset (像是 athena)




---
# 專有名詞

* Serializable Snapshot Isolation (SSI), -- https://time.geekbang.org/column/article/272999
* 嚴格串行化（Strict Serializable）