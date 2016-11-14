
//
//  SettingVC.swift
//  EqApp
//
//  Created by apple on 16/9/13.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class SettingVC: BaseSettingVC {
    var detailary:[[String?]] = [["","30天"],[""],[""],["","未发现新版本"]]
    lazy var logout:UIButton={
        return UIButton(frame: nil, title: "账号注销", font: ibFont(20), titleColor: iColor(0xffffffff),  bgcolor: iColor(0xffcc3333), corner: 6, bordercolor: iColor(0xffbbbbbb), borderW: 1, tar: self, action: #selector(self.dologout), tag: 0)
    
    }()
    
  
    override func viewDidLoad() {
        title="系统设置"
        pname="settings.plist"
        super.viewDidLoad()
        detailary[0][1] =  "\(UserInfo.getPwdReservedDays())天";

        tableView.tableFooterView=UIView()
        tableView.tableFooterView?.h=iScrH-iTopBarH-rowh*6-10-8*3-10
        tableView.tableFooterView?.addSubview(logout)
        logout.snp_makeConstraints { (make) in
            make.left.equalTo(15)
            make.bottom.right.equalTo(-15)
            make.height.equalTo(52)
        }
        checkVersion()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        tableView.reloadData()
    }
    func dologout(){
        dismissViewControllerAnimated(false) { 
            UserInfo.logout()
        }
        
    }
  
    func checkVersion(){
     
        NetUtil.commonRequestJson(true, path: "version.txt", para: nil, succode: ["200"],cb:{ (data, idx) in
            let dict = (data as! [String:AnyObject])
            if dict["version"]!.integerValue > AppDelegate.iversion(){
                PrefUtil.putByUser("updateNotice", value: "0")
            }else{
                PrefUtil.putByUser("updateNotice", value: "1")
            }
            self.updateCheck()

        })
        
    }
    func updateCheck(){
        detailary[3][1] = "1" == PrefUtil.getByUser("updateNotice", defau: "1") ? "未发现新版本" : "发现新版本"
        tableView.reloadData()
    }
}

extension SettingVC{
    
    
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
        return 10
    }
    
    func showPwdKeepDaysChooser(idxp:NSIndexPath){
        let bpop = NumberPV(frame: CGRectMake(0, 0, 0, 260))
        bpop.selidx=UserInfo.getPwdReservedDays()
        bpop.title="选择天数"
        bpop.rightB=("完成",{
            (obj) in
            let o = obj as! NumberPV
            let day = o.selIdx()
            UserInfo.setPwdReservedDays(day)
            self.detailary[0][1] =  "\(UserInfo.getPwdReservedDays())天"
            self.tableView.reloadData()
            return true
        })
        bpop.leftB=("取消",{
            (obj) in
            return true
        })
        bpop.show()
        
    }

    func updateVersion(idxp:NSIndexPath){
        if "1" == PrefUtil.getByUser("updateNotice", defau: "1"){
            let vc = UIAlertController(title: "提示", message: "已经是最新版本", preferredStyle: .Alert)
            vc.addAction(UIAlertAction(title: "确定", style: .Default, handler: nil))
            presentViewController(vc, animated: true, completion: nil)
        }else{
            let vc = UIAlertController(title: "提示", message: "发现新版本，请前往更新", preferredStyle: .Alert)
            presentViewController(vc, animated: true, completion: nil)
            vc.addAction(UIAlertAction(title: "确定", style: .Default, handler: nil))
        }
    }




}
