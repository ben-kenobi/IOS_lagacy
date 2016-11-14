# 设置过期日期

## 过期日期

* 在新浪微博返回的数据中，过期日期是以当前系统时间加上秒数计算的，为了方便后续使用，增加过期日期属性

* 定义属性

```swift
/// token过期日期
var expiresDate: NSDate?
```

* 在 `expires_in` 的 `didSet` 方法里面给 `expiresDate` 赋值

```swift
var expires_in: NSTimeInterval = 0 {
    didSet{
        expiresDate = NSDate(timeIntervalSinceNow: expires_in)
    }
}
```

* 修改 `description`

```swift
let keys = ["access_token", "expires_in", "expiresDate", "uid"]
```

