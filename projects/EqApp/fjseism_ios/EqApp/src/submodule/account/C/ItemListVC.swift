
//
//  ItemListVC.swift
//  am
//
//  Created by apple on 16/5/19.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class ItemListVC: FileChooserVC {
   
    private var mulSelMod:Bool = false
    var datas:[[String:AnyObject]]?
    
    
    
    var rightBtns:[UIButton]=[UIButton]()
    lazy var rightBBIs:[UIBarButtonItem]={
        var rightBBIs = [UIBarButtonItem]()
        
        var item = ComUI.moreItem(self, sel: #selector(self.onItemClick(_:)))
        rightBBIs.append(item)
        
        item = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Trash, target: self, action: #selector(self.onItemClick(_:)))
        item.tag=NavMenu.Trash.rawValue
        rightBBIs.append(item)
        
        item = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(self.onItemClick(_:)))
        item.tag=NavMenu.Add.rawValue
        rightBBIs.append(item)
        
        item = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: #selector(self.onItemClick(_:)))
        item.tag = NavMenu.Search.rawValue
        rightBBIs.append(item)
        
        
        
        return rightBBIs
    }()
    
    lazy var contentTV:UITableView={
        let contentTV = UITableView(frame: self.view.bounds, style: UITableViewStyle.Plain)
        contentTV.delegate=self
        contentTV.dataSource=self
        contentTV.backgroundColor=UIColor(patternImage: iimg("common_bg")!)
        contentTV.separatorStyle = .None
        contentTV.rowHeight = UITableViewAutomaticDimension
        contentTV.estimatedRowHeight = 80
        contentTV.showsVerticalScrollIndicator=true
        contentTV.bounces=false
        return contentTV
        
    }()
    
    
    lazy var delBtn:UIButton={
        let delBtn = UIButton( img: iimg("delete"), bgcolor: iColor(0x55000000), corner: 10, bordercolor: iColor(0xff888888), borderW: 1, tar: self, action: #selector(self.multiDel), tag:0)
        return delBtn
    }()
}

extension ItemListVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(contentTV)
        contentTV.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        contentTV.contentInset=UIEdgeInsetsMake(5, 0, 15, 0)
        navigationItem.rightBarButtonItems=rightBBIs
        let views = navigationController?.navigationBar.subviews
        
        for (_,v) in views!.enumerate(){
            if v.isKindOfClass((NSClassFromString("UINavigationButton")!)){
                rightBtns.append(v as! UIButton)
            }
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if mulSelMod {
            toggleSelMod()
        }
        self.updateData()
    }
    
    func onItemClick(sender:UIBarButtonItem){
        let tag = sender.tag
        
        if(tag==NavMenu.More.rawValue){
            var datas=[iStrings["exportEntries"]!,iStrings["importEntries"]!]
            if CommonUtils.isLogin(){
                datas += [iStrings["modifyAccessKey"]!]
            }
            datas.append(CommonService.isAccessKeyEnable(platform) ?
                iStrings["disableAccessKey"]! : iStrings["enableAccessKey"]!)
            
            ListPop.listPopWith(datas,cb:{
                (str,pos)->()  in
                if str == iStrings["exportEntries"]! {
                    
                }else if str == iStrings["importEntries"]! {
                    
                }else if str == iStrings["enableAccessKey"]! || str ==  iStrings["disableAccessKey"]!{
                    if CommonService.toggleAccessibility(self.platform){
                        iPop.toast("操作成功")
                    }else{
                        iPop.toast("操作失败")
                    }
                }else if str == iStrings["modifyAccessKey"]! {
                    self.showModifyAccessDialog()
                }
            }).show(self,anchor:rightBtns[0])
        }else if tag == NavMenu.Trash.rawValue{
            toggleSelMod()
        }else if tag == NavMenu.Search.rawValue{
            showSearchDailog()
        }else if tag == NavMenu.Add.rawValue{
            toDetailVC()
        }
    }
    
    func updateData(){
        
    }
    
    
    
    func toDetailVC(info:[String:AnyObject]?=nil){
        let vc = ItemDetailVC(datas: StaticMod.ACC_MUTABLE_DATAS,info: info)
        
        navigationController?.showViewController(vc, sender: nil)
    }
    func multiDel(){
        let count = contentTV.indexPathsForSelectedRows?.count ?? 0
        if count == 0 {
            iPop.toast("无被选中数据")
        }else{
            let av=CommonAlertView.viewWith("删除提醒", mes: "确定删除\(contentTV.indexPathsForSelectedRows?.count ?? 0)条数据？", btns: ["确定","取消"],cb: {
                (pos,dialog)->Bool in
                if pos == 0{
                    var set:Set = Set<String>()
                    var idxes:Set = Set<Int>()
                    for idxp in self.contentTV.indexPathsForSelectedRows!{
                        set.insert("\(self.datas![idxp.row][iConst.ID]!)")
                        idxes.insert(idxp.row)
                    }
                    iPop.toast("删除\(AccountService.ins.delete(set))条数据")
                    self.datas!.removeAtIdxes(idxes)
                    self.contentTV.deleteRowsAtIndexPaths(self.contentTV.indexPathsForSelectedRows!, withRowAnimation: UITableViewRowAnimation.Fade)
                    self.toggleSelMod()

                }
                return true
            })
            av.show()
        }
        
    }
    func showModifyAccessDialog(){
        let av=CommonEditDialog.viewWith("修改密码", phs:["输入新密码"], btns: ["确定","取消"],cb: {
            (pos,dialog)->Bool in
            if pos == 0{
                let dia = dialog as! CommonEditDialog
                let txts=dia.getTexts()
                if txts[0] == "" {
                    iPop.toast("新密码不能为空")
                    return false
                }else{
                   let b = CommonService.modifyAccessKey(CommonUtils.getAccessKey(), newAccessKey: txts[0])
                    if b{
                        iPop.toast("修改成功")
                        CommonUtils.setAccessKey(txts[0])
                        return true
                    }else{
                        iPop.toast("修改失败")
                        return false
                    }
                }
                
            }
            return true
        })
        av.show()
    }
    
    func showSearchDailog(){}

    
    func toggleSelMod(){
        mulSelMod = !mulSelMod
        contentTV.allowsMultipleSelection=mulSelMod
        
        let corner = 10,height=80
        if mulSelMod{
            view.addSubview(self.delBtn)
            delBtn.snp_makeConstraints { (make) in
                make.bottom.equalTo(corner)
                make.width.equalTo(view).multipliedBy(0.5)
                make.height.equalTo(height)
                make.centerX.equalTo(0)
            }
            delBtn.transform=CGAffineTransformMakeTranslation(0,CGFloat( height - corner))
            UIView.animateWithDuration(0.3, animations: {
                self.delBtn.transform=CGAffineTransformIdentity
            })
            contentTV.selectAll()
        }else{
            UIView.animateWithDuration(0.3, animations: {
                self.delBtn.transform=CGAffineTransformMakeTranslation(0,CGFloat( height - corner))
                }, completion: { (b) in
                    if !self.mulSelMod{
                        self.delBtn.removeFromSuperview()
                    }
            })
        }
    }
}



extension ItemListVC:UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return datas?.count ?? 0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        return  CommonListItemCell.cellWith(tableView, mod: datas![indexPath.row], idx: indexPath)
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if !mulSelMod{
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            toDetailVC(datas![indexPath.row])
        }
        
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if AccountService.ins.delete("\(datas![indexPath.row][iConst.ID]!)"){
            datas!.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "DEL"
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return !mulSelMod
    }
    
    
}