//
//  HMNetworkTools.swift
//  Swift网络访问工具类
//
//  Created by itheima on 15/12/6.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit
import Alamofire

class HMNetworkTools {
    
    
    // 给通过的返回 闭包 定义一个别名
    typealias HMNetworkToolsCallBack = (response: AnyObject?, error: NSError?)->()

    /// 单例
    static let shareTools = HMNetworkTools()
    
    /// 提供上传文件的请求方法
    ///
    /// - parameter urlString: 地址
    /// - parameter params:    参数
    /// - parameter data:      二进制数据
    /// - parameter name:      二进制数据对应的字段名
    /// - parameter callback:  回调
    func requestUpload(urlString: String, params: [String: AnyObject]?, data: NSData, name: String, callback: HMNetworkToolsCallBack){

        /**
            upload 函数负责构建整个上传的数据体 -> 上传的文件，以及字典
        */
        Alamofire.upload(.POST, urlString, multipartFormData: { (formData) -> Void in
            
            // 准备上传的`文件` - 注意：方法不要选择错误，一定要带四个参数
            formData.appendBodyPart(data: data, name: name, fileName: "ooxx", mimeType: "application/octet-stream")
            
            // 遍历字典，向 formData 继续添加参数
            // 1> 判断字典是否有内容
            guard let parameters = params else {
                return
            }
            
            for (k, v) in parameters {
                
                // 2> 将 v 转换成字符串，然后再转换成二进制数据
                if let str = v as? String {
                    
                    let strData = str.dataUsingEncoding(NSUTF8StringEncoding)!
                    
                    // 3> data 就是 v 的对应的二进制数据
                    // name 就是字典 的 k
                    formData.appendBodyPart(data: strData, name: k)
                }
            }
            
            }) { (encodingResult) -> Void in
                // encodingResult 表示上面 formData 的`构建`是否正常
                switch encodingResult {
                case .Success(let upload, _, _):
                    // 如果 formData 设置成功，会调用此分支，开始上传程序
                    // upload 就是一个准备好的 Request 对象
                    upload.responseJSON(completionHandler: { (response) -> Void in
                        // 隐藏状态栏指示器
                        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                        
                        // 判断是否成功
                        if response.result.isFailure {
                            print("网络请求失败 \(response.result.error)")
                        }
                        callback(response: response.result.value, error: response.result.error)
                    })
                case .Failure(let encodingError):
                    // 如果 formData 设置失败，会调用此分支
                    print(encodingError)
                }
        }
    }
    
    /// 发送请求
    ///
    /// - parameter method:    请求方式
    /// - parameter urlString: 请求地址
    /// - parameter params:    请求参数
    /// - parameter callback:  请求成功之后的回调
    func request(method: Alamofire.Method, urlString: String, params: [String: AnyObject]?, callback: HMNetworkToolsCallBack){
        
        // 显示状态栏加载状态
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        Alamofire.request(method, urlString, parameters: params).responseJSON { (response) -> Void in

            // 隐藏状态栏指示器
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            
            // 判断是否成功
            if response.result.isFailure {
                print("网络请求失败 \(response.result.error)")
            }
            callback(response: response.result.value, error: response.result.error)
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
