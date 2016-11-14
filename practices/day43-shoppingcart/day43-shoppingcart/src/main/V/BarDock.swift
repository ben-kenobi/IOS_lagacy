

//
//  BarDock.swift
//  day43-shoppingcart
//
//  Created by apple on 15/12/14.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class BarDock: UITableView {
    let iden="celliden"
    var dictdatas:[AnyObject]?{
        didSet{
            var datas=[WineCate]()
            for dict in dictdatas!{
                if let dict = dict as? [String : AnyObject]{
                    datas.append(WineCate(dict: dict))
                }
            }
            self.datas=datas
        }
    }
    
    var datas:[WineCate]?{
        didSet{
            reloadData()
            tableView(self, willSelectRowAtIndexPath: NSIndexPath.init(forItem: 0, inSection: 0))
            selectRowAtIndexPath(NSIndexPath.init(forItem: 0, inSection: 0), animated: true, scrollPosition: .None)
        }
    }
    
    var onChange:(([Wine]?,lastIdx:NSIndexPath,curIdx:NSIndexPath)->())?
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        rowHeight=44
        backgroundColor=iColor(238,g: 238,b: 238)
        separatorStyle=UITableViewCellSeparatorStyle.None
        registerClass(DockCell.self, forCellReuseIdentifier: iden)
        delegate=self
        dataSource=self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension BarDock :UITableViewDataSource,UITableViewDelegate{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let dat=datas {
            return dat.count
        }
        return 0
        
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell=tableView.dequeueReusableCellWithIdentifier(iden) as! DockCell
        cell.title=datas![indexPath.row].valueForKeyPath("dockName") as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        var selidx=indexPathForSelectedRow
        if selidx==nil {
            selidx=NSIndexPath(forRow: 0, inSection: 0)
        }
        onChange?(datas![indexPath.row].right,lastIdx:selidx!,curIdx:indexPath )
        
        return indexPath
    }
    

    
    
    
    
    
    
}