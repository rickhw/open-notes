# RESTful API Design Guideline (drafting)

## Objectives & Principles

* 訂定一個遵循 RESTful 原則的指引
* 透過 API Definition Language - Swagger 來維護 API 定義及版本控制
    * 幫助使用工具自動化產生文件
    * 便利取得 API Client Sample / SDK
* API Design First approach. Coding by contract, coding by interface concept
* Most of the RESTful principles are applied, with some tolerance.
* Swagger 2.0 or 3.0 is required to code the API doc
    * 由於 3.0 定案不久，目前 2.0 工具支援較完整


## I. API endpoints

* scheme
    * http | https
* host
    * hostname, e.g. info.api.91dev.tw
* basePath
    * 該組 API 共用之 path prefix, 其中分成兩部分
        * 第一部分為 path, 如果可以的話, 該組 API 應使用專有 hostname, 使得 path 可以直接是 /
        * 第二部分用來區分版本 (versioning), 以 v 開頭, 可使用 semantic versioning, 細節請見 versioning section, e.g.
            * /v1
            * /v1beta
            * /v1.1.1alpha
* remain parts
    * 接著為不同 API routes
        * 建議使用 resource based 加上 HTTP Verbs 的方法來描述, 而不要使用動詞加名詞的命名方式 e.g.
            * GET /photo/1
            * POST /photo
            * DELETE /photo/2
            * /GetPhoto/3 => don't
        * API routes 後, 如果有用 query string 傳入參數, 就是 name/value pairs, e.g. ?skip=10&take=20

## II. Request with HTTP verbs

* 使用 GET, POST, PUT, DELETE 作為該 API 對應的 CRUD action  (注意！並非完全一對一對應)
    * GET 用在取得 resource 或 resource list 或 資料 object
        * 由於 GET 在規範上不允許傳入 body, 所以應該僅能由 route path 或 query string 傳入參數
            * 例外實作：Elastic search API 接受  GET + post body 來傳送 搜尋參數, 但使用 postman 的話介面不允許
        * 但如果使用 query string 傳入參數有長度限制 (2k), 如果真的需要傳送的參數總長會超過, 請使用 POST 方法透過 body 傳送, 需注意這樣可能在 cache 機制上無法有 unique key 可直接運用 (Restful Safe 特性)
    * POST 用於新增一筆全新 resource,  並且是提供所有 resource 欄位時使用, e.g. POST /photo
        * 參數可用 query string, form data, x-www-form-urlencoded, 或 raw json body 傳送
    * PUT 用於更新資料時使用, e.g. PUT /photo/123
        * 參數可用 query string, form data, x-www-form-urlencoded, 或 raw json body 傳送
    * DELETE 用於刪除一筆 resource 時使用, e.g. DELETE /photo/111
    * PATCH 用於更新部分資料，但因為有些 Client 不支援，可視情況使用
    * HEAD
    * OPTIONS


## III. Responses

* 以上 GET, POST, PUT, DELETE 動作完成後, 會有兩個需要回應的資料
    * Status Code, 在一些基本的錯誤回應上請盡可能使用這些 code 來表達, 無法以 status code 表示的才將該資訊放入 response body
        * 200: Ok. 執行成功
        * 400: Bad request, 如參數驗證錯誤,  無法執行該操作
        * 401: Unauthorized, 認證錯誤, 無此權限
        * 404: Not found, 該方法不存在(沒有controller可處理該route), (有controller可處理該request, 但)資料不存在或是查詢條件下查無資料
        * 500: Internal Server Error, 通常是 web server 有問題,  該request 並未進到 controller 程式中處理
        * 其餘 status code 可依狀況使用
    * Response Body
        * 請一律以 JSON 格式回傳資料
        * 如果執行成功但無資料需回傳可使用 status code 204 with empty body


## IV. RESTful API 基本特性 (必須遵守)

* Stateless
    * 簡單來說就是不使用類似 session 的機制來儲存狀態，以供API Calls分享。如果有需要應該使用 Redis 或其他方式處理，這也是為了 Scaling & Load Balancing 的目的
* Atomic
    * 類似 transaction 的概念，執行完一個 request (API call) 之後不可以讓 server 數據處於不一致之狀態
* Idempotent
    * 意即同樣的操作執行第二次以上並不會改變結果
        * POST, PATCH 則無需遵循此原則，但是若有網路不穩的狀況，必須要有方法讓 server 端判斷重複，如timestamp
* Safe
    * Safe 特性會影響是否可以快取
        * GET, HEAD 是 Safe 操作
        * POST/PUT/PATCH/DELETE 一定都不可以快取

## V. Authentication & Authorization

* APIKey
* OAuth
* Bearer
    * JWT
* 補充
    * 參數傳入的方式還可以使用 header, 通常是身份認證使用(也可以用於版本), 使用 header 在 CDN 或經過 RP 時須注意其副作用


## VI. API Versioning

* as URL path root, e.g. /v1/
* Semantic versioning: v[major].[minor].[patch], minor / patch 如為 0 則省略
    * Major: breaking changes, no backward compatibility
    * Minor: needs backward compatibility
        * Thus, extend fields is only acceptable
    * Patch: fix bugs, may break compatibility, 盡量不要
* 不同版本的API是有機會同時存在並同時服務的 (此指 Major)，所以在資料面可能必須有相容性的設計，但必須訂定 retire 時間才能降低維運的複雜度與成本
* 與 Scrum sprint 流程結合的一般性建議
    * 新專案開始
        * 第一版定為 v1.0, 與 API user 說明討論後, 公布之
        * 到下一個 sprint 之前, 若有修改直接覆蓋原文件, 並修改版本為 v1.0.1, v1.0.2, 依序增加 patch no, 以讓 API user 明顯地知道有所變更, 需做對應之修改
        * 新的 sprint 開始, 則定為 v1.1, patch 為 v1.1.1, v1.1.2, ...
    * 該 sprint 結束時, 版本停在最後, 如 v1.1.3
    * 專案結束亦同, 版本可停留在如 v1.3.4, 如果確認已可 finalized 不再修改, 可簡化收斂為 v1
    * 若有新專案需修改這一組 API, 便由 v2.0 開始, 並注意到上所說不同 Major 版本需要同時服務的問題

## VII. 開始設計 API

* 利用編輯器直接撰寫
    * 線上編輯器: http://editor.swagger.io
    * Atom Plugin
    * VS Code Plugin
* 利用 GUI 來設計，再轉成 Swagger 2.0 YAML
    * Restlet Studio: https://studio.restlet.com/
    * Stoplight: http://stoplight.io/platform/design/

## IIX. Resource Based Design / Naming Suggestion

## IX. API Design Review Flow

## X. API Doc Generation (and publish to Developer Portal)

## XI. 企業 四種 API

* 給後台 web ajax 使用
    * 實作框架：Web API
    * 認證方式：
* 給 app/前台 web ajax 使用
    * 實作框架：.Net MVC with output cache
    * 認證方式：auth cookie
* 給廠商使用, SCM API
    * 實作框架
    * 認證方式
* 其他 API using swagger
