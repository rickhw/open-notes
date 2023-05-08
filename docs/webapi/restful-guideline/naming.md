命名是 API 設計的重要環節，因為 API 一旦發佈正式使用後，要修改命名是相當不便的一件事，同時也容易破壞內、外部物件的穩定度

### 良好的 API 命名基本原則

* Expressive

    良好的表達詞意，使用有意義的英文單字或語句，儘可能不要使用縮寫 (除非是業界通用名詞)

* Simple

    簡單，去除無意義且重覆的單詞


    | Name        | Note           |
    |:------------- |:-------------|
    | UserSpecifiedPreferences | Expressive, but not simple enough |
    | UserPreferences | Simple enough and expressive enough |
    | Preferences | Too simple |
    *Trade-off between Expressive and Simple*

* Predictable

    可預測性，在同一組 API 集合裡，命名應保持一致，它代表的是相同的意義，才不致於造成 API 使用者混淆。

    舉例： **`topic`**。如果在同一組 API 裡，`topic` 指的是 kafaka messages 意思，那麼整組 API 的意義就應該要保持一致，雖然我們都知道 `topic` 在其他領域有不同的意思

### Endpoint 命名規範
!!!warning "Mandatory"
* Use nouns

    URI 命名建議使用名詞而非動詞。API 的意圖或動作應由 HTTP methods (GET, POST, PUT...) 決定

```
    [HTTP method] https://api.example.com/[resource]

    POST https://api.example.com/orders            // Good

    POST https://api.example.com/create-order      // Bad
```

* Use intuitive, clear names

    命名應清楚、直覺且最好對齊商業慣用語，避免使用奇怪或簡化模糊的語詞表述

```
    GET https://api.example.com/users/1234/fn

    // 表述取得編號 1234 使用者的 first name ?
    // fn 命名太精簡，不夠直覺
```

* Use lowercase letters

    依據 [RFC 3986](https://www.rfc-editor.org/rfc/rfc3986){target=_blank} 定義，除了 **`scheme`** 及 **`host`** 不區分大小寫外，URI 其他部分應大小寫有別，且應以**`小寫`**為主。

* Avoid special characters

    URI 不應使用空白(%20)或特殊字元(非 ASCII character set)

* Use plural nouns appropriately

    Forward slash (/) 代表 URI hierarchy，resource collection 命名應使用複數名詞，如下述範例中的 `users`，在解讀 API 用途時，會更清晰直覺

```
    GET https://api.example.com/users/1234/first-name

    // API 設計採用階層式結構，表述取得編號 1234 使用者的 first name
```


* Separate words with hyphens (-)

    當 endpoint 名稱包含多個單字時，建議使用 hyphens (-) 分隔，而非 camelCase

```
    GET https://api.example.com/users/1234/first-name           // Good

    GET https://api.example.com/users/1234/firstName            // Bad
```

* Use camelCase for parameters

    設計 API endpont 參數化路由時，路由或 querystring 參數建議使用 camelCase

```
    GET https://api.example.com/users/{userId}

    GET https://api.example.com/users/1234
```

* Consistency

    同一組 API 的命名必須一致，以免造成 API 使用者混淆

### Payload 命名規範
*`[Note] JSON 不應包含註解，以下範例包含註解只是為了方便說明`*
!!!warning "Mandatory"
#### Terminology
- 屬性 (Property)：JSON payload 裡任一組 key / value pair 稱作一個 `屬性 (Property)`
- 屬性名 (Property Name)：屬性名稱，即 Key
- 屬性值 (Property Value)：屬性的值，即 Value

```
    {
        // a property
        "propertyName": "propertyValue"
    }
```
#### Property Name
- 命名時，把握 `Expressive` & `Simple` 原則
- 採 camel (駝峰式) 命名規則，無 underscore (_) 或其他連接字元。如 `memberCode`
- 首字符應為英文字母

#### Property Value
- 屬性值必須是 JSON 定義的資料型別
```
    - string
    - number
    - object (JSON object)
    - array
    - boolean
    - null
```