//
//  UIBarButtonItem+Extension.swift
//  Weibo11
//
//  Created by itheima on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

// item字体大小
let ItemTitleFontSize: CGFloat = 14
// item字体颜色
let ItemTitleColor: UIColor = UIColor(white: 80 / 255, alpha: 1)

extension UIBarButtonItem{
    
    
    convenience init(imgName: String? = nil, title: String? = nil, target: AnyObject?, action: Selector) {
        self.init()
        
        let button = UIButton()
        // 添加点击事件
        button.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        
        if let img = imgName {
            // 设置不同状态的图片
            button.setImage(UIImage(named: img), forState: UIControlState.Normal)
            button.setImage(UIImage(named: "\(img)_highlighted"), forState: UIControlState.Highlighted)
        }
        
        if let t = title {
            button.setTitle(t, forState: .Normal)
            button.setTitleColor(ItemTitleColor, forState: .Normal)
            button.setTitleColor(UIColor.orangeColor(), forState: .Highlighted)
            button.titleLabel?.font = UIFont.systemFontOfSize(ItemTitleFontSize)
        }
        
        // 设置大小
        button.sizeToFit()
        
        customView = button
    }
}
