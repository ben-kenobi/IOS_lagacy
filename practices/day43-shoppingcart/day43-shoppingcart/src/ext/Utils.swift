 
//
//  Utils.swift
//  day-43-microblog
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit



class INet{
    static let man:AFHTTPSessionManager={
        let m=AFHTTPSessionManager()
        m.responseSerializer=AFHTTPResponseSerializer()
//        m.securityPolicy.allowInvalidCertificates=true
        return m
    }()
    
    class func requestImg(get:Bool,url:String,para:AnyObject?,cb:((img:UIImage?)->())?){
        request(get, url: url, para: para, cb: { (data, resp) -> () in
            cb?(img: UIImage(data: data, scale: iScale))
        })
    }
    
    class func requestJson(get:Bool,url:String,para:AnyObject?,cb:((AnyObject)->())?){
        request(get, url: url, para: para, cb: { (data, resp) -> () in
            do{
               cb?(try NSJSONSerialization.JSONObjectWithData(data, options: []))
            }catch{
                print(error)
            }
        })
    }
    
    class func requestStr(get:Bool,url:String,para:AnyObject?,cb:((str:String?)->())?){
        request(get, url: url, para: para, cb: { (data, resp) -> () in
            cb?(str: String(data: data, encoding: 4))
        })
    }
    
    
    class func request(get:Bool,url:String,para:AnyObject?,cb:((data:NSData,resp:NSURLResponse?)->())?,fail:((err:NSError,resp:NSURLResponse?)->())?=nil){
        let suc={
            (task:NSURLSessionDataTask!,data:AnyObject!)->() in
            cb?(data: data as! NSData,resp: task.response)
        }
        let fail={
            (task:NSURLSessionDataTask?,err:NSError!)->() in
            fail?(err: err, resp: task?.response)
        }
        
        if(get){
            man.GET(fullUrl(url), parameters: para, success: suc, failure: fail)
        }else{
           man.POST(fullUrl(url), parameters: para, success: suc, failure: fail)
        }
        
        
    }
    
    class func fullUrl(url:String)->String{
        if (url.hasPrefix("http://")||url.hasPrefix("https://")) {
            return url;
        }
        return String(format: "%@%@", iBaseURL,url)
    }

    
    
    
    class func dict2str(dict:[String:AnyObject]?)->String{
        if(nil==dict){
            return ""
        }
        var str:String=""
        for (k,v) in dict! {
            str+="\(k)=\(v)&"
        }
        
        return str == "" ? "" : (str as NSString).substringToIndex(str.len()-1)
    }
    
    class func get(url:NSURL?,cache:Bool,cb:((data:NSData?,resp:NSURLResponse?,err:NSError?)->())?){
        guard let ur=url else{
            return
        }
        let cachepolicy = cache ? NSURLRequestCachePolicy.UseProtocolCachePolicy : NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
    
        NSURLSession.sharedSession().dataTaskWithRequest(NSURLRequest(URL: ur,cachePolicy:cachepolicy,timeoutInterval:15 ), completionHandler:{ (data, resp, err) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                cb?(data: data,resp:resp,err:err)
            })
            
        }).resume()
    }
    
    class func post(url:NSURL?,body:String,cb:((data:NSData?,resp:NSURLResponse?,err:NSError?)->())?){
        guard let ur=url else{
            return
        }
        let req=NSMutableURLRequest(URL: ur,cachePolicy:NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData ,timeoutInterval: 15)
        req.HTTPMethod="POST"

        req.HTTPBody=body.stringByReplacingPercentEscapesUsingEncoding(4)?.dataUsingEncoding(4)
        NSURLSession.sharedSession().dataTaskWithRequest(req, completionHandler:{ (data, resp, err) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                cb?(data: data,resp: resp,err: err)
            })
        }).resume()
       
    }
    
    
    
}


class FileUtil{
    class func cachePath()->String{
        return NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).first!
    }
    
    class func docPath()->String{
        return NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first!
    }
    
    class func tempPath()->String {
        return NSTemporaryDirectory()
    }
}