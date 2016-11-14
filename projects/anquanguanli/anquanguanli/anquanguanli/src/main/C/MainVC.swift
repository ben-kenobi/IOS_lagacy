//
//  MainVC.swift
//  anquanguanli
//
//  Created by apple on 16/2/16.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class MainVC: BaseVC,UITableViewDelegate,UITableViewDataSource {
    let celliden="menutvcelliden"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tv)
       menuInfo = iRes4Ary("menuConf.plist")

    }
    
    

    
    
    
    var menuInfo:[AnyObject]?
    
    
  
    
    lazy var tv:UITableView = {
        let v = self.view
        let tv=UITableView(frame:CGRectMake(0, 0, v.w, v.h), style: UITableViewStyle.Plain)
        tv.delegate=self
        tv.dataSource=self
        tv.separatorStyle=UITableViewCellSeparatorStyle.None
        tv.registerClass(MenuCell.self, forCellReuseIdentifier:self.celliden)
        tv.rowHeight=80
        tv.showsVerticalScrollIndicator=false
        tv.bounces=false
        tv.backgroundColor=UIColor.clearColor()
        return tv
    }()

}





extension MainVC{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return menuInfo?.count ?? 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return menuInfo?[section]["items"]?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell:MenuCell=tableView.dequeueReusableCellWithIdentifier(celliden,forIndexPath: indexPath) as! MenuCell

        if let mod = getByIdx(indexPath){
            cell.mod=mod as? [String : String]
        }
        
        return cell
    }
    
    func getByIdx(indexPath:NSIndexPath)->[String:AnyObject]?{
        return menuInfo?[indexPath.section]["items"]?[indexPath.row] as? [String:AnyObject]
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if let vcstr = getByIdx(indexPath)?["vc"] as? String{
            let vc = iVCFromStr(vcstr)!
            vc.title = getByIdx(indexPath)!["title"] as? String
            navigationController?.showViewController(vc, sender: nil)
        }else{
            
        }
        
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
 
    
    
}
