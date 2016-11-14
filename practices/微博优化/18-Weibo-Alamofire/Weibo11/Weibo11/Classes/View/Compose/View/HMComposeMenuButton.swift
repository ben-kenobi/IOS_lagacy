//
//  HMComposeMenuButton.swift
//  Weibo11
//
//  Created by itheima on 15/12/12.
//  Copyright © 2015年 itheima. All rights reserved.
//  composeView 里面菜单的按钮(图片在上面,文字在下面)

import UIKit

class HMComposeMenuButton: UIButton {

    // 将按钮的高度效果干掉
    override var highlighted: Bool {
        set{

        }
        get{
            return false
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 设置内容子控件的一些属性
        titleLabel?.textAlignment = .Center
        titleLabel?.font = UIFont.systemFontOfSize(14)
        setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        // 指定 imageView 的 contentModel
        imageView?.contentMode = .Center
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 调整 imageView
        imageView?.y = 0
        imageView?.width = width
        imageView?.height = width
        
        // 调整 titleLabel
        titleLabel?.x = 0
        titleLabel?.y = width
        titleLabel?.width = width
        titleLabel?.height = height - width
        
    }

}
