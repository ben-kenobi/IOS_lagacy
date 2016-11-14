//
//  LoginVC.swift
//  anquanguanli
//
//  Created by apple on 16/3/18.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class YFLoginVC: BaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
        userName.text="古田"
        pwd.text="123456"
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    
    func onClick(b:UIButton){
        if b==login {
            let name = userName.text
            let password = pwd.text
            if ""==name{
                iPop.toast("请输入账号")
                userName.becomeFirstResponder()
                return
            }
            if ""==password{
                iPop.toast("请输入密码")
                pwd.becomeFirstResponder()
                
                return
            }
            NetUtil.commonRequestJson(false, path: String(format: iConst.Login_URL,name!,password!), para: nil,succode: ["1","00"], cb: { (json,idx) -> ()  in
                
                UserInfo.me.token=json["token"] as? String
                UserInfo.me.userName=name
                UserInfo.me.pwd=password
                let userinfo = json["userInfo"] as! [String:AnyObject]
                UserInfo.me.userId=userinfo["ID"]as? String
                UserInfo.me.terminalPhone=userinfo["TERMINAL_PHONE"] as? String
                if idx==0 {
                    UserInfo.me.userUnit=userinfo["BELONGS_UNIT"]as? String
                    UserInfo.me.sysTitle=userinfo["TITLE"] as? String
                }else{
                    UserInfo.setWareHouse(json["wareHouse"] as? [String:AnyObject] )
                    
                }
                UserInfo.me.remPwd=self.remPwd.selected
                UserInfo.doLogin()
                iNotiCenter.postNotificationName(updateRootVCNoti, object: nil)
                
            })
            
            
            
            
        }else if b == setting{
            if count++ == 5{
                count=0
                let vc = SettingVC()
                vc.title="设置"
                vc.modalTransitionStyle=UIModalTransitionStyle.FlipHorizontal
                presentViewController(UINavigationController(rootViewController: vc), animated: true, completion: nil)
                //                showViewController(UINavigationController(rootViewController: vc), sender: nil)
                
            }
            
        }
    }
    
    
    
    
    func  initUI(){
        let iv=UIImageView(img: iimg("logo"))
        view.addSubview(iv)
        iv.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(0)
            make.top.equalTo(90)
            make.width.height.equalTo(80)
        }
        let iv2 = UIImageView(img: iimg("title")?.scale2w(iScrW-120))
        view.addSubview(iv2)
        iv2.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(0)
            make.top.equalTo(iv.snp_bottom).offset(10)
        }
        view.addSubview(userName)
        userName.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
            make.top.equalTo(iv2.snp_bottom).offset(20)
            make.height.equalTo(44)
        }
        view.addSubview(pwd)
        pwd.snp_makeConstraints { (make) -> Void in
            make.leading.trailing.height.equalTo(userName)
            make.top.equalTo(userName.snp_bottom).offset(13)
        }
        view.addSubview(remPwd)
        remPwd.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(pwd.snp_bottom).offset(10)
            make.leading.equalTo(pwd)
        }
        view.addSubview(login)
        login.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(remPwd.snp_bottom).offset(20)
            make.height.width.left.equalTo(pwd)
        }
        view.addSubview(setting)
        setting.snp_makeConstraints { (make) -> Void in
            make.bottom.leading.equalTo(0)
            make.width.height.equalTo(80)
        }
        if UserInfo.me.remPwd{
            remPwd.selected=true
            userName.text=UserInfo.me.userName
            pwd.text=UserInfo.me.pwd
        }
        
    }
    
    
    
    lazy var userName:UITextField = {
        let userName = UITextField()
        userName.borderStyle=UITextBorderStyle.RoundedRect
        let v = UIView(frame: CGRectMake(0, 0, 10, 0))
        userName.leftView=v
        userName.leftViewMode=UITextFieldViewMode.Always
        userName.placeholder="用户名"
        return userName
    }()
    lazy var pwd:UITextField = {
        let userName = UITextField()
        userName.borderStyle=UITextBorderStyle.RoundedRect
        let v = UIView(frame: CGRectMake(0, 0, 10, 0))
        userName.leftView=v
        userName.leftViewMode=UITextFieldViewMode.Always
        userName.placeholder="密码"
        userName.secureTextEntry=true
        return userName
    }()
    
    lazy var remPwd:UIButton = {
        let remPwd = UIButton(img: iimg("checkbox_empty")!, selImg: iimg("checkbox_full")!, title: "记住密码")
        
        return remPwd
    }()
    lazy var login:UIButton = {
        let login=UIButton()
        login.backgroundColor=iColor(0x31, g: 0x8B, b: 0xD2)
        login.setTitle("登录", forState: .Normal)
        login.addTarget(self, action: #selector(YFLoginVC.onClick(_:)), forControlEvents: .TouchUpInside)
        return login
    }()
    
    lazy var setting:UIButton = {
        let setting = UIButton()
        
        setting.addTarget(self, action: #selector(YFLoginVC.onClick(_:)), forControlEvents: .TouchUpInside)
        return setting
    }()
    var count:Int = 0
    
}
