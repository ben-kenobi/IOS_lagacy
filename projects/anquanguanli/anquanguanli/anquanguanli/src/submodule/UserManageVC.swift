//
//  UserManageVC.swift
//  anquanguanli
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class UserManageVC: BaseVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
        
    }
    
    
    
    lazy var inshis:UIButton={
        let inshis = UIButton(title: "历史指令", font: iFont(18), titleColor: UIColor.whiteColor(),  bgimg: iimg("tabbar_compose_button"), hlbgimg: iimg("tabbar_compose_button_highlighted"),  tar: self, action: #selector(onClick(_:)))
        
        self.view.addSubview(inshis)
        
        return inshis
    }()
    
    lazy var logout:UIButton={
        let inshis = UIButton(title: "退出", font: iFont(18), titleColor: UIColor.whiteColor(),  bgimg: iimg("tabbar_compose_button"), hlbgimg: iimg("tabbar_compose_button_highlighted"),  tar: self, action: #selector(onClick(_:)))
        
        self.view.addSubview(inshis)
        
        return inshis
    }()

}


extension UserManageVC{
    func initUI(){
        inshis.snp_makeConstraints { (make) in
             make.centerX.equalTo(0)
            make.width.equalTo(self.view.snp_width).offset(100)
            make.height.equalTo(60)
            make.top.equalTo(30+iTopBarH)
        }
        logout.snp_makeConstraints { (make) in
            make.centerX.width.height.equalTo(inshis)
            make.top.equalTo(inshis.snp_bottom).offset(20)
        }
        
        
    }
    
    func onClick(b:UIButton){
        if b==inshis{
            let vc = InstructionVC()
            navigationController?.showViewController(vc, sender: nil)
        }else if b == logout{
            
            NetUtil.commonRequest(true, path:String(format:iConst.Logout_URL,UserInfo.me.token!), para: nil, cb: { (suc) in
                if suc{
                    UserInfo.doLogout()
                    iNotiCenter.postNotificationName(updateRootVCNoti, object: nil)
                }else{
                    iPop.toast("登出失败")
 
                }
                
            })
        }
        
    }
    
  
}
