//
//  ContactsVC.swift
//  EqApp
//
//  Created by apple on 16/9/13.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class ContactListVC: BaseVC {
    let celliden = "celliden"
  
    
    lazy var tv:UITableView={
        let tv=UITableView(frame: CGRect(x: 0, y: 0, width: self.view.w, height: self.view.h-iTopBarH), style: UITableViewStyle.Plain)
        tv.delegate=self
        tv.dataSource=self
        tv.separatorStyle=UITableViewCellSeparatorStyle.SingleLine
        tv.registerClass(ContactCell.self, forCellReuseIdentifier:self.celliden)
        tv.rowHeight=44
        tv.backgroundColor = iColor(0xffffffff)
        return tv
    }()
    lazy var ref:RefreshC={
        let ref=RefreshC()
        ref.addTarget(self, action: #selector(self.loadDatasFromServer), forControlEvents: UIControlEvents.ValueChanged)
        ref.tintColor=UIColor.orangeColor()
        return ref
    }()
    
    
    var searArg:ContactSearchArgs = ContactSearchArgs()
    var contactGroups:ContactGroups = ContactGroups()

    override func viewDidLoad() {
        super.viewDidLoad()
        title="通讯录"
    
        view.addSubview(tv)
        tv.addSubview(ref)
        let footer = UILabel(frame: CGRectMake(0, 0, iScrW, 60), txt: "无查询结果", color: iColor(0xff888888), font: ibFont(20), align: NSTextAlignment.Center, line: 1, bgColor:iColor(0xffffffff))
        tv.tableFooterView=footer
        
        navigationItem.rightBarButtonItem=UIBarButtonItem(title:"添加 " , titleColor:iColor(0xff55aaff),tar: self, action: #selector(self.onClick(_:)))

        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadDatasFromDB()
    }
    
    func onClick(sender:UIView){
        if sender == navigationItem.rightBarButtonItem?.customView{
            toDetail(nil)
        }
    }
    func toDetail(m:ContactM?){
        let vc = ContactDetailVC()
        if let m = m{
            vc.mod=m
        }
        showViewController(vc, sender: nil)
        
    }

   
    
    func loadDatasFromServer(){
        NetUtil.commonRequestJson(true, path: iConst.contactListUrl, para: nil, succode: ["200"],cb:{ (datas, idx) in
            self.ref.endRefreshing()
            if let ary = (datas as! [String:AnyObject])["data"] as? [[String:AnyObject]]{
                ContactSer.ins.synWithServer(ary)
                iPop.toast("同步服务器成功")
            }
            self.loadDatasFromDB()
            },failcb:{
                self.ref.endRefreshing()
            })
        
    }
    func loadDatasFromDB(){
        contactGroups = ContactSer.ins.findGroupsBy(self.searArg)
        tv.tableFooterView?.hidden = !(contactGroups.count==0)
        tv.reloadData()
    }
    
    deinit{
        ref.removeObs()
    }

}


extension ContactListVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return contactGroups.count+1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? searArg.ary.count : contactGroups.countByy(section-1)
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(celliden, forIndexPath: indexPath) as! ContactCell
        if indexPath.section==0{
            cell.textLabel?.text=searArg.ary[indexPath.row]
            cell.detailTextLabel?.text=searArg.valueBy(indexPath.row)
            cell.backgroundColor=iConst.khakiBg
        }else{
            let mod = contactGroups.modBy(indexPath.section-1, row: indexPath.row)
            cell.textLabel?.text=mod.name
            cell.detailTextLabel?.text=mod.phone
            cell.backgroundColor=iColor(0xffffffff)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "地域搜索"
        }
        return contactGroups.keys[section-1]
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 0{
            showChooser(indexPath)
        }else{
            let mod = contactGroups.modBy(indexPath.section-1, row: indexPath.row)
            let vc = ContactInfoVC(mod: mod)
            
            showViewController(vc, sender: nil)
        }
        
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 25
        }
        return 1
    }
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return contactGroups.keys
    }
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return index+1
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 48
        }
        return 38
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let tup = contactGroups.rmBy(indexPath.section-1, row: indexPath.row)
        tup.0.delete()
        if tup.1{
            tableView.deleteSections(NSIndexSet(index:indexPath.section), withRowAnimation: UITableViewRowAnimation.Fade)
        }else{
          tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
        
        
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.section==0{
            return false
        }
        return true
    }
    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "删除"
    }
   
    func showChooser(idxp:NSIndexPath){
        let bpop = StrAryPV(frame: CGRectMake(0, 0, 0, 260))
        bpop.datas=searArg.getAryBy(idxp.row)
        bpop.selidx=searArg.idxBy(idxp.row)
        bpop.title=searArg.ary[idxp.row]
        bpop.tag=idxp.row
        bpop.rightB=("完成",{
            (obj) in
            let o = obj as! StrAryPV
            self.searArg.setBy(o.tag, subidx: o.selIdx())
            self.tv.reloadSections(NSIndexSet(index:0), withRowAnimation: UITableViewRowAnimation.Fade)
            self.loadDatasFromDB()
            return true
        })
        bpop.leftB=("取消",nil)
        bpop.show()
        
    }
    
}

class ContactCell:UITableViewCell{
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Value1, reuseIdentifier: reuseIdentifier)
        self.accessoryView=UIImageView(image: iimg("arrow_right"))

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
