//
//  ContactDetailVC.swift
//  EqApp
//
//  Created by apple on 16/9/23.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class ContactDetailVC: BaseVC {
    let celliden1 = "celliden1"
    let celliden2 = "celliden2"


    var mod:ContactM = ContactM()
    var dropinfo:DropInfoVM=DropInfoVM()
    var info:[(String,String)] = [("姓名",""),("手机号码",""),("邮箱","")]
    lazy var textV:UITextView={
        let txv=UITextView(frame: nil, bg: iColor(0xffffffff), corner: 6, bordercolor: iColor(0xff888888), borderW: 1)
        txv.font=iFont(17)
//        txv.contentInset=UIEdgeInsetsMake(10, 15, 8, 8)
        
        return txv
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if mod.id != 0{
            title="编辑联系人"
        }else{
            title="添加联系人"

        }
        
        view.addSubview(tv)
        navigationItem.rightBarButtonItem=UIBarButtonItem(title:"完成 "  , titleColor:iColor(0xff55aaff),tar: self, action: #selector(self.onClick(_:)))
        
        
        let footer = UIView(frame: CGRectMake(0, 0, iScrW, 150))
        
        let lab = UILabel(frame: nil, txt: "备注", color:iConst.iGlobalBlue, font: iFont(18), align: NSTextAlignment.Left, line: 1)
        footer.addSubview(lab)
        footer.addSubview(textV)
        lab.snp_makeConstraints { (make) in
            make.left.equalTo(12)
            make.top.equalTo(12)
        }
        textV.snp_makeConstraints { (make) in
            make.left.equalTo(12)
            make.right.equalTo(-12)
            make.top.equalTo(lab.snp_bottom).offset(4)
            make.bottom.equalTo(0)
        }
        
        tv.tableFooterView=footer
        
        
        iNotiCenter.addObserver(self, selector: #selector(self.tfChange(_:)), name:UITextFieldTextDidChangeNotification, object: nil)
         iNotiCenter.addObserver(self, selector: #selector(self.onKeyboardChange(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
        updateUI()
    }

    
    
    
    lazy var tv:UITableView={
        let tv=UITableView(frame: CGRect(x: 0, y: 0, width: self.view.w, height: self.view.h-iTopBarH), style: UITableViewStyle.Grouped)
        tv.delegate=self
        tv.dataSource=self
        tv.separatorStyle=UITableViewCellSeparatorStyle.SingleLine
        tv.registerClass(ContactCell.self, forCellReuseIdentifier:self.celliden2)
        tv.registerClass(ContactEditCell.self, forCellReuseIdentifier:self.celliden1)

        tv.rowHeight=44
        return tv
    }()
    
    func onClick(sender:UIView){
        if sender == navigationItem.rightBarButtonItem?.customView{
            if empty(mod.name){
                iPop.toast("请输入姓名")
                let cell = tv.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! ContactEditCell
                cell.tf.becomeFirstResponder()
                return
            }
            if !String.isPhoneNum(mod.phone){
                iPop.toast("请输入正确的手机号码")
                let cell = tv.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as! ContactEditCell
                cell.tf.becomeFirstResponder()
                return
            }
            if !String.isEmail(mod.email){
                iPop.toast("请输入正确的邮箱")
                let cell = tv.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0)) as! ContactEditCell
                cell.tf.becomeFirstResponder()
                return
            }
            mod.sex=dropinfo.idxes[0]+1
            mod.co1=dropinfo.valueBy(1)
            mod.co2=dropinfo.valueBy(2)
            mod.department=dropinfo.valueBy(3)
            mod.jobPost=dropinfo.valueBy(4)
            mod.sortKey = mod.name?.upPhonetic()
            mod.createDate=iConst.TIMESDF.stringFromDate(NSDate())
            mod.remark=textV.text
            mod.inserOrUpdate()

            navigationController?.popViewControllerAnimated(true)

            
        }

    }
    func updateUI(){
        dropinfo.setBy(0, subidx: mod.sex-1)
        dropinfo.setBy(1, subidx: dropinfo.idxBy(mod.co1 ?? "", idx: 1) )
        dropinfo.setBy(2, subidx: dropinfo.idxBy(mod.co2 ?? "", idx: 2))
        dropinfo.setBy(3, subidx: dropinfo.idxBy(mod.department ?? "", idx: 3))
        dropinfo.setBy(4, subidx: dropinfo.idxBy(mod.jobPost ?? "", idx: 4))
        textV.text=mod.remark
    }
    
    func tfChange(noti:NSNotification){
        let tf = noti.object as! UITextField
        
        setModInfoBy(tf.text ?? "",idx:tf.tag)
    }
    
    func onKeyboardChange(noti:NSNotification){
        if !textV.isFirstResponder(){
            return
        }
        if let userinfo = noti.userInfo{
            let dura=Double((userinfo[UIKeyboardAnimationDurationUserInfoKey] as? String) ??
                "0")
            
            
            let endframe:CGRect = (userinfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
            UIView.animateWithDuration(dura!, animations: {
                self.tv.contentOffset=CGPointMake(0, -(endframe.origin.y-self.view.h))
            })
            
            
        }
        
    }

    
    deinit{
        iNotiCenter.removeObserver(self)
    }
   
}

extension ContactDetailVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? info.count : dropinfo.ary.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section==1{
           let cell = tableView.dequeueReusableCellWithIdentifier(celliden2, forIndexPath: indexPath) as! ContactCell
            cell.backgroundColor=iConst.khakiBg
            cell.textLabel?.text=dropinfo.ary[indexPath.row]
            cell.detailTextLabel?.text=dropinfo.valueBy(indexPath.row)
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier(celliden1, forIndexPath: indexPath) as! ContactEditCell
            cell.backgroundColor=iColor(0xffffffff)
            let tup = getModInfoBy(indexPath.row)
            cell.lab.text = tup.0
            cell.tf.text=tup.1
            cell.tf.tag=indexPath.row
            if indexPath.row == 0{
                cell.tf.keyboardType=UIKeyboardType.Default
            }else if indexPath.row == 1{
                cell.tf.keyboardType=UIKeyboardType.PhonePad

            }else if indexPath.row == 2{
                cell.tf.keyboardType=UIKeyboardType.EmailAddress

            }
            return cell
        }
        
        
    }
    
   
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 1{
            showChooser(indexPath)
        }else{
            
        }
        
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    
    
    func getModInfoBy(idx:Int)->(String,String){
        if idx == 0{
            return ("姓名:",mod.name ?? "")
        }else if idx == 1{
            return ("手机号码:",mod.phone ?? "")
        }else if idx == 2{
            return ("邮箱:",mod.email ?? "")
        }
        return ("","")
    }
    
    func setModInfoBy(str:String,idx:Int){
        
        if idx == 0{
            mod.name = str
        }else if idx == 1{
            mod.phone=str
        }else if idx == 2{
            mod.email=str
        }

    }
   
 
    
    func showChooser(idxp:NSIndexPath){
        let bpop = StrAryPV(frame: CGRectMake(0, 0, 0, 260))
        bpop.datas=dropinfo.getAryBy(idxp.row)
        bpop.selidx=dropinfo.idxBy(idxp.row)
        bpop.title=dropinfo.ary[idxp.row]
        bpop.tag=idxp.row
        bpop.rightB=("完成",{
            (obj) in
            let o = obj as! StrAryPV
            self.dropinfo.setBy(o.tag, subidx: o.selIdx())
            self.tv.reloadSections(NSIndexSet(index:1), withRowAnimation: UITableViewRowAnimation.Fade)
            return true
        })
        bpop.leftB=("取消",nil)
        bpop.show()
        
    }
}

class ContactEditCell:UITableViewCell{
    lazy var lab:UILabel={
        let lab = UILabel(frame: nil, txt: "", color: iConst.iGlobalGreen, font: iFont(18), align: NSTextAlignment.Right, line: 1)
        return lab
    }()
    lazy var tf:ClearableTF={
        let tf = ClearableTF(frame: nil, bg: UIColor.whiteColor(), corner: 4, bordercolor: iConst.iGlobalBlue, borderW: 1)
        return tf
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(lab)
        contentView.addSubview(tf)
        lab.snp_makeConstraints { (make) in
            make.width.equalTo(92)
            make.left.top.bottom.equalTo(0)
        }
        tf.snp_makeConstraints { (make) in
            make.top.equalTo(4)
            make.bottom.equalTo(-4)
            make.right.equalTo(-8)
            make.left.equalTo(lab.snp_right).offset(6)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}







