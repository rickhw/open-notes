REST API 是依照「資源」來設計，用來識別該資源的 URI (Uniform Resource Identifiers) 應具備以下原則

### Resource URI 命名依據名詞而非動詞
例如，在一個 e-commerce 系統中，主體可能包含客戶與訂單。可藉由傳送包含訂單資訊的 HTTP POST 要求來建立訂單， HTTP 回應則會指出訂購成功與否。Resource URI 應該要依據名詞 (the resource) 而不是動詞 (the operation on the resource) 來定義。

```
-- Good
https://api.example.com/orders

-- Bad
https://api.example.com/create-order
```

### Singleton and Collection Resources
Resource 可以是單一 (Singleton) 或一群集合 (Collection)

```
-- collectoin resource
https://api.example.com/orders

-- singleton resource
https://api.example.com/orders/ts1234
```

Resource 也可能包含 sub-collection resource (子集合)

```
-- contain sub-collection
https://api.example.com/customers/m001/orders

-- more complicated
https://api.example.com/customers/m001/orders/ts5678
```
>在設計「資源」時，常常會習慣直接和資料庫的資料表 (Table) 直接做對應，但事實上這個作法並不恰當，因為資料庫是內部使用的概念，不應該直接暴露給外界。由於概念上的「資源」和內部實作的資料結構不一定能直接對應，所以資料庫的「資料表」和「資源」也不見得會一樣。兩者有可能沒辦法直接一對一對應，有時一個「資源」可能會同時關聯多個「資料表」，也可能反過來，多個「資源」對應同個「資料表」。內部開發者和外部開發者使用者是完全兩個不同的角色，因此在設計與使用上，思考的角度是不一樣的，內部開發者容易開發使用不代表外部開發者容易串接；反之，外部開發者容易串接的 API，內部開發者也不一定容易做到。在設計時，掌握「資源」對外界來說概念是否清晰至關重要。

URI 應採用一致的命名慣例。一般而言，建議在集合的 URI 中，使用**複數名詞**

### URI 路由階層應單純
基於 API 的應用彈性與可維護性，應避免設計階層太複雜的 URI

 * /customers 是所有客戶集合的路徑
 * /customers/5/orders 可能代表客戶編號 5 的所有訂單，參數化的路由可定義為 /customers/{id}/orders
 * /customers/1/orders/99/products 意指要找到顧客編號 1 的所有訂單，並取得其訂單編號 99 所購買的商品。這樣的路由複雜度較高，相對地也較缺乏彈性，建議儘可能減少這類設計
 * Resource URI 路由階層建議少於 2 層

### 實務應用
依 REST API 定義，用 HTTP 動詞表述要對資源操作的意圖，也就是 `Resource-Oriented`，乍看之下似乎簡單並不困難，但實務上要完全遵循這個 pattern 定義 URI，有時並不件容易的事，畢竟業務邏輯相對複雜，並非總是單純的 CRUD 操作

舉例說明 `會員帳號合併`，要單純用 `Resource-Oriented` 的概念設計，可能會遇到難以清楚表述商業邏輯的冏境。這種情況可以採用 `RPC-based` 或 `task-based` 的方法，用 `business-centric` 的角度來幫助思考 API 設計

```
  // RPC-based design
  POST  /api/members/merge-member-account

  // task-based (command-based) design
  POST  /api/members/{id}/merge
```

!!!info "補充說明"
    現實的業務場景通常複雜的多，實務上，不大可能完全遵循 REST API 的設計規範(或說是建議)。因此 API Guideline 並不硬性規定一定要以 Resource-based 原則設計所有 API