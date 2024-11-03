
# Docker

https://github.com/deviantony/docker-elk


https://hub.docker.com/_/elasticsearch

```bash
docker network create somenetwork
docker run -d \
    --name elasticsearch \
    --net somenetwork \
    -p 9200:9200 -p 9300:9300 \
    -e "discovery.type=single-node" \
    elasticsearch:tag
```

---

# Installation


https://blog.toright.com/posts/6293/ubuntu-18-04-%E9%80%8F%E9%81%8E-netplan-%E8%A8%AD%E5%AE%9A%E7%B6%B2%E8%B7%AF%E5%8D%A1-ip.html

Install JDK: https://linuxize.com/post/install-java-on-ubuntu-18-04/


## Install elasticsearch By Apt

https://linuxize.com/post/how-to-install-elasticsearch-on-ubuntu-18-04/
https://www.digitalocean.com/community/tutorials/how-to-install-elasticsearch-logstash-and-kibana-elastic-stack-on-ubuntu-18-04

```bash
apt update
apt install apt-transport-https
apt install openjdk-8-jdk
java -version

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sh -c 'echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" > /etc/apt/sources.list.d/elastic-7.x.list'

apt update
apt install elasticsearch
systemctl enable elasticsearch.service
systemctl start elasticsearch.service

curl -X GET "localhost:9200/"
```

### kibana

echo "admin:`openssl passwd -apr1`" | sudo tee -a /etc/nginx/htpasswd.users


### Logstash

```bash
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list

apt-get update
apt-get install logstash
systemctl status logstash
systemctl enable logstash
systemctl start logstash
sudo lsof -i -P -n | grep logstash

systemctl stop logstash
```



---
## Manaul

ref: https://www.osradar.com/setting-up-elasticsearch-on-linux/


echo "vm.max_map_count = 262144" >> /etc/sysctl.conf


vim /etc/systemd/system/elasticsearch.service

```bash
[Unit]
Description=Elasticsearch
Documentation=http://www.elastic.co
Wants=network-online.target
After=network-online.target

[Service]
Environment=ES_HOME=/opt/elasticsearch/current/
Environment=CONF_DIR=/opt/elasticsearch/current/config/
Environment=DATA_DIR=/opt/elasticsearch/current/data/
Environment=LOG_DIR=/opt/elasticsearch/current/logs/
Environment=PID_DIR=/opt/elasticsearch/current/
Environment=JAVA_HOME=/opt/elasticsearch/current/jdk
EnvironmentFile=-/etc/sysconfig/elasticsearch
WorkingDirectory=/opt/elasticsearch/current/

User=ubuntu
Group=ubuntu

ExecStart=/opt/elasticsearch/current/bin/elasticsearch \
                                                -p ${PID_DIR}/elasticsearch.pid \
                                                --quiet \
                                                -Edefault.path.logs=${LOG_DIR} \
                                                -Edefault.path.data=${DATA_DIR} \
                                                -Edefault.path.conf=${CONF_DIR}

StandardOutput=journal
StandardError=inherit
LimitNOFILE=65536
LimitMEMLOCK=infinity
TimeoutStopSec=0
KillSignal=SIGTERM
SendSIGKILL=no
SuccessExitStatus=143

[Install]
WantedBy=multi-user.target
```


systemctl daemon-reload
systemctl start elasticsearch
systemctl status elasticsearch


---
# Config

## ship log to elasticsearch