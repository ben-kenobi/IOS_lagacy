//
//  ContactGroup.swift
//  EqApp
//
//  Created by apple on 16/9/22.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit



class ContactGroups:NSObject{
    var dict:[String:ContactGroup] = [:]{
        didSet{
            genKeys()
        }
    }
    
    var keys:[String] = []
    
    func genKeys(){
        keys = Array(dict.keys).sort({ (left, right) -> Bool in
            if left == "#"{
                return false
            }
            if right == "#"{
                return true
            }
            return left.compare(right) == NSComparisonResult.OrderedAscending
        })
    }
    func groupBy(idx:Int)->ContactGroup{
        return dict[keys[idx]]!
    }
    func countByy(idx:Int)->Int{
        return dict[keys[idx]]?.count ?? 0
    }
    func modBy(sec:Int,row:Int)->ContactM{
        return groupBy(sec).mods[row]
    }
    
    func rmBy(sec:Int,row:Int)->(ContactM,Bool){
        if groupBy(sec).mods.count>1{
            return (groupBy(sec).mods.removeAtIndex(row),false)
        }
        let mods = groupBy(sec).mods
        dict.removeValueForKey(keys[sec])
        genKeys()
        return (mods[0],true)
    }
    
    var count:Int{
        get{
            return dict.count
        }
    }
}


class ContactGroup: NSObject {
    
    var mods:[ContactM]=[]
    var count:Int{
        get{
            return mods.count
        }
    }

}
