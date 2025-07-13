#! /bin/bash
# ubuntu 24.04, java application server

sudo apt install vim git curl zip unzip htop btop dnsutils -y

curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

sdk install java 17.0.9-graalce
sdk install java 17.0.14-amzn
sdk install java 17.0.14-zulu 
sdk install gradle
sdk install maven


##---------
# filebeat
# 匯入 Elastic 公鑰
curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elastic-archive-keyring.gpg

# 新增套件來源
echo "deb [signed-by=/usr/share/keyrings/elastic-archive-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | \
  sudo tee /etc/apt/sources.list.d/elastic-8.x.list

# 更新套件並安裝 filebeat
sudo apt update
sudo apt install filebeat

# 測試
sudo filebeat test config

sudo systemctl enable filebeat
sudo systemctl start filebeat
sudo systemctl status filebeat

# 啟用 Filebeat Elasticsearch dashboard 與 index template
sudo filebeat setup --index-management -E output.elasticsearch.hosts=["http://localhost:9200"]
sudo filebeat setup --dashboards

# 檢查 Filebeat 是否成功送出資料
curl -X GET "localhost:9200/filebeat-*/_search?pretty"

# springboot: application.yml
logging:
  file:
    name: /var/log/myapp/application.log

sudo mkdir -p /var/log/myapp
sudo chown -R filebeat:filebeat /var/log/myapp



##---------
# node exporter

