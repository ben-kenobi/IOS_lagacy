//
//  NetUtil.swift
//  anquanguanli
//
//  Created by apple on 16/3/21.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class NetUtil {
    class func serverIP()->String{
        
        if let val = iPref()?.stringForKey("server_ip"){
            return  val
        }
        return iConst.defServerIp
    }
    class func serverIPWithoutPort()->String{
        let ip = NetUtil.serverIP() as NSString
        let ip2 = ip.substringToIndex(ip.rangeOfString(":").location)
        return ip2
    }
    class func serverPref()->String{
    
        return iConst.defHttpPref + serverIP() + "/"
    }
    class func setServerIP(ip:String){
        iPref()?.setObject(ip, forKey: "server_ip")
        iPref()?.synchronize()
    }
    class func fullUrl(url:String)->String{
        if url.hasPrefix("http://") || url.hasPrefix("https://"){
            return url
        }
        return (serverPref()+url)
    }
    
    
    class func netWorkAvailable()->Bool{
        let reachability = Reachability.reachabilityForInternetConnection()
        let networkStatus: Int = reachability.currentReachabilityStatus().rawValue
        return networkStatus != 0
        
    }
    
    class func netWorkStatus()->Int{
        let reachability = Reachability.reachabilityForInternetConnection()
        //        reachability.startNotifier()
        return reachability.currentReachabilityStatus().rawValue
    }
    
    class func commonCheck(toast:Bool = true)->Bool{
        if !netWorkAvailable(){
            if toast{
                iPop.toast("网络未连接，请检查")
            }
            return false
        }
        if serverPref()==""{
            if toast{
                iPop.toast("服务IP和端口为空！请重新设置")
            }
            return false
        }
        return true
    }
    
    
    class func commonRequestJson(get:Bool,path:String,para:AnyObject?,succode:[String],cb:((AnyObject,Int)->())?,failcb:(()->())?=nil){
        if !commonCheck(){
            failcb?()
            return
        }
        let url = fullUrl(path).urlEncoded()
        
        iPop.showProg()
        INet.requestJson(get, url: url, para: para, cb: { (data) -> () in
            iPop.dismProg()
            

            guard let _=cb else{
                return
            }
            
            if let status = ("\(data["status"] ?? "")") as? String{
                if succode.contains(status){
                    cb?(data,succode.indexOf(status)!)
                }else{
//                    print(data.description+"-------------")
                    iPop.toast((data["msg"] as? String)  ?? "未知错误")
                    failcb?()
                }
            }
            
            
            
            }) { (err, resp) -> () in
                iPop.dismProg()
//                let str=String(data: (err.userInfo["com.alamofire.serialization.response.error.data"] as! NSData), encoding: NSUTF8StringEncoding)!
//                
//                print(str)
                iPop.toast("请求失败 \(err)")
                failcb?()

        }
    }
    
    class func commonRequestPlainJson(get:Bool,path:String,para:AnyObject?,succode:[String],cb:((AnyObject)->())?){
        if !commonCheck(){
            return
        }
        let url = fullUrl(path).urlEncoded()
        
        iPop.showProg()
        INet.requestJson(get, url: url, para: para, cb: { (data) -> () in
            iPop.dismProg()
            
            
            guard let _=cb else{
                return
            }
            cb?(data)
        }) { (err, resp) -> () in
            iPop.dismProg()
            iPop.toast("请求失败 \(err)")
        }
    }
    
    class func commonRequestStr(get:Bool,path:String,para:AnyObject?,cb:((String?)->())?){
        if !commonCheck(){
            return
        }
        let url = fullUrl(path).urlEncoded()
        iPop.showProg()
        INet.requestStr(get, url: url, para: para, cb: { (data) -> () in
            iPop.dismProg()
            guard let _=cb else{
                return
            }
            
            cb?(data)
            
            }
            
            ) { (err, resp) -> () in
                iPop.dismProg()
                iPop.toast("请求失败 \(err)")
        }
    }
    
    
    class func commonRequest(get:Bool,path:String,para:AnyObject?,cb:((suc:Bool)->())?){
        if !commonCheck(){
            return
        }
        let url = fullUrl(path).urlEncoded()
        iPop.showProg()
        INet.request(get, url: url, para: para,cb: { (data, resp) in
            iPop.dismProg()
            cb?(suc: true)
            },fail: {(err,resp) in
                iPop.dismProg()
                cb?(suc: true)
        })
        
    }
    
    class func commonNoProgRequest(get:Bool,path:String,para:AnyObject?,cb:((AnyObject,Int)->())?){
        if !commonCheck(false){
            return
        }
        let url = fullUrl(path).urlEncoded()
        INet.requestJson(get, url: url, para: para, cb: { (data) in
            if let cb = cb{
                let status = "\(data["status"] ?? "")"
                if ("200" == (status)) {
                    cb(data, 0)
                } else if ("400" == (status)) {
                    iCommonLog(data["msg"])
                } else {
                    iCommonLog("未知错误")
                }
            }
            
            }) { (err, resp) in
                iCommonLog("连接出错")
        }
    }
    
  
   
    class func commonRequest6(tp:TsceneProg,path:String, mapo:[String:String], files:[String:NSData],
                              cb:((AnyObject,Int)->())?) {
    
        let url = fullUrl(path).urlEncoded()
        
        INet.upload(url, para: mapo, datas: files, cb: { (data, resp) in
            let dict = try! NSJSONSerialization.JSONObjectWithData(data, options: [])
            print(dict.description)
            iPop.dismProg()

            if let status = ("\(dict["status"] ?? "")") as? String{
                if "200"==status{
                    cb?(dict,0)
                }else{
                    iPop.toast((dict["msg"] as? String)  ?? "未知错误")
                }
            }
        }) { (err, resp) in
            iPop.dismProg()
            iPop.toast("请求失败 \(err)")
        }
    }
    
    class func request4Upload(tp:TsceneProg,path:String, para:[String:String], files:[String:String], cb:((AnyObject?,Int)->())?){
        
        tp.uploadhandler =  UploadUtil.multiUpload(para, contents: files, toUrl: fullUrl(path).urlEncoded()) { (state, obj, err, totalWritten, totalExpectedToWritten) in
            if state == 0 {
                if let status = obj?["status"] as? Int {
                    if 200 == status{
                        cb?(obj,0)

                    }else{
                        tp.describe=(obj?["msg"] as? String) ?? "未知错误"
                        tp.state=2;
                        cb?(obj,1)
                    }
                }else{
                    tp.describe="操作失败";
                    tp.state=2;
                    cb?(obj,1)
 
                }
            }else if state == 1{
                tp.compressing=false
                tp.describe="正在上传..."
                tp.state=0
                tp.total=totalExpectedToWritten!
                tp.progress=totalWritten!
            }else if state == -1{
                cb?(nil,2)
            }
        }



    }

    
}
