# 视图模型

## 目标一：建立视图模型，抽取网络请求代码

* 建立用户账户的视图模型

```swift
/// 用户账户视图模型
class HMUserAccountViewModel: NSObject {

    /// 单例
    static let sharedUserAccount = HMUserAccountViewModel()

    /// 用户账户模型
    var userAccount: UserAccount?
}
```

* 抽取网络请求代码到视图模型中

```swift
/// 加载用户信息
///
/// - parameter code:    授权码
/// - parameter success: 加载成功回调
/// - parameter failure: 加载失败回调
func loadUserAccount(code: String, success: ()->(), failure: (error: NSError)->()){
    let manager = AFHTTPSessionManager()
    // 设置反序列化支持的格式
    manager.responseSerializer.acceptableContentTypes.insert("text/plain")

    // 定义URLString
    let urlString = "https://api.weibo.com/oauth2/access_token"

    // 定义参数
    let params = [
        "client_id": WB_APPKEY,
        "client_secret": WB_APPSECRET,
        "grant_type": "authorization_code",
        "code": code,
        "redirect_uri": WB_REDIRECTURI]

    // 发送post请求
    manager.POST(urlString, parameters: params, success: { (dataTask, result) -> Void in

        // 将返回字典转成模型
        let account = HMUserAccount(dictionary: result as! [String: AnyObject])
        print(account)

        // 请求用户数据
        self.loadUserInfo(account,success: success,failure: failure)

    }) { (dataTask, error) -> Void in
        failure(error: error)
        print(error)
    }
}


/// 请求用户信息
///
/// - parameter userAccount: 用户账号信息
/// - parameter success:     请求成功回调
/// - parameter failure:     请求失败回调
private func loadUserInfo(userAccount: HMUserAccount, success: ()->(), failure: (error: NSError)->()){
    let manager = AFHTTPSessionManager()
    // 设置反序列化支持的格式
    manager.responseSerializer.acceptableContentTypes.insert("text/plain")

    let urlString = "https://api.weibo.com/2/users/show.json"

    // 定义参数
    let params = [
        "uid": userAccount.uid!,
        "access_token": userAccount.access_token!
    ]

    // 发送get请求
    manager.GET(urlString, parameters: params, success: { (dataTask, result) -> Void in

        let dict = result as! [String: AnyObject]
        // 设置昵称与头像地址
        userAccount.name = dict["name"] as? String
        userAccount.avatar_large = dict["avatar_large"] as? String
        // 保存用户模型
        userAccount.saveUserAccount()
        // 设置到当前视图模型里面去
        self.userAccount = userAccount
        // 调用成功的回调
        success()
    }) { (dataTask, error) -> Void in
        print(error)
        // 调用失败的回调
        failure(error: error)
    }
}
```

* 修改 `HMOAuthViewController` 中的代码调用

```swift
// 请求  AccessToken以及用户数据
HMUserAccountViewModel.sharedInstance.loadUserAccount(code, success: { () -> () in
    self.close()
}, failure: { (error) -> () in
    print("请求失败:\(error)")
})
```
* 删除控制器里面 `loadAccessToken` 与 `loadUserInfo` 两个方法

> 控制器的代码简单了！

## 目标二：加载归档保存的 token，避免重复登录

* 抽取归档路径，并且实现解档方法

```swift
// MARK: - 保存 & 加载
/// 解档归档路径
private static let path = (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last! as NSString).stringByAppendingPathExtension("userAccount.archive")!

/// 归档保存当前对象
func saveUserAccount(){
    // 归档
    NSKeyedArchiver.archiveRootObject(self, toFile: HMUserAccount.path)
}

/// 解档当前对象
///
/// - returns:
class func loadUserAccount() -> HMUserAccount? {
    let account = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? HMUserAccount
    return account
}
```

* 在 AppDelegate 中添加以下代码测试

```swift
printLog(UserAccount.loadUserAccount())
```

* 代码优化，避免重复加载

```swift
/// 用于保存上一次解档出来的对象，避免重复加载
private static var userAccount: HMUserAccount?
/// 解档当前对象
///
/// - returns: 用户账号信息
class func loadUserAccount() -> HMUserAccount? {

    // 如果当前为Nil，则尝试去解档
    if userAccount == nil {
        userAccount = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? HMUserAccount
    }

    // 判断日期是否过期
    if let date = userAccount?.expiresDate where date.compare(NSDate()) != NSComparisonResult.OrderedDescending {
        // 如果过期，设置userAccount = nil
        userAccount = nil
    }
    return userAccount
}
```

* 修改视图模型

```swift
/// 单例
static let sharedUserAccount = HMUserAccountViewModel()

private override init() {
    userAccount = HMUserAccount.loadUserAccount()
}
```
> `private init` 可以避免外部调用构造函数创建对象

* 在 `view model` 中添加 `accessToken` 计算型属性

```swift
// 提供给外界accessToken的值
var accessToken: String? {
    return userAccount?.access_token
}
```

* 添加 isExpires 判断帐号是否过期

```swift
// 帐号是否过期
var isExpires: Bool {
    if userAccount?.expiresDate?.compare(NSDate()) == NSComparisonResult.OrderedDescending {
        return false
    }
    return true
}
```

* 更改 accessToken 的 get 方法

```swift
// 访问令牌
var accessToken: String? {
    // 其内部判断 accessToken 是否有
    if !isExpires {
        return userAccount?.access_token
    }
    return nil
}
```


* 修改 `HMVisitorViewController` 中的用户登录标记

```swift
var userLogon = HMUserAccountViewModel.sharedUserAccount.accessToken != nil
```

* 在视图模型中增加 `userLogon` 计算型属性

```swift
/// 用户登录标记
var userLogon: Bool {
    return userAccount?.access_token != nil
}
```

* 再次修改 `HMVisitorViewController` 中的用户登录标记

```swift
var userLogon = HMUserAccountViewModel.sharedUserAccount.userLogon
```
