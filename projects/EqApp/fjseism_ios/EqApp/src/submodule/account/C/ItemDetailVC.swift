//
//  ItemDetailVC.swift
//  am
//
//  Created by apple on 16/5/19.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class ItemDetailVC: BaseVC {
    var editable:Bool = true
    var info:[String:AnyObject]?

    var datas:[NSMutableDictionary]?
    
    lazy var contentTV:UITableView={
        let contentTV = UITableView(frame: self.view.bounds, style: UITableViewStyle.Plain)
        contentTV.delegate=self
        contentTV.dataSource=self
        
        let iv = UIImageView()
        iv.image=iimg("background.9")
        contentTV.backgroundView = iv
        contentTV.separatorStyle = .None
        contentTV.rowHeight = 50
        contentTV.contentInset=UIEdgeInsetsMake(15, 15, 15, -15)
        contentTV.showsVerticalScrollIndicator=true
        contentTV.bounces=false
        
        return contentTV
        
    }()
    
    lazy var commit:UIButton = ComUI.comBtn1(self, sel: #selector(self.onClick(_:)), title: (self.info==nil ? "保存信息" : "更新信息"))
    
    
    convenience init(datas:[NSMutableDictionary],info:[String:AnyObject]?){
        self.init()
        self.datas=datas
        self.info=info
        if let inf = self.info {
            editable = false
            for dict in self.datas!{
                dict.setValue(inf[dict.valueForKey("key") as! String], forKey: "val")
            }
        }
    }
    
    
    

}

extension ItemDetailVC{
    override func viewDidLoad() {
        super.viewDidLoad()
        let item = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action:#selector(self.onItemClick(_:)))
        item.tag=NavMenu.Edit.rawValue
        navigationItem.rightBarButtonItem=item
        view.addSubview(contentTV)
        view.addSubview(commit)
        commit.snp_makeConstraints { (make) in
            make.bottom.equalTo(-12)
            make.centerX.equalTo(0)
            make.height.equalTo(38)
            make.width.equalTo(self.view.snp_width).multipliedBy(0.7)
        }
        contentTV.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.bottom.equalTo(commit.snp_top).offset(-5)
        }
        updateUI()
        
        
    }
    func onItemClick(sender:UIBarButtonItem){
        if(sender.tag==NavMenu.Edit.rawValue){
            toggleEditable()
        }
    }
    
    
    func onClick(sender:UIButton){
        if(sender == commit){
            if isBlank(datas![0]["val"] as? String){
                iPop.toast("\(datas![0]["title"]!) 不能为空!")
                focusAtRow(0)
                return
            }
            
            var dict = [String:String]()
            for md in datas!{
                dict[md["key"] as! String]=md["val"] as? String

            }
            if let info = info{
                dict[iConst.ID]="\(info[iConst.ID]!)"
            }
            if AccountService.ins.addOrUpdate(dict) {
                toggleEditable()
                iPop.toast(" 成功! ")
            }else{
                 iPop.toast(" 失败! ")
            }
                
        }
    }
    
    
    
    func toggleEditable(){
        editable = !editable
        updateUI()
    }
    
    
    
    func updateUI(){
        contentTV.reloadData()
        commit.snp_updateConstraints { (make) in
            make.height.equalTo(self.editable ? 38 : 0)
        }
    }
    
}

extension ItemDetailVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return datas?.count ?? 0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        return ItemDetailTVCell.cellWith(tableView, mod: datas![indexPath.row], b: &editable)
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func focusAtRow(row:Int){
        (contentTV.cellForRowAtIndexPath(NSIndexPath.init(forRow: row, inSection: 0)) as! ItemDetailTVCell).tf.becomeFirstResponder()
    }
    
    
}
