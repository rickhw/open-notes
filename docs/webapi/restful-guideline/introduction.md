### 概述
REST，全名 Representational State Transfer (表現層狀態轉移)，是一種設計風格，由 Roy Fielding 在西元 2000 年時提出。RESTful 是形容詞，遵循 REST 定義的風格、規範所設計的 Web API，稱之為 RESTful API


### 基於 HTTP 設計 REST API 主要原則

* 依照「資源」來設計，而資源是指可由用戶端存取、任何類型的物件、資料或服務。REST 的核心就是將一切事物抽象化成「資源」這個概念，一切的操作皆是以資源為中心，可以新增它、修改它，甚至刪除它。
* 資源具有「識別碼」，也就是可唯一識別該資源的 URI。例如，特定客戶訂單的 URI 可能是：
```
https://api.example.com/orders/A01
```
* 用戶端透過交換資源的「表示法」(representations) 與服務進行互動，通常使用 JSON 作為交換格式。例如，上列 URI 的 GET 要求，可能會傳回以下回應
```
{
   "orderId":A01,
   "orderPrice":99,
   "productId":1,
   "quantity":1
}
```
* REST API 使用統一的介面，有助於讓用戶端與服務實作分離。對於建置在 HTTP 上的 REST API，統一的介面包括使用標準 HTTP 指令動詞在資源上執行作業，常見的指令包括 GET、POST、PUT、PATCH 和 DELETE。
* REST API 會使用無狀態要求模式 (Stateless)。HTTP 要求應該是獨立的，而且可能會以任何順序發生，因此保留多個要求之間的暫時性狀態資訊是不恰當的做法。

>2008 年，Leonard Richardson 針對 Web API 提出了[成熟度模型](https://martinfowler.com/articles/richardsonMaturityModel.html){target=_blank}
>
* Level 0：定義一個 URI，而所有的作業對此 URI 都是 POST 要求
* Level 1：Resources，針對個別資源建立不同的 URI
* Level 2：HTTP Verbs，使用 HTTP 方法來定義資源上的作業
* Level 3：Hypermedia Controls，使用超媒體，HATEOAS (Hypertext As The Engine Of Application State)

!!!info "*根據 Roy Fielding 的定義，API 設計需滿足 Level 3 要求，才能說是真正的 RESTful API*"

### HATEOAS
```
GET https://api.example.com/customers/11111

{
    "customer": {
        "customerId": 11111,
        "gender": male,
        "links": {
            "href": "/shops/s001",
            "rel": "shops",
            "method": GET
        }
    }
}
```
上述是一個符合 HATEOAS 定義的 API 回傳範例，API response payload 包含了 `links` 資訊 (需符合 [Link Description Object (LDO)](https://json-schema.org/draft/2019-09/json-schema-hypermedia.html#ldo){target=_blank} schema)，表述除原請求之外，客戶端可以從 Response payload 中，知道還有哪些其他相關的資源，以及如何對它進行操作API。因此，Client side 不需要知道 Server side 的商業邏輯，透過每次的請求，Response 會包含所有可以繼續執行的操作，也就是說，接下來可以做什麼，由 Server side 告訴你。

### Reference
* [你的 REST 不是 REST?](https://www.ithome.com.tw/voice/128528){target=_blank}
* [REST dissertation by Roy Fielding](https://www.ics.uci.edu/~fielding/pubs/dissertation/rest_arch_style.htm){target=_blank}
* [一把梭：REST API 全用 POST?](https://coolshell.cn/articles/22173.html){target=_blank}