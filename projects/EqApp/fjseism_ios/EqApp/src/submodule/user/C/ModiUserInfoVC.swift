//
//  ModiUserInfoVC.swift
//  EqApp
//
//  Created by apple on 16/8/31.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class ModiUserInfoVC: BaseVC {
    var flag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
        if flag==0{
            navigationItem.title="电话号码修改"
            tf?.placeholder="输入新的电话号码"
            tf?.text=UserInfo.me.PHONE
        }else if flag == 1{
            navigationItem.title="邮箱修改"
            tf?.placeholder="输入新的邮箱"
            tf?.text=UserInfo.me.EMAIL

        }
        view.backgroundColor=iConst.iGlobalBG
        
    }
    
    func initUI(){
        let usernamelab = UILabel(frame: CGRectMake(30, 0, iScrW, 38), txt: "输入修改信息", color: iColor(0xff333333), font: iFont(16),  line: 1)
        view.addSubview(usernamelab)
        tf = ClearableTF(frame: CGRectMake(0, usernamelab.b+2, iScrW, 44), bg: iColor(0xffffffff))
        tf!.leftView=UIView(frame: CGRectMake(0, 0, 12, 0))
        tf!.leftViewMode = .Always
        view.addSubview(tf!)
        
        
        let btn = UIButton(frame: CGRectMake(20, tf!.b+20, iScrW-40, 52),bgimg: iimg(iColor(0, 120, 255, 1)), hlbgimg: iimg(iColor(0,150,200,1)), tar: self,action:#selector(self.onClick(_:)))
        btn.layer.cornerRadius=8
        btn.layer.masksToBounds=true
        btn.setTitle("发 送", forState: UIControlState.Normal)
        btn.setTitleColor(iColor(0xffffffff), forState: .Normal)
        view.addSubview(btn)
        send = btn
        
    }
    
    func check()->String?{
        var str = ""
        let content = tf?.text
        if(flag==0){
            if(!String.isPhoneNum(content)){
                iPop.toast("不是合法的手机号码")
                return nil
            }else{
                str += "phone="+content!
            }
        }else if(flag==1){
            if(!String.isEmail(content)){
                iPop.toast("不是正确的邮箱")
                return nil
            }else{
                str += "email="+content!
            }
            
        }
        str += "&token=" + (UserInfo.me.token ?? "")
        
        return str
    }
    
    func onClick(sender:View){
        
        if sender == send{
            let paras:String? = check()
            if empty(paras){
                return ;
            }
            let path = iConst.upUserInfo + "?\(paras!)"
            NetUtil.commonRequestJson(true, path: path, para: nil, succode: ["200"], cb: { (data, idx) in
                iPop.toast("\((((data as! [String:AnyObject])["msg"]) as? String) ?? "")")
                
                if self.flag == 0 {
                    UserInfo.me.PHONE=self.tf?.text
                }else if self.flag == 1 {
                    UserInfo.me.EMAIL=self.tf?.text
                    
                }
                self.navigationController?.popViewControllerAnimated(true)
                
                
            })
            
            
            
        }
        
    }
    
    var tf:ClearableTF?
    var send:UIButton?
    
}
