

//
//  YFVC02.swift
//  day42-swiftbeginning
//
//  Created by apple on 15/12/4.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class YFVC02: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let iden="celliden"
    
    lazy var datas:[Modle] = {
        ()->[Modle] in
        var ary:[Modle]=[Modle]()
        for i in 0...10 {
            ary.append( Modle(dict: ["name":"name\(i)","age":i,"time":NSDate()]))
        }
        return ary
    }()
    
    var tv:UITableView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor=UIColor.randColor()
        tv=UITableView(frame: CGRect(x: 0, y: 20, width: view.w(), height: view.h()-20), style: UITableViewStyle.Grouped)
        view .addSubview(tv!)
        tv!.delegate=self
        tv!.dataSource=self
        tv!.rowHeight=70
        tv?.registerClass(YFCell02.self, forCellReuseIdentifier: iden)
    }
}
    
extension YFVC02{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return datas.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell=tableView.dequeueReusableCellWithIdentifier(iden, forIndexPath: indexPath) as! YFCell02
        cell.m=self.datas[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let vc=DetailVC02()
        vc.m = datas[indexPath.row]
        weak var ws=self
        vc.cb={
            ()->() in
            ws?.tv?.reloadData()
        }
        presentViewController(vc, animated: true, completion: nil)
    }
}
