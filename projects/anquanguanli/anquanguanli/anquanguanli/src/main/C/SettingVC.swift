//
//  SettingVC.swift
//  anquanguanli
//
//  Created by apple on 16/3/22.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class SettingVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem=UIBarButtonItem(img:UIImage(named: "navigationbar_back_withtext"),hlimg:UIImage(named: "navigationbar_back_withtext_highlighted"), title: "返回"
            , tar: self, action: "back")
        navigationItem.rightBarButtonItem?.tintColor=UIColor.orangeColor()
        navigationItem.rightBarButtonItem=UIBarButtonItem(title: "完成", style: UIBarButtonItemStyle.Plain, target: self, action: "save")
        view.backgroundColor=UIColor.whiteColor()
//        navigationItem.rightBarButtonItem?.tintColor=UIColor.orangeColor()
//        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orangeColor()], forState: UIControlState.Normal)
        
       let lab = UILabel()
        lab.text="服务端IP端口"
        view.addSubview(lab)
        lab.sizeToFit()
        
        lab.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(10)
            make.top.equalTo(25+iTopBarH)
            make.width.equalTo(lab.size.width)
        }

        view.addSubview(ipinfo)
        ipinfo.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(lab.snp_right).offset(10)
            make.centerY.equalTo(lab)
            make.right.equalTo(-10)
            make.height.equalTo(38)
        }



    }
    
    func back(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func save(){
        if ipinfo.text =~ "^((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?):\\d{1,5}$"{
           let ac = UIAlertController(title: "提示", message: "确认将服务IP端口修改为\(ipinfo.text ?? "")", preferredStyle: UIAlertControllerStyle.Alert)
            ac.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                NetUtil.setServerIP(self.ipinfo.text!)
                self.back()
            }))
            ac.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler:nil))
            presentViewController(ac, animated: true, completion: nil)
            
        }else{
            iPop.toast("请输入正确的IP:端口 ")

        }
    }
    

    
    
    lazy var ipinfo:UITextField={
        let ipinfo = UITextField()
        ipinfo.borderStyle=UITextBorderStyle.RoundedRect
        let v = UIView(frame: CGRectMake(0, 0, 10, 0))
        ipinfo.leftView=v
        ipinfo.leftViewMode=UITextFieldViewMode.Always
        ipinfo.placeholder="ip:port"
        ipinfo.text=NetUtil.serverIP()
        return ipinfo
    }()
    

    
    
    

    

}
