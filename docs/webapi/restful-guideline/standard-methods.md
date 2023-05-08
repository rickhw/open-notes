### Standard methods overview

| Name  | Behavior                      | HTTP method mapping |
|:------|:------------------------------|:--------------------|
|Get    |Retrieves an existing resource |GET                  |
|List   |Lists a collection of resources|GET                  |
|Create |Creates a new resource         |POST                 |
|Update |Updates an existing resource   |PATCH                |
|Delete |Removes an existing resource   |DELETE               |
|Replace|Replaces an entire resource    |PUT                  |

!!!info "使用 standard methods 設計 API 時，應儘可能遵循 HTTP 定義，使用相對應的 HTTP method"
