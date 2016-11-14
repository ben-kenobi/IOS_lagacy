
//
//  Wine.swift
//  day43-shoppingcart
//
//  Created by apple on 15/12/19.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class Wine: NSObject {
    var Discount :String?
     var money :String?
     var Quantity :String?
     var image :String?
     var ProductID :String?
     var OriginalPrice :String?
    var name :String?
    
    var quan:Int{
        set{

            Quantity="\(newValue)"

        }
        get{
            return Int(Quantity ?? "0")!
        }
    }
    var total:Double{
        return Double(quan) * Double(money ?? "0")!
    }
    
    
    init(dict :[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
//    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
//        print(key)
//    }

}
