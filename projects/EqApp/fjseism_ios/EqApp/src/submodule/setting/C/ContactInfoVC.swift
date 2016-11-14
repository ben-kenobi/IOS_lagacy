
//
//  ContactInfoVC.swift
//  EqApp
//
//  Created by apple on 16/9/23.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class ContactInfoVC: BaseVC {
    
    let celliden1 = "celliden1"
    let celliden2 = "celliden2"
    let celliden3 = "celliden3"
    
    
    var info:ContactInfoVM
    
    init(mod:ContactM){
        info = ContactInfoVM(info: mod)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tv:UITableView={
        let tv=UITableView(frame: CGRect(x: 0, y: 0, width: self.view.w, height: self.view.h-iTopBarH), style: UITableViewStyle.Grouped)
        tv.delegate=self
        tv.dataSource=self
        tv.separatorStyle=UITableViewCellSeparatorStyle.SingleLine
        tv.registerClass(ContactCell.self, forCellReuseIdentifier:self.celliden1)
        tv.registerClass(RemarkCell.self, forCellReuseIdentifier:self.celliden2)
        tv.registerClass(UITableViewCell.self, forCellReuseIdentifier:self.celliden3)
        tv.bounces=false
        return tv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "联系人信息"
        view.addSubview(tv)
        
        tv.tableFooterView=UIView()
        
        
        navigationItem.rightBarButtonItem=UIBarButtonItem(title:"编辑 "  , titleColor:iColor(0xff55aaff),tar: self, action: #selector(self.onClick(_:)))
    }
    
    func onClick(sender:UIButton){
        let vc = ContactDetailVC()
        vc.mod=info.info
        showViewController(vc, sender: nil)
    }
    func updateUI(){
        if info.info.uploaded == 0{
            info.sec3text[0].0="同步联系人"
        }else{
            info.sec3text[0].0="上传联系人"
        }
        tv.reloadData()
        tv.tableHeaderView=view4header()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    func view4header()->UIView{
        let v = UIView(frame:CGRectMake(0, 0, iScrW, 70))
        v.backgroundColor=iColor(0xffffffff)
        let name = UILabel(frame: nil, txt: info.info.name ?? "", color: iColor(0xff555555), font: iFont(18), align: NSTextAlignment.Left, line: 1)
        let iv = UIImageView(image: iimg(info.info.sex == 1 ? "men":"women"))
        let phonelab = UILabel(frame: nil, txt: "手机号码:", color: iConst.iGlobalBlue, font: iFont(18), align: .Left, line: 1)
        let phone = UILabel(frame: nil, txt: info.info.phone ?? "", color: iColor(0xff777777), font: iFont(17), align: .Left, line: 1)
        v.addSubview(name)
        v.addSubview(iv)
        v.addSubview(phonelab)
        v.addSubview(phone)
        name.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(10)
        }
        iv.snp_makeConstraints { (make) in
            make.centerY.equalTo(name)
            make.left.equalTo(name.snp_right).offset(20)
        }
        phonelab.snp_makeConstraints { (make) in
            make.left.equalTo(name)
            make.top.equalTo(name.snp_bottom).offset(8)
        }
        phone.snp_makeConstraints { (make) in
            make.left.equalTo(phonelab.snp_right).offset(15)
            make.centerY.equalTo(phonelab)
            
        }
        return v
        
    }
    
    
    
}

extension ContactInfoVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? info.sec1title.count : section == 1 ? 1 : info.sec3text.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCellWithIdentifier(celliden1, forIndexPath: indexPath) as! ContactCell
            cell.textLabel?.text = info.sec1title[indexPath.row]
            cell.detailTextLabel?.text=info.valofIdx4sec1(indexPath.row)
            cell.selectionStyle = .None
            cell.accessoryView?.hidden=true
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCellWithIdentifier(celliden2, forIndexPath: indexPath) as! RemarkCell
            cell.title.text="备注"
            cell.selectionStyle = .None
            cell.content.text=info.info.remark
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier(celliden3, forIndexPath: indexPath)
            let tup = info.sec3text[indexPath.row]
            cell.textLabel?.text=tup.0
            cell.textLabel?.textColor = tup.1
            cell.textLabel?.font=ibFont(20)
            return cell
        }
        
        
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        sec3ClickedAt(indexPath.row)
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 1{
            return UITableViewAutomaticDimension
        }
        return 44
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 1{
            return 70
        }
        return 44
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    
    func sec3ClickedAt(idx:Int){
        if idx == 0 {
            uploadInfo()
            
        }else if idx == 1{
            iApp.openURL(iUrl("tel://\(info.info.phone!)")!)
        }else if idx == 2{
            iApp.openURL(iUrl("sms://\(info.info.phone!)")!)
        }else if idx==3{
            let vc = UIAlertController(title: "警告", message: "确定删除该联系人？", preferredStyle: .Alert)
            vc.addAction(UIAlertAction(title: "取消", style: .Default, handler: nil))
            vc.addAction(UIAlertAction(title: "确定", style: .Destructive, handler: { (aa) in
                self.info.info.delete()
                self.navigationController?.popViewControllerAnimated(true)
            }))
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }
    func uploadInfo(){
        
    }
}



class RemarkCell:UITableViewCell{
    lazy var title:UILabel={
        let title = UILabel(frame: nil, txt: "", color: iColor(0xffaaaaaa), font: ibFont(18), align: NSTextAlignment.Left, line: 1)
        return title
    }()
    
    lazy var content:UILabel={
        let content = UILabel(frame: nil, txt: "", color: iColor(0xff555555), font: iFont(17), align: NSTextAlignment.Left, line: 0)
        return content
        
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(title)
        title.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(16)
            make.height.equalTo(22)
            make.width.equalTo(contentView.snp_width)
        }
        contentView.addSubview(content)
        content.snp_makeConstraints { (make) in
            make.left.equalTo(16)
            make.width.equalTo(contentView.snp_width).offset(-26)
            make.top.equalTo(title.snp_bottom)
            make.bottom.equalTo(-16)
            make.height.greaterThanOrEqualTo(44)
        }
        //        let linetop = UIView(frame:CGRectMake(0, 0, iScrW, 1))
        //        linetop.backgroundColor=UIColor.lightGrayColor()
        //        contentView.addSubview(linetop)
        //        let linebot = UIView()
        //        linebot.backgroundColor=UIColor.lightGrayColor()
        //        contentView.addSubview(linebot)
        //        linebot.snp_makeConstraints { (make) in
        //            make.left.bottom.width.equalTo(contentView)
        //            make.top.equalTo(contentView.snp_bottom).offset(-1)
        //        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
