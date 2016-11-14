//
//  HMNetworkTools.swift
//  Swift网络访问工具类
//
//  Created by itheima on 15/12/6.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit
import AFNetworking

enum HMRequestMethod: String {
    case GET = "GET"
    case POST = "POST"
}

class HMNetworkTools: AFHTTPSessionManager {
    
    
    // 给通过的返回 闭包 定义一个别名
    typealias HMNetworkToolsCallBack = (response: AnyObject?, error: NSError?)->()

    static let shareTools: HMNetworkTools = {
        
        
        
        let tools = HMNetworkTools()
        // 在 Swift 里面, 会把 NSSet 转成 Set
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tools
    }()
    
    /// 提供上传文件的请求方法
    ///
    /// - parameter urlString: 地址
    /// - parameter params:    参数
    /// - parameter data:      二进制数据
    /// - parameter name:      二进制数据对应的字段名
    /// - parameter callback:  回调
    func requestUpload(urlString: String, params: AnyObject?, data: NSData, name: String,callback: HMNetworkToolsCallBack){
        // 定义请求成功之后的闭包
        let succCallback = { (dataTask: NSURLSessionDataTask, response: AnyObject?) -> Void in
            callback(response: response, error: nil)
        }
        
        // 定义请求失败的闭包
        let failureCallBack = { (dataTask: NSURLSessionDataTask?, error: NSError) -> Void in
            callback(response: nil, error: error)
        }
        
        POST(urlString, parameters: params, constructingBodyWithBlock: { (formData) -> Void in
            formData.appendPartWithFileData(data, name: name, fileName: "sss", mimeType: "application/octet-stream")
            }, progress: nil, success: succCallback, failure: failureCallBack)
    }
    
    /// 发送请求
    ///
    /// - parameter method:    请求方式
    /// - parameter urlString: 请求地址
    /// - parameter params:    请求参数
    /// - parameter callback:  请求成功之后的回调
    func request(method: HMRequestMethod, urlString: String, params: AnyObject?, callback: HMNetworkToolsCallBack){
        
        // 在 Swift 中,是不能向当前类(AFHTTPSessionManager)发送 dataTaskWithHTTPMethod
        // 因为 dataTaskWithHTTPMethod 这个方法是 AFN 写到 .m 文件里面
        // 那么对应在 Swift 里面就相当于是 private 修饰的方法
        
        // 定义请求成功之后的闭包
        let succCallback = { (dataTask: NSURLSessionDataTask, response: AnyObject?) -> Void in
            callback(response: response, error: nil)
        }
        
        // 定义请求失败的闭包
        let failureCallBack = { (dataTask: NSURLSessionDataTask?, error: NSError) -> Void in
            callback(response: nil, error: error)
        }
        
        // 根据不同的请求类型,调用不同的请求方法
        if method == .GET {
            GET(urlString, parameters: params, progress: nil, success: succCallback, failure: failureCallBack)
        } else {
            POST(urlString, parameters: params, progress: nil, success: succCallback, failure: failureCallBack)
        }
    }
}

// MARK: - 发送微博
extension HMNetworkTools {
    
    /// 发送文字微博
    ///
    /// - parameter accessToken:
    /// - parameter status:      发送的文字内容
    /// - parameter callback:    回调
    func update(accessToken: String, status: String, callback: HMNetworkToolsCallBack) {
        // 定义  url
        let url = "https://api.weibo.com/2/statuses/update.json"
        // 拼接参数
        let params = [
            "access_token": accessToken,
            "status": status
        ]
        // 发送请求
        request(.POST, urlString: url, params: params, callback: callback)
    }
    
    /// 发表图片微博
    ///
    /// - parameter accessToken: <#accessToken description#>
    /// - parameter status:      <#status description#>
    /// - parameter image:       <#image description#>
    /// - parameter callback:    <#callback description#>
    func upload(accessToken: String, status: String, image: UIImage, callback: HMNetworkToolsCallBack) {
        
        let url = "https://upload.api.weibo.com/2/statuses/upload.json"
        let params = [
            "access_token": accessToken,
            "status": status
        ]
        let data = UIImagePNGRepresentation(image)!
        requestUpload(url, params: params, data: data, name: "pic", callback: callback)
        
        // 发送 post 请求,拼装上传的数据
//        POST(url, parameters: params, constructingBodyWithBlock: { (formData) -> Void in
//            
//            // 拼装上传数据
//            let data = UIImagePNGRepresentation(image)!
//            
//            /**
//            参数:
//            - data: 要上传的二进制数据
//            - name: 接口里面对应的字段名
//            - fileName: 保存在服务器的文件名,可以随意传,因为后台会做相应处理
//                - 取到上传的图片 --> 生成不同质量的图片,命名好放在不同的文件夹里面
//            - mimeType: 告诉后台当前我上传的文件的准确类型
//                - image/jpeg --> 大类型/小类型
//                - text/plian, text/html
//                - 如果不知道准确类型: application/octet-stream
//            
//            */
//            formData.appendPartWithFileData(data, name: "pic", fileName: "sss", mimeType: "image/png")
//            }, success: { (_, response) -> Void in
//                callback(response: response, error: nil)
//            }) { (_, error) -> Void in
//                callback(response: nil, error: error)
//        }
    }
}

// MARK: - 首页微博数据请求
extension HMNetworkTools {
    
    func loadStatus(accessToken: String,sinceId: Int64 = 0, maxid:Int64 = 0, callback: HMNetworkToolsCallBack) {
        // 请求地址
        let urlString = "https://api.weibo.com/2/statuses/friends_timeline.json"
        // 请求参数
        let params = [
            "access_token": accessToken,
            "max_id": "\(maxid)",
            "since_id": "\(sinceId)"
        ]
        request(.GET, urlString: urlString, params: params, callback: callback)
    }
    
}


// MARK: - OAuth 登录相关的请求
extension HMNetworkTools {
    
    // 加载accessToken,并且把加载完成之后的数据回调回去
    func loadAccessToken(code: String, callback: HMNetworkToolsCallBack){
        
        // 请求地址
        let urlString = "https://api.weibo.com/oauth2/access_token"
        // 请求参数
        let params = [
            "client_id": WB_APPKEY,
            "client_secret": WB_APP_SECRET,
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": WB_REDIRECT_URI
        ]
        // 发送请求
        request(.POST, urlString: urlString, params: params, callback: callback)
    }
    
    
    /// 请求用户信息
    ///
    /// - parameter uid:         uid
    /// - parameter accessToken: accessToken
    /// - parameter callback:    网络数据回调
    /// - parameter error:       <#error description#>
    func loadUserInfo(uid: String, accessToken: String, callback: HMNetworkToolsCallBack){
        // 定义 url
        let urlString = "https://api.weibo.com/2/users/show.json"
        // 组织参数
        let params = [
            "access_token": accessToken,
            "uid": uid
        ]
        // 发送请求
        request(.GET, urlString: urlString, params: params, callback: callback)
    }
}
