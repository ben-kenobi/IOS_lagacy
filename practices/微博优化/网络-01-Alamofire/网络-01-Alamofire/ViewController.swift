//
//  ViewController.swift
//  网络-01-Alamofire
//
//  Created by itheima on 15/12/23.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let getUrlString = "http://httpbin.org/get"
        let postUrlString = "http://httpbin.org/post"
        
        /**
            headers 告诉服务器的额外的头信息
        
            与请求的 forHTTPHeaderField 方法等价
        
            * request 默认准备好一个请求，但是不发送给服务器
            * 一旦实现 reponse 方法，就会立即发送网络请求，并且返回结果
            * 不需要指定反序列化支持的格式！
        
            * 调用的时候，直接指定单词即可选择不同的网络方法，后续的所有格式一致！
        */
        Alamofire.request(.POST, postUrlString, parameters: ["name": "zhangsan"]).responseJSON { (response) -> Void in
            
            // 响应的 json 反序列化结果
            print(response.result.value)
            // 响应的 错误，如果有
            print(response.result.error)
            // 请求失败
            print(response.result.isFailure)
            // 请求成功
            print(response.result.isSuccess)
        }
    }
}

