//
//  WineCate.swift
//  day43-shoppingcart
//
//  Created by apple on 15/12/19.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class WineCate: NSObject {
    var dockName:String?
    var right:[Wine]?
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "right"{
            var right=[Wine]()
            if let ary = value as? [[String:AnyObject]]{
                for dict in ary{
                    right.append(Wine(dict:dict))
                }
            }
            self.right=right
        }else{
            super.setValue(value, forKey: key)
        }
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}
