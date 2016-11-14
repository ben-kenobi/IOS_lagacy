
//
//  BaseSettingVC.swift
//  EqApp
//
//  Created by apple on 16/8/30.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit



class BaseSettingVC: UITableViewController {
    var pname:String = ""
    var rowh:CGFloat = 52
    lazy var datas:[[String:AnyObject]] = {
        if empty(self.pname){
            return []
        }
        if var  datas:[[String:AnyObject]] = iRes4Ary(self.pname) as? [[String:AnyObject]]{
            return datas
        }
        return []
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor=iColor(0xffefeff4)
//        tableView.separatorStyle = .None
        tableView.rowHeight = rowh
//        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator=false
        tableView.bounces=false
        
    }
    
    init(){
        super.init(style: UITableViewStyle.Grouped)
   
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    
    
}


extension BaseSettingVC{
    
    
      func dictBy(path:NSIndexPath)->[String:AnyObject]{
        if let ary = datas[path.section]["mems"] as? [[String:AnyObject]]{
            return ary[path.row]
        }
        return [String:AnyObject]()
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return datas.count
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas[section]["mems"]?.count ?? 0
        
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return datas[section]["header"] as? String
    }
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return datas[section]["footer"]  as? String
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let dict = dictBy(indexPath)
        return SettingCell.cellWith(tableView, dicti: dict)
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let dict = dictBy(indexPath)
        if let vc = iVCFromStr(dict["vc"] as? String){
            let sel = NSSelectorFromString("setPname:")
            if vc.respondsToSelector(sel) {
                self.performSelector(sel, withObject: dict["pname"])
            }
            vc.title=dict["title"] as? String
            self.navigationController?.showViewController(vc, sender: nil)
        }else if let selname = dict["sel"] as? String{
            let sel = NSSelectorFromString(selname)
            if self.respondsToSelector(sel){
                self.performSelector(sel, withObject: indexPath)
            }
        }
        
        
    }
    
    
    
    
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//            (datas[indexPath.section]["mems"] as! [[String:AnyObject]]).removeAtIndex(indexPath.row)
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        
    }
    
    
     override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "DEL"
    }
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    
}
