
//
//  HMMatchResult.swift
//  Weibo11
//
//  Created by itheima on 15/12/18.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

class HMMatchResult: NSObject {
    // 匹配的文字
    var string: String
    // 匹配的范围
    var range: NSRange
    
    init(string: String, range: NSRange){
        self.string = string
        self.range = range
        super.init()
    }
}
