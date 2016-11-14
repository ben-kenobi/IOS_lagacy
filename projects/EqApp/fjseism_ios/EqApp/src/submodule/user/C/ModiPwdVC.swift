//
//  ModiPwdVC.swift
//  EqApp
//
//  Created by apple on 16/9/1.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class ModiPwdVC: BaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor=iConst.iGlobalBG
        initUI()
        title="密码修改"
        
    }
    
    func initUI(){
        let usernamelab = UILabel(frame: CGRectMake(30, 10, iScrW, 38), txt: "修改密码", color: iColor(0xff333333), font: iFont(16),  line: 1)
        let tfh:CGFloat = 52
        let v = UIView(frame: CGRectMake(-1, usernamelab.b+2, iScrW+2, tfh*3), bg: iColor(0xffffffff),  bordercolor:iColor(0xffdddddd),borderW:1)
        view.addSubview(usernamelab)
        view.addSubview(v)
        
        let left:CGFloat = 12.0
        let stary = ["原密码","新密码","重新输入"]
        for idx in 0..<3{
            let y = CGFloat(idx)*tfh
            let iv = UIImageView(frame: CGRectMake(left, y, 26, tfh), img: iimg("password"))
            iv.contentMode = .ScaleAspectFit
            v.addSubview(iv)
            let lab = UILabel(frame: CGRectMake(iv.r+8, y, 80, tfh), txt: stary[idx], color: iColor(0xff000000), font: iFont(18), align: .Left, line: 1)
            v.addSubview(lab)
            let tf = ClearableTF(frame: CGRectMake(lab.r, y, v.w-lab.r, tfh))
            v.addSubview(tf)
            pwds.append(tf)
            if idx>0{
                let line=UIView(frame: CGRectMake(lab.r-30, y, iScrW, 1), bg: iColor(0xffdddddd))
                v.addSubview(line)
            }
        }
        navigationItem.rightBarButtonItem=UIBarButtonItem(title:"完成 " , titleColor:iColor(0xff55aaff),tar: self, action: #selector(self.onClick(_:)))
        
        
    }
    var pwds:[ClearableTF]=[]
    
    
    func onClick(sender:UIView){
        let paras=check()
        if empty(paras){
            return
        }
        let path = iConst.upPwd + "?" + paras!
        NetUtil.commonRequestJson(true, path: path, para: nil, succode: ["200"],cb: { (data, idx) in
            iPop.toast("\((((data as! [String:AnyObject])["msg"]) as? String) ?? "")")
            self.navigationController?.popViewControllerAnimated(true)
        })
        
    }
    func check()->String?{
        var  paras = ""
        let old = pwds[0].text
        let newp = pwds[1].text
        let newp2 = pwds[2].text
        
        if !(old == PrefUtil.getPwd()){
            iPop.toast("原密码不匹配,请重新输入")
            pwds[0].becomeFirstResponder()
            return nil
        }
        if(!String.isPwd(newp)){
            iPop.toast("新密码不符合规范，只能由6到20位的数字,字母及下划线组成");
            pwds[1].becomeFirstResponder()
            return nil
        }
        if(!(newp == newp2)){
            iPop.toast("两次输入的新密码不一致");
            pwds[2].becomeFirstResponder();
            return nil;
        }
        paras += "name="+(UserInfo.me.NAME ?? "")
        paras += "&pwd=" + old!
        paras += "&newPwd="+newp!
        return paras
    }
    
    
}
