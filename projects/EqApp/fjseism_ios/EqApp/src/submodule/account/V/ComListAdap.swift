//
//  ComListAdap.swift
//  EqApp
//
//  Created by apple on 16/9/6.
//  Copyright © 2016年 apple. All rights reserved.
//
import UIKit

class ComListAdap: BaseDialog {
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
 
    var datas:[AnyObject]?{
        didSet{
            updateUI()
        }
    }
    
    
    var title:String?
    var onItemSelCB:((d:ComListAdap,pos:Int)->Void)?
    var getView:((d:ComListAdap,pos:Int)->UITableViewCell)?

    
    
    lazy var header:UIView = {
        let header = ComUI.comTitleView("   "+self.title!)
        return header
    }()
    
    
    lazy var tv:AutoHeightTV = {
        let tv = AutoHeightTV(frame: CGRectMake(0, 0, 0, 0), style: UITableViewStyle.Plain)
        tv.delegate=self
        tv.dataSource=self
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
extension ComListAdap{
    
    func updateUI(){
        tv.reloadData()
    }
    
    class func comListAdapWith(datas:[AnyObject]?=nil,title:String?=nil,w:CGFloat?=nil,tag:Int=0,cb:((d:ComListAdap,pos:Int)->())?,getv:((d:ComListAdap,pos:Int)->UITableViewCell)?)->Self{
        let pop = dialogWith()
        pop.title = title
        pop.tag=tag
        pop.onItemSelCB = cb
        pop.getView = getv
        if let datas = datas{
            pop.datas=datas
        }
    
        if let w = w{
            pop.tv.wid = w
        }else{
            pop.tv.wid=170
        }
     
        return pop
    }
    
    
    
}

extension ComListAdap:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return datas?.count ?? 0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        if let cell = getView?(d:self,pos:indexPath.row){
            return cell
        }
        return UITableViewCell()
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        onItemSelCB?(d:self,pos: indexPath.row)
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




    
