# Xcode 7 中的网络请求

# ATS 应用传输安全

App Transport Security (ATS) lets an app add a declaration to its Info.plist file that specifies the domains with which it needs secure communication. ATS prevents accidental disclosure, provides secure default behavior, and is easy to adopt. You should adopt ATS as soon as possible, regardless of whether you’re creating a new app or updating an existing one. <br /><br />If you’re developing a new app, you should use HTTPS exclusively. If you have an existing app, you should use HTTPS as much as you can right now, and create a plan for migrating the rest of your app as soon as possible.

## 强制访问

```plist
<key>NSAppTransportSecurity</key>
<dict>
  <!--Include to allow all connections (DANGER)-->
  <key>NSAllowsArbitraryLoads</key>
      <true/>
</dict>
```

## 设置白名单

```plist
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSExceptionDomains</key>
    <dict>
        <key>localhost</key>
        <dict>
            <key>NSTemporaryExceptionAllowsInsecureHTTPLoads</key>
            <true/>
        </dict>
    </dict>
</dict>
```

* 网络访问代码

```swift
let url = NSURL(string: "http://www.weather.com.cn/data/sk/101010100.html")!

NSURLSession.sharedSession().dataTaskWithURL(url) { (data, _, error) in
    if error != nil {
        print(error)
        return
    }

}.resume()
```

* 运行提示：App Transport Security has blocked a cleartext HTTP (http://) resource load since it is insecure. Temporary exceptions can be configured via your app's Info.plist file.

* JSON 序列化

```swift
let dict = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0))
print(dict)
```

* try catch

```swift
do {
    let tmpData = "{\"name\": \"zhangsan\"}".dataUsingEncoding(NSUTF8StringEncoding)
    let dict = try NSJSONSerialization.JSONObjectWithData(tmpData!, options: NSJSONReadingOptions[])
    print(dict)
} catch {
    print(error)
}
```
