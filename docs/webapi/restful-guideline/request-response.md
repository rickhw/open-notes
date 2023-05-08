
### Request

* HTTP request 參數傳遞方式 (by HTTP method)

| HTTP method | Purpose | query string / routing path | form-data | x-www-form-urlencoded | raw (json) |
|:------------|:--------|:---------------------------:|:---------:|:---------------------:|:----------:|
| GET         | 取得 Resource | V`優先` | | | |
| POST        | 新增 Resource | V | V | V | V`優先` |
| PUT         | 更新 Resource (Replace) | V | V | V | V`優先` |
| PATCH       | 更新 Resource (Partial) | V | V | V | V`優先` |
| DELETE      | 刪除 Resource | V`優先` | | | |

!!!info "The maximum length of the query string, in number of characters. The default is 2048."

* HTTP request headers (by Company)

| Request headers       | Purpose                                            |
|:----------------------|:---------------------------------------------------|
| XN-TRACE-ID           | `Request id` 追蹤問題用、具唯一性的識別代碼。同一個 payload 即使重覆呼叫多次，此 ID 也應該要不同 |
| XN-SPEC-VERSION       | API 規格版本，API 規格給合作夥伴實作，應明確宣告規格版本以利識別 |
| XN-IDEMPOTENCY-KEY    | `idempotent` 若重送請求時，供接收方做對應處理，避免重覆請求產生副作用 |
| XN-DATA-SIGNATURE     | 資料簽章，確保 request payload 在傳送過程中，沒有被篡改。 |


### Response
GET / POST / PUT / PATCH / DELETE 動作完成後，應依執行結果回傳對應的 [HTTP Status Code](status-code.md)

#### API 執行成功

* 回傳 HTTP status code 2XX
* OK Response Payload 可選擇下列兩種格式

##### $ 回傳固定格式資訊
```
// JSON schema
{
   "type":"object",
   "properties":{
      "code":{
         "type":"string"
      },
      "data":{
         "type":"array"
      }
   },
   "required":[
      "code",
      "data"
   ]
}
```
```
// 範例
HTTP/1.1 2XX
Content-Type: application/json

{
    "code":"Success",
    "data": [
        {
            "propertyA": "my data"
        }
    ]
}
```
!!!info "說明"
    1. `data` 資料結構可以是 `array` `JSON object`或`空值`
    2. `POST 新增資料`執行成功 `data` 應包含該次新增資料的識別欄位，如 `{"id": 1234}` ...之類的資訊"

##### $ 不回傳 (ex. HTTP DELETE 204, No Content) 或直接回傳 API 要回應的資料 (但仍需是 json 格式)
```
HTTP/1.1 2XX
Content-Type: application/json
```

#### API 執行失敗
* 回傳 HTTP status code 4XX / 5XX
* Failed Response Payload 需依下列固定格式回傳相關訊息

!!!warning "注意事項"
    Failed Response Payload 區分兩種格式。`格式 A`為舊版本向前相容；目前以`格式 B`為主，請留意！

```
// 格式 A：JSON schema
{
   "type":"object",
   "properties":{
      "errorCode":{
         "type":"string"
      },
      "messages":{
         "type":"array"
      }
   },
   "required":[
      "errorCode",
      "messages"
   ]
}
```

```
// 格式 A：範例
HTTP/1.1 4XX / 5XX
Content-Type: application/json

{
    "errorCode":"InvalidUser",
    "messages": [ "your error message", "additional info" ]
}
```

```
// 格式 B：JSON schema
{
   "type":"object",
   "properties":{
      "errorCode":{
         "type":"string"
      },
      "message":{
         "type":"string"
      },
      "data":{
         "type":"object"
      },
      "detailErrors":{
         "type":"array"
      }
   },
   "required":[
      "errorCode",
      "message"
   ]
}
```
```
// 格式 B：範例一
HTTP/1.1 4XX / 5XX
Content-Type: application/json

{
   "errorCode":"InvalidUser",
   "message":"your error message"
}
```

```
// 格式 B：範例二
HTTP/1.1 4XX / 5XX
Content-Type: application/json

{
   "errorCode":"InvalidInputs",
   "message":"Invalid inputs.",
   "data":{
      "phone":"+886"
   }
}
```

```
// 格式 B：範例三
HTTP/1.1 4XX / 5XX
Content-Type: application/json

{
   "errorCode":"InvalidInputs",
   "message":"Invalid inputs.",
   "detailErrors":[
      {
         "errorCode":"InvalidPhone",
         "message":"Phone(+886) was invalid.",
         "data":{
            "phone":"+886"
         }
      },
      {
         "errorCode":"InvalidEmail",
         "message":"Email(@@) was invalid.",
         "data":{
            "email":"@@"
         }
      }
   ]
}
```

!!!info "說明"
    1. `errorCode` 採 PascalCase 命名規則，每一個單字的首字母都使用大寫，無 underscore (_) 或其他連接字元。如 `InvalidMemberCode`。命名時，應把握 `Expressive` & `Simple` 原則
    2. `messages` 資料結構可以是 `array` 或單一 `JSON object`


