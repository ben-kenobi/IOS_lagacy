//
//  HMComposeButtonInfo.swift
//  Weibo11
//
//  Created by itheima on 15/12/12.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

class HMComposeButtonInfo: NSObject {
    var icon: String?
    var title: String?
    var classname: String?
    
    
    init(dict: [String: AnyObject]){
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
}
