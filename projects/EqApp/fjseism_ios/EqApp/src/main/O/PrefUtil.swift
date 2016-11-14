//
//  PrefUtil.swift
//  EqApp
//
//  Created by apple on 16/8/23.
//  Copyright © 2016年 apple. All rights reserved.
//

import Foundation
import UIKit

class PrefUtil{
    static let  RESERVED_DIMEN = "user_def";
    static let  USER_INFO = "userInfo";
    static let  USERS = "users";
    
    static let  MAPLAYERS = "maplayers";
    static let  EQINFO = "eqinfo";
    
    
    static func  put( key:String, value:String) -> Bool{
    
        iPref(RESERVED_DIMEN)?.setObject(value, forKey: key)
        return iPref(RESERVED_DIMEN)?.synchronize() ?? false
    
    }
    
    static func  get(key:String,defau:String)->String {
        return iPref(RESERVED_DIMEN)?.stringForKey(key) ?? defau
    
    }
    
    //
    //	public static boolean putLayer(String key,String value){
    //		Editor editor = CommonUtils.context.getSharedPreferences(MAPLAYERS, 0).edit();
    //		editor.putString(key,value);
    //		return editor.commit();
    //	}
    
    static func getObsTime()->Int {
        return iPref(MAPLAYERS)?.integerForKey("obsTime") ?? -1
   
    }
    
    static func  putObsTime(obsTime:Int) -> Bool{
        iPref(MAPLAYERS)?.setInteger(obsTime, forKey: "obsTime")
        return iPref(MAPLAYERS)?.synchronize() ?? false
    }
    
    static func getObsTime_instant()->Int {
        return iPref(MAPLAYERS)?.integerForKey("obsTime_instant") ?? -1
    }
    
    static func putObsTime_instant(obsTime:Int)->Bool {
        iPref(MAPLAYERS)?.setInteger(obsTime, forKey: "obsTime_instant")
        return iPref(MAPLAYERS)?.synchronize() ?? false
    }
    
    //	public static String getLayer(String key,String defau){
    //		return CommonUtils.context.getSharedPreferences(MAPLAYERS, 0).getString(key, defau);
    //	}
    //	public static boolean putEQInfo(String key,String value){
    //		Editor editor = CommonUtils.context.getSharedPreferences(EQINFO, 0).edit();
    //		editor.putString(key,value);
    //		return editor.commit();
    //	}
    //
    //	public static String getEQInfo(String key,String defau){
    //		return CommonUtils.context.getSharedPreferences(EQINFO, 0).getString(key, defau);
    //	}
    static func  getEQInfo()->NSData? {
//        return iPref(EQINFO)?.stringForKey("EQInfo") ?? ""
        return iPref(EQINFO)?.dataForKey("EQInfo")
    }
    
    static func getEQInfo2()->EQInfo?{
        let js:NSData? = PrefUtil.getEQInfo()
        guard let data = js else{
            return nil
        }
        
        let dict = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! [String:AnyObject]
        
        return EQInfo(dict:dict)
    }
    
    
    
    
    static func putEQInfo(json:NSData) -> Bool{
        iPref(EQINFO)?.setObject(json, forKey: "EQInfo")
        return iPref(EQINFO)?.synchronize() ?? false
   
    }
    
    
    static func putByUser(key:String, value:String)->Bool {
        if empty(UserInfo.me.NAME){
            return false
        }
        iPref(UserInfo.me.NAME)?.setObject(value, forKey: key)
        return iPref(UserInfo.me.NAME)?.synchronize() ?? false
    }
    static func getPwd() -> String{
        if UserInfo.isPwdExpired(){
            return ""
        }
        return iPref(USER_INFO)?.stringForKey("PASSWORD") ?? ""
    
    }
    
    static func  getUsername()->String {
        return iPref(USER_INFO)?.stringForKey("USER_NAME") ?? ""
    }
    

    static func  getByUser( key:String, defau:String)->String {
        if empty(UserInfo.me.NAME) && empty(getUsername()){
            return defau
        }
        return iPref(empty(UserInfo.me.NAME) ? getUsername():UserInfo.me.NAME)?.stringForKey(key) ?? defau
    }
    static func  saveInUsers( name:String, pwd:String)->Bool {
        iPref(USERS)?.setObject(pwd, forKey: name)
        return iPref(USERS)?.synchronize() ?? false
    }
    static func  saveUser(username:String,pwd:String)->Bool {
        iPref(USER_INFO)?.setObject(username, forKey: "USER_NAME")
        iPref(USER_INFO)?.setObject(pwd, forKey: "PASSWORD")
        saveInUsers(username, pwd: pwd)
        return iPref(USER_INFO)?.synchronize() ?? false
    }
    

    
    static func  getUsers()->[(String,String)]{
        var ary = [(String,String)]()
        let dict=iPref(USERS)?.dictionaryRepresentation()
        for (key,val) in dict! {
            if key.hasPrefix("Apple")||key.hasPrefix("NS")||key.hasPrefix("MS"){
                continue
            }
            if let val = val as? String {
                ary.append((key,val ))
            }
        }
        return ary;
    }
    
    class func putUserInfoByUser(userinfomap:[String:AnyObject])->Bool{
//        PrefUtil.putByUser("userInfo",value: NSString(data: try! NSJSONSerialization.dataWithJSONObject(userinfomap, options: []),encoding: 4 ) as! String)
        if empty(UserInfo.me.NAME){
            return false
        }
     
        let umap:NSMutableDictionary = (userinfomap as NSDictionary).mutableCopy() as! NSMutableDictionary
        umap.removeObjectsForKeys(umap.allKeysForObject(NSNull()))
        iPref(UserInfo.me.NAME)?.setObject(umap, forKey: "userInfo")
        return iPref(UserInfo.me.NAME)?.synchronize() ?? false
    }
    
    class func getUserInfoByUser()->[String:AnyObject]{
        if empty(UserInfo.me.NAME){
            return [String:AnyObject]()
        }
        if let dict =  iPref(UserInfo.me.NAME)?.dictionaryForKey("userInfo"){
            return dict
        }
        return [String:AnyObject]()
       
        
    }

}
