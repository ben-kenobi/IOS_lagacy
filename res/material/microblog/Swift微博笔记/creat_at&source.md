# 微博 时间&来源 格式化


## 微博来源格式化

- 在 `HMStatusViewModel` 添加存储型属性 `sourceText`

```swift
/// 来源字符串，存储型属性
var sourceText: String?
```

- 添加方法 `dealSourceText` 处理来源字符串的逻辑

```swift
/// 处理来源字符串
private func dealSourceText(){
    guard let source = status?.source else {
        return
    }
//        <a href="http://weibo.com" rel="nofollow">新浪微博</a>

    if let preRange = source.rangeOfString("\">") {
        if let sufRange = source.rangeOfString("</") {
            sourceText = "来自 \(source.substringWithRange(preRange.endIndex..<sufRange.startIndex))"
        }
    }
}
```

- 在 init 函数中执行此方法

```swift
/// 构造函数
init(status: HMStatus){
    super.init()
    self.status = status
    ...
    // 处理来源的字符串
    dealSourceText()
}

```

> 运行测试

## 时间格式化

### 显示逻辑

- 如果是今年
    - 是今天
        - 1分钟之内
            - 显示 "刚刚"
        - 1小时之内
            - 显示 "xx分钟前"
        - 其他
            - 显示 "xx小时前"
    - 是昨天
        - 显示 "昨天 HH:mm"
    - 其他
        - 显示 "MM-dd HH:mm"
- 不是今年
    - 显示 "yyyy-MM-dd"


### 步骤

- 将系统返回的字符串转 NSDate
- 使用 `NSCalendar` 对象计算 `今年`、`今天`、`昨天`
- 根据具体逻辑格式化具体字符串

### 代码实现

- 在 `HMStatusViewModel` 添加 **计算** 型属性 `createAtText`

```swift
/// 创建时间
var createAtText: String?
```
- 添加处理时间字串的方法

```swift
/// 处理创建时间的逻辑
private func dealCreateAtText(create_at: String) -> String? {

    /// 判断是否是今年
    func isDateInThisYear(targetDate: NSDate) -> Bool {
        let calendar = NSCalendar.currentCalendar()
        let comp = calendar.components(.Year, fromDate: targetDate, toDate: NSDate(), options: [])
        return comp.year < 1
    }

    // Tue May 31 17:46:55 +0800 2011
    // 初始化时间格式化器
    let dateFormatter = NSDateFormatter()
    // 指定格式化字符串
    dateFormatter.dateFormat = "EEE MM dd HH:mm:ss z yyyy"
    dateFormatter.locale = NSLocale(localeIdentifier: "en")

    // 微博创建时间 `NSDate` 类型
    let createDate = dateFormatter.dateFromString(create_at)!

    // 获取当前
    let calendar = NSCalendar.currentCalendar()

    // 如果是今年
    if isDateInThisYear(createDate) {
        // 如果是今天
        if calendar.isDateInToday(createDate){
            // 计算两个时间的差值
            let timeInterval = Int(NSDate().timeIntervalSinceDate(createDate))

            if timeInterval < 60 {
                return "刚刚"
            }else if timeInterval < 3600 {
                return "\(timeInterval / 60)分钟前"
            }else{
                return "\(timeInterval / 3600)小时前"
            }

        }else if calendar.isDateInYesterday(createDate){
            // 如果是昨天
            dateFormatter.dateFormat = "昨天 HH:mm"
            return dateFormatter.stringFromDate(createDate)
        }else{
            // 其他
            dateFormatter.dateFormat = "MM-dd HH:mm"
            return dateFormatter.stringFromDate(createDate)
        }
    }else{
        // 不是今年
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.stringFromDate(createDate)
    }
}
```

- 在 `createAtText` 的 `didSet` 里面返回值 （计算型属性）

```swift
/// 创建时间
var createAtText: String? {
    return dealCreateAtText(status!.created_at!)
}
```

- 在 `HMStatusOriginalView` 的 `statusViewModel` 的 didSet 方法里面设置数据

```swift
timeLabel.text = statusViewModel?.createAtText
sourceLabel.text = statusViewModel?.sourceText
```







