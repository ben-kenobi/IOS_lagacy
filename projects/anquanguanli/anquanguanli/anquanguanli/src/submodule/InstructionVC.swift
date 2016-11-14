//
//  InstructionVC.swift
//  anquanguanli
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class InstructionVC: BaseVC {
    let celliden="instructiontvcelliden"

    override func viewDidLoad() {
        super.viewDidLoad()
        title="历史指令"
        self.view.addSubview(tv)
        loadDatas()
        
    }
    
    
    
    func loadDatas(){
        
        NetUtil.commonRequestJson(true, path: String(format:iConst.InstructionList_URL,UserInfo.me.token!), para: nil, succode: ["1"]) { (data, flag) in
          
            self.data = data["instructionsList"] as? [[String:AnyObject]]
            self.tv.reloadData()
            if nil == self.data || self.data!.count == 0{
                iPop.toast("暂无数据！")
            }
            
        }
       
    }
    
    lazy var tv:UITableView={
        let v = self.view
        let tv=UITableView(frame:CGRectMake(0, 0, v.w, v.h), style: UITableViewStyle.Plain)
        tv.delegate=self
        tv.dataSource=self
        tv.separatorStyle=UITableViewCellSeparatorStyle.None
        
        tv.registerClass(InstructionLvCell.self, forCellReuseIdentifier:self.celliden)
        tv.rowHeight=UITableViewAutomaticDimension
        tv.estimatedRowHeight=60

        tv.showsVerticalScrollIndicator=true
        tv.bounces=true
        tv.backgroundColor=UIColor.clearColor()
        return tv
    
    }()
    
    var data:[[String:AnyObject]]?

}

extension InstructionVC:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return data?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell:InstructionLvCell=tableView.dequeueReusableCellWithIdentifier(celliden, forIndexPath: indexPath) as! InstructionLvCell
        
        
        if let mod = getByIdx(indexPath){
            cell.mod=mod as? [String:String]
        }
        
        return cell
    }
    
    func getByIdx(indexPath:NSIndexPath)->[String:AnyObject]?{
        return data![indexPath.row]
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        if let mod = getByIdx(indexPath){
            let str = "时间：\(mod["sendDate"]!)\n内容：\(mod["content"]!)"
            
            let vc = UIAlertController(title: "指令", message: str, preferredStyle:.Alert)
            vc.addAction(UIAlertAction(title: "关闭", style: .Cancel, handler: nil))
            presentViewController(vc, animated: true, completion: nil)
        }
        
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
}
