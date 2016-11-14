//
//  DropInfoVM.swift
//  EqApp
//
//  Created by apple on 16/9/23.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class DropInfoVM: NSObject {
    let ary:[String]=["性别","所属市","所属区县","所属部门","岗位"]
    
    
    var idxes:[Int]=[0,0,0,0,0]
    
    func valueBy(idx:Int)->String{
        return getAryBy(idx)[idxes[idx]]
    }
    func idxBy(val:String,idx:Int)->Int{
        return getAryBy(idx).indexOf(val) ?? 0
    }
    
    
    
    func idxBy(idx:Int)->Int{
        return idxes[idx]
    }
    
    func getAryBy(idx:Int)->[String]{
        if idx == 1{
            return ContactMod.cities
        }else if idx == 2{
            return ContactMod.districts[idxes[1]]
        }else if idx == 3{
            return ContactMod.departments
        }else if idx == 4{
            return ContactMod.jobPosts
        }else if idx == 0{
            return ContactMod.sexs
        }
        return []
    }
    func setBy(idx:Int,subidx:Int){
        idxes[idx]=subidx
        if idx == 1{
            idxes[2]=0
        }
       
    }
    
    
    

}
