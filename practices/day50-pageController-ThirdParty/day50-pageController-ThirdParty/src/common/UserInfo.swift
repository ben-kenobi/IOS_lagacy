



//
//  UserInfo.swift
//  day-43-microblog
//
//  Created by apple on 15/12/6.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit


class UserInfo: NSObject,NSCoding {
    static let file="userinfo.archive".strByAp2Doc()
    static var me:UserInfo?=UserInfo.unarchive()
    
    var welcomed:Bool=false
    var access_token:String?
    var expires_in : Double=0{
        didSet{
            expire=NSDate(timeIntervalSinceNow: expires_in-60)
        }
    }
    var uid : String?
    var avatar_large:String?
    var screen_name:String?
    var expire:NSDate?
    
    private init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    private override init(){
        super.init()
    }
    
    
    class func hasWelcomed()->Bool{
        guard let user = me  else{
            return true
        }
        return user.welcomed
    }
    
    class func welcomed(b:Bool){
        if let user=me {
            user.welcomed=b
        }
    }
    class func isLogin()->Bool{
        guard let user = me  else{
            return false
        }
        return user.access_token != nil //&& NSDate().compare(user.expire!) == .OrderedAscending

    }
    class func login(dict:[String:AnyObject]){
        me=UserInfo(dict: dict)
    }
    
    func detail(dict:[String:AnyObject]){
        avatar_large=dict["avatar_large"] as? String
        screen_name=dict["screen_name"] as? String
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override func valueForUndefinedKey(key: String) -> AnyObject? {
        return 0
    }
    
    override var description:String{
        get{
            return dictionaryWithValuesForKeys(["access_token","expires_in","uid","avatar_large","screen_name","expires"]).description
        }
    }
    
    func archive(){
        print(UserInfo.file)
        NSKeyedArchiver.archiveRootObject(self, toFile: UserInfo.file)
    }
    private class func unarchive()->UserInfo?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(UserInfo.file) as? UserInfo
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeDouble(expires_in, forKey: "expires_in")
        aCoder.encodeObject(expire, forKey: "expire")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
        aCoder.encodeObject(screen_name, forKey: "screen_name")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        access_token=aDecoder.decodeObjectForKey("access_token") as? String
        expires_in=aDecoder.decodeDoubleForKey("expires_in")
        expire=aDecoder.decodeObjectForKey("expire") as? NSDate
        uid=aDecoder.decodeObjectForKey("uid") as? String
        avatar_large=aDecoder.decodeObjectForKey("avatar_large") as? String
        screen_name=aDecoder.decodeObjectForKey("screen_name") as? String
        
    }
    
   
}

