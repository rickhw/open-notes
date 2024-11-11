import requests
import random
from datetime import datetime, timedelta

# Meilisearch API 設定
meilisearch_url = "http://localhost:7700/indexes/logs/documents"
headers = {
    "Authorization": "Bearer your_master_key",
    "Content-Type": "application/json"
}

# 隨機產生 log data
def generate_logs(num_logs=500):
    levels = ["INFO", "WARN", "ERROR", "DEBUG"]
    logs = []
    current_time = datetime.now()

    for _ in range(num_logs):
        log_entry = {
            "date_time": (current_time - timedelta(seconds=random.randint(0, 10000))).strftime('%Y-%m-%d %H:%M:%S'),
            "level": random.choice(levels),
            "message": f"Sample log message {_}"
        }
        logs.append(log_entry)

    return logs

# 發送 log data 到 Meilisearch
def send_logs_to_meilisearch(logs):
    response = requests.post(meilisearch_url, headers=headers, json=logs)
    if response.status_code == 202:
        print("Logs successfully sent to Meilisearch.")
    else:
        print("Failed to send logs:", response.text)

# 生成並發送 logs
logs = generate_logs(500)
send_logs_to_meilisearch(logs)
