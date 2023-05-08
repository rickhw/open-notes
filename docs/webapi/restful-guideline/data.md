REST API Content Type 以 JSON format 為主流，以下依 JSON 規範說明
### JSON 的資料型別
#### string
```
{
    "name":"John"
}
```
#### number
```
{
   "age":30
}
```
#### object (JSON object)
```
{
   "employee":{
      "name":"John",
      "age":30,
      "city":"New York"
   }
}
```
#### array
```
{
   "employees":[
      "John",
      "Anna",
      "Peter"
   ]
}
```
#### boolean
```
{
   "sale":true
}
```
#### null
```
{
   "middlename":null
}
```

### 統一規範
- `boolean` 請**不要使用字串**表示
```
{ "sale": true }        // Good
{ "sale": "true"}       // Bad
{ "sale": "false" }     // Bad
```
- `日期` `時間` 建議使用 [ISO 8601](https://zh.wikipedia.org/wiki/ISO_8601){target=_blank} / [RFC3339](https://medium.com/easyread/understanding-about-rfc-3339-for-datetime-formatting-in-software-engineering-940aa5d5f68a){target=_blank} 建議的字串表示格式，且應一律採用 UTC 時間表示
```
{
    "createdAt": "2022-01-25T16:34:41.000Z"
}
```
- `ENUM` 列舉，建議將列舉值轉為字串顯示傳遞
```
// C#
public enum Color
{
    WHITE,
    BLACK,
    RED,
    YELLOW,
    BLUE
}

// JSON
{
    "color": "WHITE"    // Good
}

{
    "color": 0          // Bad
}
```
- 地理位置 `經度` `緯度` 建議使用 [ISO 6709](https://zh.wikipedia.org/wiki/ISO_6709){target=_blank} 建議格式
```
{
    // 自由女神像的經/緯度
    "statueOfLiberty": "+40.6894-074.0447"
}
```