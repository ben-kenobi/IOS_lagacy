//
//  RetrievePwdVC.swift
//  EqApp
//
//  Created by apple on 16/8/25.
//  Copyright © 2016年 apple. All rights reserved.
//



class RetrievePwdVC: BaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title="找回密码"
        view.backgroundColor=iConst.iGlobalBG
        initUI()

    }
    
    func initUI(){
        let usernamelab = UILabel(frame: CGRectMake(30, 0, iScrW, 38), txt: "输入用户名", color: iColor(0xff333333), font: iFont(16),  line: 1)
        view.addSubview(usernamelab)
        username = ClearableTF(frame: CGRectMake(0, usernamelab.b+2, iScrW, 44), bg: iColor(0xffffffff))
        username!.leftView=UIView(frame: CGRectMake(0, 0, 12, 0))
        username!.leftViewMode = .Always
        view.addSubview(username!)
        
        
        
        let emailab = UILabel(frame: CGRectMake(30, username!.b+9, iScrW, 38), txt: "输入验证邮箱", color: iColor(0xff333333), font: iFont(16),  line: 1)
        view.addSubview(emailab)
        let tf = ClearableTF(frame: CGRectMake(0, emailab.b+2, iScrW, 44), bg: iColor(0xffffffff))
        tf.leftView=UIView(frame: CGRectMake(0, 0, 12, 0))
        tf.leftViewMode = .Always
        view.addSubview(tf)
        email = tf
        let btn = UIButton(frame: CGRectMake(20, tf.b+20, iScrW-40, 52),bgimg: iimg(iColor(0, 120, 255, 1)), hlbgimg: iimg(iColor(0,150,200,1)), tar: self,action:#selector(self.onClick(_:)))
        btn.layer.cornerRadius=8
        btn.layer.masksToBounds=true
        btn.setTitle("发 送", forState: UIControlState.Normal)
        btn.setTitleColor(iColor(0xffffffff), forState: .Normal)
        view.addSubview(btn)
        send = btn
        
    }
    func onClick(sender:View){
        if sender == send{
            let un  = username!.text
            let em = email!.text
            if(empty(un)){
                iPop.toast("请填写用户名")
                username?.becomeFirstResponder()
                return ;
            }
            if(!String.isEmail(em)){
                iPop.toast("邮箱格式不正确")
                email!.becomeFirstResponder()
                return;
            }
            let path = iConst.retrievePwd + "?name=\(un!)&email=\(em!)"
            NetUtil.commonRequestJson(true, path: path, para: nil, succode: ["200"], cb: { (data, idx) in
//                CommonAlertView.viewWith("提示", mes:(data["msg"] as? String), btns: ["确定"], cb: { (pos, dialog) -> Bool in
//                    self.dismissViewControllerAnimated(true, completion: nil)
//                    return true
//
//                }).show()
               
                iDialog.dialogWith("提示", msg: (data["msg"] as? String), actions: [ UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: { (aa) in
                    self.dismissViewControllerAnimated(true, completion: nil)
                    
                })], vc: self)
                
                
            })
            
            

        }
        
    }
    var username:ClearableTF?
    var email:ClearableTF?
    var send:UIButton?

}
