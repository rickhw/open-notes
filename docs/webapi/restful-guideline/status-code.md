!!!warning "Mandatory"
| HTTP status code | 適用情境說明                         |
|:-----------------|:---------------------------|
| 200 OK | 1. 代表 API 執行成功，不限特定 HTTP method<br />2. 通常 `GET` requests 成功，會使用此狀態碼並回傳資料<br /> 3. 多筆資料回傳情境，當查詢結果沒有資料時，一般實作會回傳空集合，通常搭配使用此狀態碼 |
| 201 Created | 1. 一般是指建立新資源，代表 `POST` requests 成功<br /> 2. 若是新增資料，則 response payload 應包含新資料的 `id` or `Primary Key` 之類的識別值 |
| 202 Accepted | 適用於非同步或批次作業情境，Server 無法在第一時間回應該 API request 成功或失敗時，通常使用此狀態碼並回傳該非同步作業 id |
| 204 No Content | 適用於 `DELETE` requests 情境，表述某個 resource 被刪除了 |
| 400 Bad Request | 1. API Request 參數有誤<br /> 2.`Content-Type` header 設定不正確，例如未指定 `application/json` / `x-api-key`<br />3. Server Side 檢查拋出的例外情境|
| 401 Unauthorized | `Session expired` / `Session invalid` |
| 403 Forbidden | 1. Server to Server<br /> 2. 一般情況由 API Gateway 回應，表述無權限訪問該 resource |
| 404 Not Found | 1. API endpoint 無效<br /> 2. 資源不存在，亦即 `沒有資料`。一般而言，單筆資料回傳結構，例如 `https://api.example.com/v1/users/0`，若無資料時，會搭配使用此狀態碼|
| 409 Conflict | 請求與目前伺服器端的狀態衝突<br /> 1. 上傳檔案舊蓋新，導致版本衝突<br /> 2. DB 資料唯一性檢查，相同資料重複新增導致衝突 |
| 500 Internal Server Error | 1. 後端應用程式有處理到的例外。如商業邏輯的檢查不通過，此時不應直接拋出 500 至 client，應以 4XX 回應訊息<br />2. 未被明確捕捉到的錯誤情境，如 Query Timeout 之類的，才可拋出 `500`，但錯誤訊息應經過包裝後再回傳 |

!!!info "**`頁面轉導邏輯由前端 UI 層控制，API 不建議使用 3XX status code`**"