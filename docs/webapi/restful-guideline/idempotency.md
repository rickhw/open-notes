### Idempotent
同樣的操作，意指相同的 request payload，執行第二次以上並不會改變結果

目的：避免 API 傳輸過程因網路延遲或其他因素，造成應用程式例外或資料不一致...等意料之外的錯誤

依 REST API 定義

* `POST` 方法用於建立 resource，相同 payload 執行 N 次，代表建立 N 個 resources，因此 `POST` API 不是 idempotent
* `PATCH` 方法主要用於 partial update，在某些情境下，第二次執行的結果不一定與第一次相同，因此 `PATCH` API 不是 idempotent

```
    // 舉例說明，無實作 idempotent 的副作用
    // 此 API 採用差異量更新庫存，若無實作 idempotent 機制，有機會重複更新，導致庫存量錯誤

    POST https://api.abc.com/product/v1/product:update-stock
    {
        "Id": 21248,
        "SkuId":22591,
        "OuterId":null,
        "ChangeValue": "-2"
    }
```

### 實作建議
* 除 `GET` 或部份用於取得資料的 `POST` API 外，建議應實作 Idempotent
* 使用自定義的 Request Header **`XN-IDEMPOTENCY-KEY`** 帶入，建議可用 UUID 或其他可識別唯一值作為參數
* **`XN-IDEMPOTENCY-KEY`** Header 非強制要求，實務上若對資料正確性有嚴格要求，例如，`庫存差異更新` 應考慮實作 `idempotent` 特性
