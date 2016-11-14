//
//  EQHisVC.swift
//  EqApp
//
//  Created by apple on 16/9/13.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class EQHisVC: UITableViewController {
    
    var cb:(()->())?

    let celliden = "celliden"
    override func viewDidLoad() {
        super.viewDidLoad()
        title="历史地震列表"
        view.backgroundColor=iColor(0xffffffff)
        tableView.rowHeight=70
        loadDatas()
        
    }
    var datas:[EQInfo]?
    func loadDatas(){
        let path:String = iConst.eqHisUrl + ""
        datas=[]
        NetUtil.commonRequestJson(true, path: path, para: nil, succode: ["200"],cb: { (data, idx) in
            if idx != 0 {return}
            let list = (data as! [String:AnyObject])["data"] as! [[String:AnyObject]]
            
            for dict in list{
                let eq = EQInfo(dict: dict)
                eq.hasLayer=true
                self.datas!.append(eq)
            }
            self.tableView.reloadData()
        })

    }
    
}
extension EQHisVC{
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datas?.count ?? 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(celliden)
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: celliden)
        }
        
        let data = datas![indexPath.row]
        
        cell!.textLabel?.text = "\(data.occurRegionName ?? "")   \(data.magnitude ?? "")    \(data.obsTime)\n"
        cell!.detailTextLabel?.text = "\(data.occurTime ?? "")"
        
        return cell!
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let data = datas![indexPath.row]
        EQInfo.setIns(data)
        (navigationController as! MainNavVC).back()
        cb?()
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
