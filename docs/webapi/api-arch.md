
## 架構設計考量

1. 資安防禦
    1. 抵擋 DDoS 攻擊
    2. 依照條件，過濾不必要的請求
    3. 具備資料快取能力
2. 路由控制
    1. 分流管理：依照 `版本 (Versioning)` 與 `服務 (Services)` 執行流量分流
        * `版本` 層級由 CDN 分流
        * `服務` 層級由 API Gateway 分流
    2. URL Mapping：給使用者的 URL Path 與 `內部 Backend Path` 可以透過 Mapping 方式重新封裝，提供新舊系統相容，未來可以移轉。
3. 認證授權：CCA 處理 [WebAPI 通訊模式](../general/webapi-commuication.md) 定義 的 `路徑一`，但是包含以下兩種情境，提供不同的 `控制類型 (ACL, Access Control List)`
    * `Public`: Server to Server：外部系統 (Backend) 與 企業 系統直接調用，沒有 Session Token。
    * `Protected`: 有使用者登入，也就是包含 Session Token



## 架構藍圖

下圖描述目前架構的設計藍圖：

![](/images/nineyi.general/webapi/arch_v20210929.png)

出處：[CCA API Auth Protocol Spec Version v1.0 (2021/Q3)][1]

1. `綠色`：使用 企業 API 的系統，通稱 `Postman`。Postman 可以是外部的 Partners 、或者 企業 內部系統。
2. `藍色`：`架構設計部` 提供的服務，包含 Session Service、Token Service ...
3. `橘色`：`基礎架構部` 提供的服務，主要以 CDN + API Gateway 為主，負責處理導流、認證授權控制等機制。


---

## 技術架構 與 權責

![](/images/nineyi.general/webapi/url-path-rules_v20210929.png)


| 分層 | 職責 | 實踐技術與方法 | 團隊
|-----|------|--------------|-----
| Endpoint | 負責: 資安防禦、效能，像是 DDoS 以及資料快取。 | CDN (AWS CloudFront) + WAF | Infra
| Version + Service | 負責以下部分：<br /> 1. URL Mapping<br />2. 路由控制<br />3.1 使用者 Session 的認證授權，或者<br />3.2 API Token 的認證授權處理 | 1. Amazon API Gateway (Managed Service)<br />2. Session Service (Self-Hosted)<br />3. Token Service (Self-Hosted) | Infra<br />Arch
| REST APIs | 負責接收已經允許的請求、處理商業邏輯 | 各個 Backend Services | 各個 Feature Teams



### URL Path Rules

Format: `/{VERSION}/{SERVICE}/api/{RESOURCE_TYPE}`

* `VERSION`: v1, v2, v3 ... etc.
* `SERVICE`: member, product, order, ... etc
* `RESOURCE_TYPE`: REST API Name


### Reserved APIs

所有 Services 都要提供以下標準 APIs:

* `/{VERSION}/{SERVICE}/_hc`: Health Check
* `/{VERSION}/{SERVICE}/_releng`: 版本資訊

