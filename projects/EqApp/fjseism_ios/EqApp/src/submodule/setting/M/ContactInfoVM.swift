//
//  ContactInfoVM.swift
//  EqApp
//
//  Created by apple on 16/9/23.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class ContactInfoVM: NSObject {
    var info:ContactM
    let sec1title:[String]=["所属市","所属区县","所属部门","岗位","邮箱"]
    var sec3text:[(String,UIColor)]=[("上传联系人",iConst.iGlobalBlue),
                                     ("拨打电话",iConst.iGlobalBlue),
                                     ("发送短信",iConst.iGlobalBlue),
                                     ("删除联系人",iColor(0xffff8888))]
    
    init(info:ContactM){
        self.info=info
        super.init()
    }
    
    
    func valofIdx4sec1(idx:Int)->String?{
        if idx  == 0{
            return info.co1
        }
        if idx == 1{
            return info.co2
        }
        if idx  == 2{
            return info.department
        }
        if idx == 3{
            return info.jobPost
        }
        if idx  == 4{
            return info.email
        }
        return ""
    }
}
