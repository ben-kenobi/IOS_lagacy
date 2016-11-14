//
//  InteractableSV.swift
//  EqApp
//
//  Created by apple on 16/9/8.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
class InteractableSV:UIScrollView{
  
    override func touchesShouldCancelInContentView(view: UIView) -> Bool {
        if view is UIButton {
            return true
        }
        return super.touchesShouldCancelInContentView(view)
    }
    
    

}