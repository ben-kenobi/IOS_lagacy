//
//  HMStatus.swift
//  Weibo11
//
//  Created by itheima on 15/12/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

class HMStatus: NSObject {
    
    // 注意在 iPhone5 上,系统架构是32位,使用 int 系统会使用的是 int32 -> 微博id已经超出了
    var id: Int64 = 0
    
    // 微博的内容
    var text: String?
    // 当前微博作者信息
    var user: HMUser?
    // 微博的创建时间
    var created_at: String?
    // 来自
    var source: String?
    // 转发
    var reposts_count: Int = 0
    // 评论数
    var comments_count: Int = 0
    // 表态数
    var attitudes_count: Int = 0
    // 转发微博的内容
    var retweeted_status: HMStatus?
    // 当前微博的配图
    var pic_urls: [HMStatusPictureInfo]?
//    {
//        didSet {
//            if pic_urls?.count > 2 {
//                
//                var tempArray = [HMStatusPictureInfo]()
//                for i in 0..<2 {
//                    tempArray.append(pic_urls![i])
//                }
//                pic_urls = tempArray
//            }
//        }
//    }
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "user" {
            if let dict = value as? [String: AnyObject] {
                user = HMUser(dict: dict)
            }
        }else if key == "retweeted_status" {
            if let dict = value as? [String: AnyObject] {
                retweeted_status = HMStatus(dict: dict)
            }
        }else if key == "pic_urls" {
         
            // 判断当前 value 是否是一个字典数组
            if let array = value as? [[String: AnyObject]] {
                // 定义临时的集合
                var tempArray = [HMStatusPictureInfo]()
                // 遍历
                for dict in array {
                    // 进行字典转模型,并保存
                    tempArray.append(HMStatusPictureInfo(dict: dict))
                }
                pic_urls = tempArray
            }
            
        }else {
            super.setValue(value, forKey: key)
        }
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    override var description: String {
        let keys = ["text", "retweeted_status"]
        return dictionaryWithValuesForKeys(keys).description
    }
}
