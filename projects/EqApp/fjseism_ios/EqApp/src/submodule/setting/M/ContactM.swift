//
//  ContactM.swift
//  EqApp
//
//  Created by apple on 16/9/22.
//  Copyright © 2016年 apple. All rights reserved.
//

import Foundation
class ContactM:NSObject{
    var id:Int=0
    var serverId:String?
    var sex:Int=1
    var sortKey:String?
    var name:String?
    var phone:String?
    
    var co1ID:String?
    var co1:String?
    var co2ID:String?
    var co2:String?
    var jobPost:String?
    var department:String?
    var createDate:String?
    var email:String?
    var remark:String?
    var uploaded:Int=0
    
    
    func inserOrUpdate(){
        var dict = self.convert2dict()
        dict.removeValueForKey("id")
        
        if id==0{
            id = Int(ContactSer.ins.insert(dict))
        }else{
            ContactSer.ins.update(dict, wher: "id=?", args: [id])
        }
        
    }
    
    func delete(){
        ContactSer.ins.delete("id=?", args: [id])
    }
    
    
    
    
}
