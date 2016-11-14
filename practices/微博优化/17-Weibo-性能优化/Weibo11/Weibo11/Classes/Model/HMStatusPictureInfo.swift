//
//  HMStatusPictureInfo.swift
//  Weibo11
//
//  Created by itheima on 15/12/11.
//  Copyright © 2015年 itheima. All rights reserved.
//  微博配图信息的模型

import UIKit

class HMStatusPictureInfo {
    
    /// 配图视图的地址
    var picUrl: NSURL?
    
    init(dict: [String: AnyObject]) {
        
        // 创建 picUrl
        if let urlString = dict["thumbnail_pic"] as? String {
            picUrl = NSURL(string: urlString)
        }
    }
}
