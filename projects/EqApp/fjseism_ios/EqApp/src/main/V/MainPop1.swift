//
//  ListPop.swift
//  am
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class MainPop1: DropdownPop {
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
    var selIdx:Int = -1
    
    
    
    var onItemSelCB:((str:String,pos:Int)->Void)?
    
    
    
    lazy var tv:CurveTv = {
        let tv = CurveTv(frame: CGRectMake(0, 0, 0, 0), style: UITableViewStyle.Plain)
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
        mainView.addSubview(tv)
        
        tv.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension MainPop1{
    
    func updateUI(){
        tv.reloadData()
    }
    
    
    
    class func mainPop1With(datas:[String]?=nil,w:CGFloat?=nil,cb:(str:String,pos:Int)->())->Self{
        let pop = popWith()
        if let datas = datas{
            pop.datas=datas
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

extension MainPop1:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return datas?.count ?? 0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let selected = (indexPath.row == selIdx)
        if let icons=icons{
            let cell = tableView.dequeueReusableCellWithIdentifier(self.celliden2,forIndexPath: indexPath) as! ListPopCell2
            cell.iconH=self.iconH
            cell.scrolLab.text=datas![indexPath.row]
            cell.iv.image=iimg(icons[indexPath.row])
            
            cell.scrolLab.selected=selected
            return cell
            
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier(self.celliden,forIndexPath: indexPath) as! ListPopCell
            //cell.textLabel?.text=datas![indexPath.row]
            cell.scrolLab.text=datas![indexPath.row]
            cell.scrolLab.selected=selected
            return cell
        }
        
        
        
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        onItemSelCB?(str: datas![indexPath.row],pos: indexPath.row)
        if indexPath.row == selIdx{
            selIdx = -1
        }else{
            selIdx=indexPath.row
        }
        tableView.reloadData()
        dismiss()
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return defH
    }
    
}


class CurveTv:AutoHeightTV{
    override func layoutSubviews() {
        super.layoutSubviews()
        //        self.addCurve((true, 11), tr: (false, 0), br: (true, 11), bl: (true, 11), bounds: self.bounds)
        
    }
}
