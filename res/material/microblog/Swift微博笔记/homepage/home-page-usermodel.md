# 用户模型

## 定义模型

```swift
/// 用户模型
class HMUser: NSObject {
    /// 用户UID
    var id: Int = 0
    /// 友好显示名称
    var name: String?
    /// 用户头像地址（中图），50×50像素
    var profile_image_url: String?
    /// 认证类型 -1：没有认证，1，认证用户，2,3,5: 企业认证，220: 达人
    var verified: Int = 0
    /// 会员等级 1-6
    var mbrank: Int = 0

    // MARK: - 构造函数
    init(dict: [String: AnyObject]) {
        super.init()

        setValuesForKeysWithDictionary(dict)
    }

    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}

    override var description: String {
        let keys = ["id", "name", "profile_image_url", "mbrank"]

        return dictionaryWithValuesForKeys(keys).description
    }
}
```

## 在 `HMStatus` 中针对用户模型增加处理

* 增加属性

```swift
/// 微博作者的用户信息字段
var user: HMUser?
```

> 运行测试，会发现 user 字段被 KVO 设置成了字典

* 修改 `HMStatus` 的构造函数

```swift
override func setValue(value: AnyObject?, forKey key: String) {
    // 判断 key 是否是 "user"
    if key == "user" {
        user = HMUser(dict: value as! [String: AnyObject])
        return
    }
    super.setValue(value, forKey: key)
}
```
