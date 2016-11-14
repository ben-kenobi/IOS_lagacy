

//
//  ShoppingCart.swift
//  day43-shoppingcart
//
//  Created by apple on 15/12/19.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class ShoppingCart: NSObject {
    
    var dict:[String:Wine]=[String:Wine]()
    
    
    func save(dic:Wine,cb:((quan:Int,total:Double)->())?=nil){
        if dic.quan <= 0{
            dict.removeValueForKey(dic.name!)
        }else{
            dict[dic.name!]=dic
        }
        cb?(quan: quan, total: total)
    }
    
    var quan:Int{
        return dict.keys.count
    }
    
    var total:Double{
        var total:Double = 0
        for (_,v) in dict{
            total += v.total
        }
        return total
    }
    
    
    
    static let ins=ShoppingCart()
    
    private override init() {
        super.init()
    }
    
    
    
}
