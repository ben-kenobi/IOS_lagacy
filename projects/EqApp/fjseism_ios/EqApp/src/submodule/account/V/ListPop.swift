//
//  ListPop.swift
//  am
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class ListPop: BaseDialog {
    var headerH:CGFloat = 46{
        didSet{
            updateUI()
        }
    }
    var iconH:CGFloat=30
    var defH:CGFloat = 44{
        didSet{
            updateUI()
        }
    }
    
    let celliden = "listPopcelliden"
    let celliden2 = "listPopcelliden2"
    var datas:[String]?{
        didSet{
            updateUI()
        }
    }
    var icons:[String]?{
        didSet{
            updateUI()
        }
    }
    
    var key:String?{
        didSet{
            datas=iStrary[key ?? ""]
        }
    }
    var title:String?
    var onItemSelCB:((str:String,pos:Int)->Void)?
    
    
    
    lazy var header:UIView = {
        let header = ComUI.comTitleView("   "+self.title!)
        return header
    }()
    
    
    lazy var tv:AutoHeightTV = {
        let tv = AutoHeightTV(frame: CGRectMake(0, 0, 0, 0), style: UITableViewStyle.Plain)
        tv.delegate=self
        tv.dataSource=self
        tv.registerClass(ListPopCell.self, forCellReuseIdentifier: self.celliden)
        tv.registerClass(ListPopCell2.self, forCellReuseIdentifier: self.celliden2)

        tv.separatorStyle = .None
        tv.showsVerticalScrollIndicator=true
        tv.bounces=false
        
        return tv    }()
    
    
    required init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(tv)
        tv.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension ListPop{
    
    func updateUI(){
        tv.reloadData()
    }
    
    class func listPopWith(datas:[String]?=nil,title:String?=nil,key:String?=nil,w:CGFloat?=nil,cb:(str:String,pos:Int)->())->Self{
        let pop = dialogWith()
        pop.title = title
        if let datas = datas{
            pop.datas=datas
        }
        if let key = key {
            pop.key = key
        }
        if let w = w{
            pop.tv.wid = w
        }else{
            pop.tv.wid=170
        }
        pop.onItemSelCB = cb
        return pop
    }
    
   
    
}

extension ListPop:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return datas?.count ?? 0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        if let icons=icons{
            let cell = tableView.dequeueReusableCellWithIdentifier(self.celliden2,forIndexPath: indexPath) as! ListPopCell2
            cell.iconH=self.iconH
            cell.scrolLab.text=datas![indexPath.row]
            cell.iv.image=iimg(icons[indexPath.row])
            return cell

        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier(self.celliden,forIndexPath: indexPath) as! ListPopCell
        //        cell.textLabel?.text=datas![indexPath.row]
            cell.scrolLab.text=datas![indexPath.row]
            return cell
        }
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        onItemSelCB?(str: datas![indexPath.row],pos: indexPath.row)
        dismiss()
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let _ = title{
            return header
        }
        return nil
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let _ = title{
            return headerH
        }
        return 0
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return defH
    }
    
}

class ListPopCell:UITableViewCell{
    lazy var scrolLab:ScrolLab = {
        let scl = ScrolLab()
        self.contentView.addSubview(scl)
        scl.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.bottom.equalTo(0)
        })
        return scl
    
    }()
    
}

class ListPopCell2:UITableViewCell{
    var iconH:CGFloat=30

    lazy var scrolLab:ScrolLab = {
        let scl = ScrolLab()
        self.contentView.addSubview(scl)
        scl.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(self.iv.snp_right).offset(15)
            make.right.equalTo(-10)
            make.top.bottom.equalTo(0)
        })
        return scl
        
    }()
    
    lazy var iv:UIImageView={
        let iv = UIImageView()
        self.contentView.addSubview(iv)
        iv.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(12)
            make.centerY.equalTo(0)
            make.width.height.equalTo(self.iconH)
        })
        return iv
    }()
    
}
