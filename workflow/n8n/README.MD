這裡是一個完整的範例，讓你可以在 **MacBook 上透過 Docker Compose** 跑 [n8n](https://n8n.io/)，並提供一個簡單的 **Webhook to Email** 範例應用流程。

---

## ✅ 第一步：建立 `docker-compose.yml`

```yaml
version: "3.1"

services:
  n8n:
    image: n8nio/n8n:latest
    container_name: n8n
    restart: always
    ports:
      - "5678:5678"
    environment:
      - N8N_BASIC_AUTH_ACTIVE=true
      - N8N_BASIC_AUTH_USER=admin
      - N8N_BASIC_AUTH_PASSWORD=admin123
      - N8N_HOST=localhost
      - N8N_PORT=5678
      - WEBHOOK_URL=http://localhost:5678
    volumes:
      - ./n8n_data:/home/node/.n8n
```

> 🔐 預設帳密是 `admin / admin123`，你可自訂。

---

## ✅ 第二步：啟動 n8n

```bash
docker-compose up -d
```

啟動後，瀏覽器開啟：[http://localhost:5678](http://localhost:5678)

---

## ✅ 第三步：建立一個簡單的應用案例 (Webhook + Email)

### 🧪 使用情境

當外部 POST 一筆 JSON 到 webhook 時，n8n 會解析資料，並寄出一封 Email。

### 步驟如下：

1. 登入 n8n。

2. 點選 `+ New Workflow`。

3. 拖曳以下兩個節點到畫布：

   * **Webhook (Trigger)**
     設定：

     * HTTP Method: `POST`
     * Path: `send-email`
     * Response Mode: `On Received`
     * Save & Activate workflow 後，n8n 會給你一個 URL，例如：

       ```
       http://localhost:5678/webhook/send-email
       ```

   * **Email (Node)**
     設定：

     * SMTP Host: `smtp.gmail.com`（或你的 SMTP）
     * Port: `587`
     * User: `your-email@gmail.com`
     * Password: `app password`（建議使用 Gmail App Password）
     * From Email: `your-email@gmail.com`
     * To Email: `your-email@gmail.com`
     * Subject: `New message from webhook`
     * Text: `Received payload: {{$json["message"]}}`

4. 用線連接 Webhook → Email。

5. 點選 `Activate` 啟用工作流。

---

## ✅ 第四步：測試 Webhook

用 `curl` 發送測試請求：

```bash
curl -X POST http://localhost:5678/webhook/send-email \
  -H "Content-Type: application/json" \
  -d '{"message": "Hello from webhook"}'
```

你應該會收到一封 Email，內容為：

```
Received payload: Hello from webhook
```

---

## 📂 檔案結構

```
your-folder/
├── docker-compose.yml
└── n8n_data/         <-- n8n 會自動建立這個目錄儲存工作流程資料
```

---

如果你希望我幫你產出這個 workflow 的 JSON，讓你可以用匯入方式加快流程，請告訴我！

