//
//  UILabel+Extension.swift
//  Weibo11
//
//  Created by itheima on 15/12/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit


extension UILabel {
    
    convenience init(textColor: UIColor, fontSize: CGFloat, maxWidth: CGFloat = 0) {
        self.init()
        self.textColor = textColor
        self.font = UIFont.systemFontOfSize(fontSize)
        
        if maxWidth > 0 {
            numberOfLines = 0
            // 设定布局的最大宽度,好让系统知道在哪个地方换行
            preferredMaxLayoutWidth = maxWidth
        }
    }
    
}
