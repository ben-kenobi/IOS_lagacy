//
//  UIView+IBExtension.swift
//  Weibo11
//
//  Created by itheima on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

@IBDesignable
extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get{
            return layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get{
            guard let c = layer.borderColor else {
                return nil
            }
            return UIColor(CGColor: c)
        }
        set{
            layer.borderColor = newValue?.CGColor
        }
    }
    
    //borderWidth
    @IBInspectable var borderWidth: CGFloat {
        get{
            return layer.borderWidth
        }
        set{
            layer.borderWidth = newValue
        }
    }
}
