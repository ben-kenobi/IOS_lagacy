# 归档 & 解档

## 课程目标

* 对比 OC 的`归档 & 解档`实现
* 利用`归档 & 解档`保存用户信息

* 遵守协议

```swfit
class HMUserAccount: NSObject, NSCoding
```

* 实现协议方法

```swift
// MARK: - NSCoding
/// 归档 - 将对象以二进制形式保存至磁盘前被调用，与网络的序列化类似
func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(access_token, forKey: "access_token")
    aCoder.encodeObject(expiresDate, forKey: "expiresDate")
    aCoder.encodeObject(uid, forKey: "uid")
    aCoder.encodeObject(name, forKey: "name")
    aCoder.encodeObject(avatar_large, forKey: "avatar_large")
}

/// 解档 - 将二进制数据从磁盘读取并且转换成对象时被调用，与网络的反序列化类似
required init?(coder aDecoder: NSCoder) {
    access_token = aDecoder.decodeObjectForKey("access_token") as? String
    expiresDate = aDecoder.decodeObjectForKey("expiresDate") as? NSDate
    uid = aDecoder.decodeObjectForKey("uid") as? String
    name = aDecoder.decodeObjectForKey("name") as? String
    avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String
}
```

* 实现将当前对象归档保存的函数

```swift
/// 归档保存当前对象
func saveUserAccount(){
    let path = (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last! as NSString).stringByAppendingPathExtension("userAccount.archive")!
    print("归档保存路径：\(path)")
    // 归档
    NSKeyedArchiver.archiveRootObject(self, toFile: path)
}
```

