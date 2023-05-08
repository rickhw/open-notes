### 版本管理原則
```
名詞定義
對內：API 程式本身的版本管理
對外：企業發行的 API 版本，即顯示在 API endpoint 上的版號
```
* 對內：[Semantic versioning](https://semver.org/lang/zh-TW/){target=_blank}: *[major].[minor].[patch]*

```
  Major: breaking changes, no backward compatibility
  Minor: needs backward compatibility. Thus, extend fields is only acceptable
  Patch: fix bugs
```
* 對外：版本僅揭露至 *[major]*

### URI Versioning
!!!warning "Mandatory"
企業 API 版本管理策略，透過 URI Path 設定，版本揭露在網址根路徑，例如 /v1，規則如下

![API Versioning](api-versioning-rule.png)

對 API 開發者 (RD) 而言，API 路由只需關注到 /api/info 這層，也就是 Resource Level

### API 版本變更原則
* 新發行 API 與前一版本不相容 (major, breaking change) 或即將以新版取代舊版，例如，以 v2 取代 v1，那麼建議最好對舊版本 API 設立一個 deprecation timeline，讓 API Client 有所依循可以順利轉移至新版本
* 假如 API 調整與前一版本相容 (minor or patch, non-breaking change)，則依照前一版號繼續使用，例如，版本依然是 v1
* 相同 API 模組，某特定 API 欲以新版本 (Breaking Change) 取代舊版，其他 API 皆不變的情況下
    * API Path versioning 不變，例如原 API Path `/v1/member/api/info`，**`v1`** 版號仍然不變
    * 請採用重新命名 API endpoint 的方式區別新舊版本。以前述例子，新版本 API 可命名為 `/v1/member/api/info2`
    * 若該模組下的多數 API (比如數量超過一半或三分之一以上) 會進行大幅度變更 (Breaking Change) 時，在這種情況下，整組 API 應全數更換版號，將 API Path 直接置換為 `/v2/member/api/info`，API Doc 亦應以全新版本的形式更新。
