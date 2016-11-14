
//
//  WineTV.swift
//  day43-shoppingcart
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit


class WineTV: UITableView{
    
    let iden="celliden"
    
    var datas:[Wine]?{
        didSet{
            reloadData()
        }
    }
    var clo:((dict:Wine)->())?
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        delegate=self
        dataSource=self
        rowHeight=90
        backgroundColor=iColor(238,g:238,b:238)
        separatorStyle=UITableViewCellSeparatorStyle.None
        registerClass(WineCell.self, forCellReuseIdentifier:  iden)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}


extension WineTV: UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let dat=datas {
            return dat.count
        }
        return 0
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell=tableView.dequeueReusableCellWithIdentifier(iden) as! WineCell
        
        cell.dict=datas![indexPath.row]
        cell.quantityChange=clo
        
        return cell
    }
}
