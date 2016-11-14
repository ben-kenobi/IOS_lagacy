# 加载用户信息

## 课程目标

* 通过 `AccessToken` 获取新浪微博网络数据

## 接口定义

### 文档地址

http://open.weibo.com/wiki/2/users/show

### 接口地址

https://api.weibo.com/2/users/show.json

### HTTP 请求方式

* GET

### 请求参数

| 参数 | 描述 |
| -- | -- |
| access_token | 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得 |
| uid | 需要查询的用户ID |

### 返回数据

| 返回值字段 | 字段说明 |
| -- | -- |
| name | 友好显示名称 |
| avatar_large | 用户头像地址（大图），180×180像素 |

### 测试 URL

https://api.weibo.com/2/users/show.json?access_token=2.00ml8IrF0qLZ9W5bc20850c50w9hi9&uid=5365823342

## 代码实现

* 在 `HMOAuthViewController` 中添加 `loadUserInfo` 方法

```swift
/// 加载用户数据
///
/// - parameter userAccount: 用户账户模型
private func loadUserInfo(userAccount: HMUserAccount) {

    let urlString = "https://api.weibo.com/2/users/show.json"
    // 定义参数
    let params = [
        "uid": userAccount.uid!,
        "access_token": userAccount.access_token!
    ]

    HMNetworkTools.shareTools.request(.GET, url: urlString, params: params) { (result, error) -> () in
        if error != nil {
            print("请求失败:\(error)")
            return
        }
        print(result)
    }
}
```

* 在 `loadAccessToken` 方法中请求accessToken成功后调用该方法

```swift
// 将返回字典转成模型
let account = HMUserAccount(dict: result as! [String: AnyObject])
print(account)
// 请求用户数据
self.loadUserInfo(account)
```

> 注意：在 Swift 中，闭包中输入代码的智能提示非常不好，因此新建一个函数单独处理加载用户功能

### 扩展用户模型

* 在 `HMUserAccount` 中增加用户名和头像属性

```swift
/// 友好显示名称
var name: String?
/// 用户头像地址（大图），180×180像素
var avatar_large: String?
```

* 扩展 `description` 中的属性

```swift
override var description: String {
    let keys = ["access_token", "expires_in", "expiresDate", "uid", "name", "avatar_large"]

    return dictionaryWithValuesForKeys(keys).description
}
```

* 在用户信息请求成功之后获取昵称与头像

```swift
// 发送get请求
HMNetworkTools.shareTools.request(.GET, url: urlString, params: params) { (result, error) -> () in
    if error != nil {
        print("请求失败:\(error)")
        return
    }
    guard let dict = result as? [String: AnyObject] else {
        return
    }
    // 设置请求回来的用户昵称和头像
    userAccount.name = dict["name"] as? String
    userAccount.avatar_large = dict["avatar_large"] as? String
}
```

> 每一个令牌授权一个 `特定的网站` 在 `特定的时段内` 访问 `特定的资源`


