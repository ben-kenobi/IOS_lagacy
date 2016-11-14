

//
//  Structs.swift
//  day50-sqlite
//
//  Created by apple on 15/12/23.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit
struct UserA{
    var name:String
    var age:Int
    var weight:Double
    mutating func eat(w:Double){
        weight += w
    }
    
}