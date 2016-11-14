



//
//  Modle.swift
//  day42-swiftbeginning
//
//  Created by apple on 15/12/4.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class Modle: NSObject {

    var name:String?
    var age:Int=0
    var time:NSDate?
    
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
