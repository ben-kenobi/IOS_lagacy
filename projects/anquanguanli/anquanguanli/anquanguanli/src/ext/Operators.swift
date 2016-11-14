//
//  Operators.swift
//  day50-sqlite
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

infix operator =~ {
associativity none
precedence 130
}

func =~ (str:String?,re:String)->Bool{
    print(str,re)
    do{
        guard let s=str else{
            return false
        }
        return try NSRegularExpression(pattern: re, options:.CaseInsensitive).firstMatchInString(s, options: [], range: NSMakeRange(0, s.characters.count)) != nil
    }catch _{
        return false
    }
}




func ~=(pattern:NSRegularExpression,input:String)->Bool{
    return pattern.firstMatchInString(input, options: [], range: NSMakeRange(0, input.characters.count)) != nil
}

prefix operator ~/{}
prefix func ~/(pattern:String) -> NSRegularExpression  {
    return try! NSRegularExpression(pattern: pattern, options: .CaseInsensitive)
}
