
# API Auth Protocol

## 前言

* 因應 API First 計畫所設計統一的認證授權機制，稱為 `API Auth Protocol`。


### 角色定義

![](/images/nineyi.general/webapi/role_v20220707.png)


1. `API Providers`: 泛指 企業 提供 API 服務的團隊 (服務)，像是 member、order、notification center、ims … etc
    * 理想 `一個團隊` 對應 `一個服務`
1. `API Invokders`: 使用 企業 API 的 使用者 (系統)
    * 客戶系統 跟 跟 企業 系統對接
        * 客戶自己的 IT
        * 客戶外包的 IT
    * 企業 的 Partners 系統 跟 企業 系統對接
1. `API Management`: 使用 企業 Platform 管理 API KEY 的角色
    * 內部：HD / OD
    * 客戶：商店後台管理員
1. `API Platform`: 泛指 企業 負責管理 API 的基礎服務，包含以下：
    * Infra: API Gateway、InfraAPI
    * Arch: Token Service、Token Management

<!-- 
### 版本定義

* `版本` 指的是 整個 Auth Proto 的版本
    * 使用者看到的版本是 API 本身的版本。Auth Proto 是類似於 HTTP/1.0 這種概念。
    * API 版本由產品 PO 負責管理控制，Auth Proto 則由架構負責。
* 已經發行版本:
    * v1.0 (2021/09): 為初版 Auth Proto 規格。
    * v1.1 (2022/06): 新增 AuthType，用以支援 IMS 需求，詳細規格參閱 [API Auth Protocol Spec Version v1.1][2]
    * v2.0 (2022/09): [API Auth Protocol Spec Version v2.0][3] -->

<!--

## 認證與授權機制

1. 使用者 的 Session Token：`登入後` 的操作的行為，登入的方式可能是 UI 登入，或者透過其他形式。登入之後取得 User Session Token，然後執行的操作與行為。
2. Serverside to serverside (S2S) 的通訊：無論是否登入，單純是 Serverside to Serverside 的溝通。


上述兩者分別定義了 存取控制 (ACL, Access Control List) 如下：

| ACL | 定義 | 資安防禦 | 使用者認證 | 授權 |
|-----|-----|---------|-----|-----
| Public | Serverside to Serverside (S2S) 通訊。 | x-api-key | N/A | XNAPI-Token
| Protected | 需要 User Session 的 Serverside to Serverside (S2S) 通訊。 | x-api-key | XNSESSION-TOKEN | XNAPI-TOKEN

-->
