//
//  ContactSearchArgs.swift
//  EqApp
//
//  Created by apple on 16/9/22.
//  Copyright © 2016年 apple. All rights reserved.
//

import Foundation
class ContactSearchArgs {
    let ary:[String]=["所属市","所属区县","所属部门","岗位"]
    
    
    
    
    var cityidx:Int = 0{
        didSet{
            distIdx=0
        }
    }
    var distIdx:Int = 0
    var deptIdx:Int = 0
    var jobIdx:Int = 0

    
    var SubordinatedCity:String{
        get{
            return ContactMod.cities1[cityidx]
        }
    }
    
    var SubordinatedDistrict:String{
        get{
            return ContactMod.districts1[cityidx][distIdx]

        }
    }

    var SubordinatedDepartment:String{
        get{
            return ContactMod.departments1[deptIdx]
        }
    }
    var SubordinatedJobPost:String{
        get{
            return ContactMod.jobPosts1[jobIdx]

        }
    }
    
    func valueBy(idx:Int)->String{
        if idx == 0{
            return SubordinatedCity
        }else if idx == 1{
            return SubordinatedDistrict
        }else if idx == 2{
            return SubordinatedDepartment
        }else if idx == 3{
            return SubordinatedJobPost
        }
        return ""
        
    }
    func idxBy(idx:Int)->Int{
        if idx == 0{
            return cityidx
        }else if idx == 1{
            return distIdx
        }else if idx == 2{
            return deptIdx
        }else if idx == 3{
            return jobIdx
        }
        return 0
    }
    
    func getAryBy(idx:Int)->[String]{
        if idx == 0{
            return ContactMod.cities1
        }else if idx == 1{
            return ContactMod.districts1[cityidx]
        }else if idx == 2{
            return ContactMod.departments1
        }else if idx == 3{
            return ContactMod.jobPosts1
        }
        return []
    }
    func setBy(idx:Int,subidx:Int){
        if idx == 0{
            cityidx=subidx
        }else if idx == 1{
            distIdx=subidx
        }else if idx == 2{
            deptIdx=subidx
        }else if idx == 3{
            jobIdx=subidx
        }
    }
    
    
    func genWhere()->String{
        var wher = " 1=1 "
        if SubordinatedCity != "全部"{
            wher += " and co1 = '\(SubordinatedCity)' "
        }
        if SubordinatedDistrict != "全部"{
            wher += " and co2 = '\(SubordinatedDistrict)' "
        }
        if SubordinatedDepartment != "全部"{
            wher += " and department = '\(SubordinatedDepartment)' "
        }
        if SubordinatedJobPost != "全部"{
            wher += " and jobPost = '\(SubordinatedJobPost)' "
        }
        return wher
    }
}
