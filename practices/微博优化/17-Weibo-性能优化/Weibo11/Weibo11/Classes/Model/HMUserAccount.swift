//
//  HMUserAccount.swift
//  Weibo11
//
//  Created by itheima on 15/12/6.
//  Copyright © 2015年 itheima. All rights reserved.
//  用户帐户的模型

import UIKit

class HMUserAccount: NSObject, NSCoding {
    
    // 用户的id
    var uid: String?
    // 过期时间,单位秒 --> JSON 里面的值没有用 引号引起来
    var expires_in: NSTimeInterval = 0 {
        didSet{
            // 在外界给 expires_in 赋值的时候,就可以去计算出来具体什么时候过期
            expiresDate = NSDate(timeIntervalSinceNow: expires_in)
            printLog(expiresDate)
        }
    }
    
    // 代表当前帐号是什么时候过期 accessToken 获取回来的那一ke,加上过期的秒数
    var expiresDate: NSDate?
    // 用于调用access_token，接口获取授权后的access token
    var access_token: String?
    // 用户的头像地址
    var avatar_large: String?
    // 用户的昵称
    var screen_name: String?
    
    init(dict: [String: AnyObject]){
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    override var description: String {
        let keys = ["uid", "expires_in", "access_token", "avatar_large", "screen_name"]
        return dictionaryWithValuesForKeys(keys).description
    }
    
    // MARK: -  归档的协议方法
    
    /// 从文件里面读取传成对象,解档
    ///
    /// - parameter aDecoder: <#aDecoder description#>
    ///
    /// - returns: <#return value description#>
    required init(coder aDecoder: NSCoder) {
        
        // 像这种情况下, 前面如果是 ? 类型,就使用 as? 
        //
        uid = aDecoder.decodeObjectForKey("uid") as? String
        expiresDate = aDecoder.decodeObjectForKey("expiresDate") as? NSDate
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String
        screen_name = aDecoder.decodeObjectForKey("screen_name") as? String
    }
    
    /// 把对象保存成二进制文件,归档
    ///
    /// - parameter aCoder: <#aCoder description#>
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(expiresDate, forKey: "expiresDate")
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
        aCoder.encodeObject(screen_name, forKey: "screen_name")
    }
    
//    // 归档当前对象
//    func saveAccount() {
//        // 1. 获取路径
//        let file = (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last! as NSString).stringByAppendingPathComponent("useraccount.archive")
//        printLog(file)
//        // 2. 归档
//        NSKeyedArchiver.archiveRootObject(self, toFile: file)
//    }
//    
//    // 解档
//    class func userAccount() -> HMUserAccount? {
//        // 1. 获取路径
//        let file = (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last! as NSString).stringByAppendingPathComponent("useraccount.archive")
//        // 2. 解档
//        let result = NSKeyedUnarchiver.unarchiveObjectWithFile(file) as? HMUserAccount
//        return result
//    }
}

