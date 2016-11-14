



//
//  UserInfo.swift
//  day-43-microblog
//
//  Created by apple on 15/12/6.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit


class UserInfo: NSObject,NSCoding {

    
    var welcomed:Bool=false
    var login=false

    
    var logStringCache:String?
    var sysTitle:String?  //系统标题
    
    var userName:String? //用户名称
    var pwd:String?
    
    var userUnit:String? //用户单位
    
    var userId:String? //用户ID
    
    var token:String? //登录令牌
    
    var channelId:String? //推送渠道ID
    
    var terminalPhone:String? //GPS电话卡号码
    
    var workGroupId:String? //作业信息组标识
    
    var remPwd=false
    
    var warehouse:TWarehouse?
    
    
   
    class func setWareHouse(dict:[String:AnyObject]?){
        me.warehouse  = TWarehouse(dict: dict)
    }
    
    
    class func getUserName()->String{
        guard let wh = me.warehouse else{
            return me.userName!
        }
        return wh.loginName!
    }
    
    class func isLogin()->Bool{
        
        return me.login

    }
    class func loginWithDict(dict:[String:AnyObject]){
        me.setValuesForKeysWithDictionary(dict)
        doLogin()
    }
    class func doLogin(){
        me.archive()
        me.login=true
    }
    class func doLogout(){
        me.login=false
    }
    

    
    private override init(){
        super.init()
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        pwd = aDecoder.decodeObjectForKey("pwd") as? String
        userName = aDecoder.decodeObjectForKey("userName") as? String
        remPwd = aDecoder.decodeBoolForKey("remPwd")
        
    }
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeBool(remPwd, forKey: "remPwd")
        aCoder.encodeObject(pwd, forKey: "pwd")
        aCoder.encodeObject(userName, forKey: "userName")
        
    }
 
    
  
   
}

extension UserInfo{
    @nonobjc static  let TAG = "PushDemoActivity"
    @nonobjc static  let RESPONSE_METHOD = "method"
    @nonobjc static  let  RESPONSE_CONTENT = "content"
    @nonobjc static  let  RESPONSE_ERRCODE = "errcode"
    @nonobjc static  let  ACTION_LOGIN = "com.baidu.pushdemo.action.LOGIN"
    @nonobjc static  let  ACTION_MESSAGE = "com.baiud.pushdemo.action.MESSAGE"
    @nonobjc static  let  ACTION_RESPONSE = "bccsclient.action.RESPONSE"
    @nonobjc static  let  ACTION_SHOW_MESSAGE = "bccsclient.action.SHOW_MESSAGE"
    @nonobjc static  let  EXTRA_ACCESS_TOKEN = "access_token"
    @nonobjc static  let  EXTRA_MESSAGE = "message"
    
    @nonobjc static let file="userinfo.archive".strByAp2Doc()
    @nonobjc static let me:UserInfo=UserInfo.unarchive()
    
    
  
  
    
    
    
    
    func archive(){
        iCommonLog(UserInfo.file)

        NSKeyedArchiver.archiveRootObject(self, toFile: UserInfo.file)
       
    }
    private class func unarchive()->UserInfo{
        if let user =  NSKeyedUnarchiver.unarchiveObjectWithFile(UserInfo.file) as? UserInfo{
            return user
        }
        
        return UserInfo()
    }
    
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override func valueForUndefinedKey(key: String) -> AnyObject? {
        return 0
    }
    
    override var description:String{
        get{
            return dictionaryWithValuesForKeys(["userName","userUnit","userId","token"]).description
        }
    }
    
    
    
    
    class func hasWelcomed()->Bool{
       
        return me.welcomed
    }
    
    class func welcomed(b:Bool){

        me.welcomed=b

    }
}

