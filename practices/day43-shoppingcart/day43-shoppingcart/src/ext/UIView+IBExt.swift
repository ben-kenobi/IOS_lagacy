//
//  UIView+IBExt.swift
//  day-43-microblog
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

extension UIView{
    
    @IBInspectable var cornerRadius:CGFloat{
        get{
            return layer.cornerRadius
        }
        set{
            layer.cornerRadius=newValue
            layer.masksToBounds=cornerRadius>0
        }
    }
    
    
    @IBInspectable var borderColor:UIColor?{
        get{
            guard let c=layer.borderColor else {
                return nil
            }
            return UIColor(CGColor: c)
        }
        set{
            layer.borderColor=newValue?.CGColor
        }
    }
    
    @IBInspectable var borderWidth:CGFloat{
        get{
            return layer.borderWidth
        }
        set{
            layer.borderWidth=newValue
        }
    }
}

