# 用户账户模型


## 加载AccessToken

* 在 `HMOAuthViewController` 中增加函数加载 `AccessToken`

```swift
/// 加载AccessToken的方法
///
/// - parameter code: 授权码
private func loadAccessToken(code: String){
    let urlString = "https://api.weibo.com/oauth2/access_token"

    // 定义参数
    let params = [
        "client_id": WB_APPKEY,
        "client_secret": WB_APPSECRET,
        "grant_type": "authorization_code",
        "code": code,
        "redirect_uri": WB_REDIRECTURI]

    NetworkTools.shareTools.request(.POST, url: urlString, params: params) { (result, error) -> () in
        print(result)
    }
}
```
* 在获取授权码成功之后调用方法

```swift
// 判断是否包含 'code=' 字样
if let query = request.URL?.query where query.containsString("code=") {
    // 截取授权码
    let code = query.substringFromIndex("code=".endIndex)
    print("请求码：\(code)")
    // 请求AccessToken
    loadAccessToken(code)
}else{
    // 用户点击了取消授权，直接关闭页面
    self.close()
}

```
> 运行测试

* 返回错误信息

```
Error Domain=com.alamofire.error.serialization.response Code=-1016 "Request failed: unacceptable content-type: text/plain"
```
* 在 `HMNetworkTools` 单例初始化时设置反序列化数据格式

```swift
static let shareTools: HMNetworkTools = {
    let tools = HMNetworkTools()
    tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
    return tools
}()
```

## 定义 HMUserAcount 模型
* 在 `Model` 目录下添加 `HMUserAccount` 类
* 定义模型属性

```swift
/// 用户帐号模型
/// - see: [http://open.weibo.com/wiki/OAuth2/access_token](http://open.weibo.com/wiki/OAuth2/access_token)
class HMUserAccount: NSObject {

    // 用于调用access_token，接口获取授权后的access token
    var access_token: String?
    // access_token的生命周期，单位是秒数
    var expires_in: NSTimeInterval = 0
    // 当前授权用户的UID
    var uid: String?

    init(dict: [String: AnyObject]) {
        super.init()

        setValuesForKeysWithDictionary(dict)
    }

    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
}
```

* 创建用户帐号模型，在 `HMOAuthViewController` 的网络回调代码中添加如下代码

```swift
let account = HMUserAccount(dict: result as! [String: AnyObject])
print(account)
```

* 调试模型信息

* 与 OC 不同，如果要在 Swift 1.2 中调试模型信息，需要遵守 `Printable` 协议，并且重写 `description` 的 `getter` 方法，在 Swift 2.0 中，`description` 属性定义在 `CustomStringConvertible` 协议中

```swift
override var description: String {
    let keys = ["access_token", "expires_in", "uid"]
    return dictionaryWithValuesForKeys(keys).description
}
```
> 建议description此代码抽取到Xcode的代码块中，方便使用

