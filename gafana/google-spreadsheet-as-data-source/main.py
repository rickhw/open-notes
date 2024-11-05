import json
import gspread
from google.oauth2.service_account import Credentials

# 設定 Google Sheets API
creds = Credentials.from_service_account_file('path/to/credentials.json', scopes=[
    "https://www.googleapis.com/auth/spreadsheets",
    "https://www.googleapis.com/auth/drive"
])

client = gspread.authorize(creds)
sheet = client.open("你的 Google Sheet 名稱").sheet1  # 選擇工作表
data = sheet.get_all_records()  # 抓取所有資料

# 把資料格式化為 JSON，方便 Grafana 使用
json_data = json.dumps(data)

# 將這些數據公開成 API 供 Grafana 呼叫
from flask import Flask, jsonify
app = Flask(__name__)

@app.route('/data')
def get_data():
    return jsonify(json.loads(json_data))

if __name__ == '__main__':
    app.run(port=5000)
