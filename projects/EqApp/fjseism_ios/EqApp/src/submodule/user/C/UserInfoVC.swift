//
//  UserInfoVC.swift
//  EqApp
//
//  Created by apple on 16/8/30.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class UserInfoVC: BaseSettingVC {
    
    var detailary:[[String?]] = []
    
    override func viewDidLoad() {
        title="个人设置"
        pname="userinfos.plist"
        super.viewDidLoad()
      
    }
    
    override func viewWillAppear(animated: Bool) {
        detailary=[[UserInfo.me.PHONE,UserInfo.me.EMAIL],[UserInfo.me.CO1_NAME,
            UserInfo.me.CO2_NAME,UserInfo.me.town],[UserInfo.me.DEPART_NAME,
                UserInfo.me.JOB_POST_NAME],[nil]]
        tableView.reloadData()
    }
    

}
extension UserInfoVC{
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        cell.detailTextLabel?.text=detailary[indexPath.section][indexPath.row]
        return cell
    }
  
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 4
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section != 0{
            return 4
        }
        return UITableViewAutomaticDimension
    }
    
    func onItemClick(idx:NSIndexPath){
        if idx.section==0{
            let vc = ModiUserInfoVC()
            vc.flag=idx.row
            self.navigationController?.showViewController(vc, sender: nil)

        }else if idx.section==3{
            let vc = ModiPwdVC()
            self.navigationController?.showViewController(vc, sender: nil)
        }
        
    }
}
