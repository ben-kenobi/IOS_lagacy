//
//  EmerPrescripVC.swift
//  EqApp
//
//  Created by apple on 16/11/9.
//  Copyright © 2016年 apple. All rights reserved.
//

import Foundation


class EmerPrescripVC: UITableViewController {
    
    let celliden = "celliden"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor=iColor(0xffffffff)
        tableView.rowHeight=70
        tableView.tableFooterView=UIView()
        tableView.bounces=false
        loadDatas()
        
    }
    var datas:[String]=["福建省地震局机关及事业单位地震应急预案","福建省地震系统地震应急预案"]
    func loadDatas(){
        self.tableView.reloadData()
    }
    
}
extension EmerPrescripVC{
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datas.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(celliden)
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: celliden)
        }
        cell?.textLabel?.font=iFont(17)
        cell!.textLabel?.text = datas[indexPath.row]
        
        return cell!
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
            let vc = LocslWebVC()
        if indexPath.row==0{
            vc.path = iRes("yjya.html")
        }else{
            vc.path = iRes("qebrochure.html")
        }
        vc.title=self.title
        self.presentViewController(MainNavVC(rootViewController: vc), animated: true, completion: nil)
    }
    
    

}
