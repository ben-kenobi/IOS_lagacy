# 字符串

> 在 Swift 中绝大多数的情况下，推荐使用 `String` 类型

* String 是一个结构体，性能更高
    * String 目前具有了绝大多数 NSString 的功能
    * String 支持直接遍历
* NSString 是一个 OC 对象，性能略差
* Swift 提供了 `String` 和 `NSString` 之间的无缝转换

## 字符串演练

* 遍历字符串中的字符

```swift
for s in str.characters {
    print(s)
}
```

* 字符串长度

```swift
// 返回以字节为单位的字符串长度，一个中文占 3 个字节
let len1 = str.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
// 返回实际字符的个数
let len2 = str.characters.count
// 返回 utf8 编码长度
let len3 = str.utf8.count
```

* 字符串拼接
    * 直接在 "" 中使用 `\(变量名)` 的方式可以快速拼接字符串

```swift
let str1 = "Hello"
let str2 = "World"
let i = 32
str = "\(i) 个 " + str1 + " " + str2
```

> 我和我的小伙伴再也不要考虑 `stringWithFormat` 了 :D

* 可选项的拼接
    * 如果变量是可选项，拼接的结果中会有 `Optional`
    * 为了应对强行解包存在的风险，苹果提供了 `??` 操作符
    * `??` 操作符用于检测可选项是否为 `nil`
        * 如果不是 `nil`，使用当前值
        * 如果是 `nil`，使用后面的值替代

```swift
let str1 = "Hello"
let str2 = "World"
let i: Int? = 32
str = "\(i ?? 0) 个 " + str1 + " " + str2
```

* 格式化字符串
    * 在实际开发中，如果需要指定字符串格式，可以使用 `String(format:...)` 的方式

```swift
let h = 8
let m = 23
let s = 9
let timeString = String(format: "%02d:%02d:%02d", arguments: [h, m, s])
let timeStr = String(format: "%02d:%02d:%02d", h, m, s)
```

## String & Range 的结合

* 在 Swift 中，`String` 和 `Range`连用时，语法结构比较复杂
* 如果不习惯 Swift 的语法，可以将字符串转换成 `NSString` 再处理

```swift
let helloString = "我们一起飞"
(helloString as NSString).substringWithRange(NSMakeRange(2, 3))
```

* 使用 Range<Index> 的写法

```swift
let startIndex = helloString.startIndex.advancedBy(0)
let endIndex = helloString.endIndex.advancedBy(-1)

helloString.substringWithRange(startIndex..<endIndex)
```
