//
//  HMUser.swift
//  Weibo11
//
//  Created by itheima on 15/12/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

class HMUser: NSObject {
    
    // 用户昵称
    var name: String?
    // 用户头像
    var profile_image_url: String?
    // 会员等级 1-6
    var mbrank: Int = 0
    /// 认证类型 -1：没有认证，1，认证用户，2,3,5: 企业认证，220: 达人
    var verified: Int = 0
    
    init(dict: [String: AnyObject]){
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
 
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
}
