
//
//  MainVC.swift
//  day50-pageController-ThirdParty
//
//  Created by apple on 15/12/19.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    let celliden="celliden"
    lazy var tv:UITableView=UITableView(frame: self.view.bounds, style: UITableViewStyle.Plain)
    
    lazy var datas:[String]=["WMMenuViewStyleDefault","WMMenuViewStyleLine","WMMenuViewStyleFlood","WMMenuViewStyleFloodHollow"]
    
    var defpc:WMPageController{
        get{
            var cons=[AnyClass]()
            var titles=[String]()
            var itemws=[Int]()
            var values=[AnyObject]()
            var keys=[String]()
            for i in 0...6{
                switch i%3{
                case 0:
                    cons.append(NormalVC.self)
                    titles.append("Normal")
                    itemws.append(85)
                    values.append(["name":"name01","age":39])
                    keys.append("model")
                case 1:
                    cons.append(TVVC.self)
                    titles.append("table")
                    itemws.append(80)
                    keys.append("age")
                    values.append(39)
                case 2:
                    cons.append(CVVC.self)
                    titles.append("collection")
                    itemws.append(92)
                    keys.append("name")
                    values.append("name02")
                default:
                    break
                }
            }
            
            
            let pc=WMPageController(viewControllerClasses: cons, andTheirTitles: titles)
//            pc.menuItemWidth=90
            pc.itemsWidths=itemws
            pc.values=values
            pc.keys=keys
            
            pc.pageAnimatable=true
            pc.postNotification=true
            pc.bounces=true
         
            return pc
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="mainVC"
        view.backgroundColor=irandColor()

        view.addSubview(tv)
        tv.dataSource=self
        tv.delegate=self
        tv.backgroundColor=iGlobalBG
        
        tv.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(0)
        }
        tv.registerClass(UITableViewCell.self, forCellReuseIdentifier:celliden )
        tv.tableFooterView=UIView()
        
       
    }

    

}

extension MainVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.datas.count ?? 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier(celliden, forIndexPath: indexPath)
        cell.textLabel!.text=datas[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       let pc = self.defpc
        if datas[indexPath.row] == "WMMenuViewStyleDefault"{
            pc.title = "Default"
            pc.menuViewStyle=WMMenuViewStyleDefault
        }else if datas[indexPath.row]=="WMMenuViewStyleLine" {

            pc.title = "Line"
            pc.menuViewStyle = WMMenuViewStyleLine
            pc.titleSizeSelected = 15
        } else if datas[indexPath.row]=="WMMenuViewStyleFlood" {
            pc.title = "Foold"
            pc.menuViewStyle = WMMenuViewStyleFoold
            pc.titleColorSelected=UIColor.whiteColor()
            pc.titleColorNormal=iColor(168, g: 20, b: 4)
            pc.progressColor=iColor(168, g: 20, b: 4)
            pc.titleSizeSelected = 15
//            pc.viewFrame=CGRectMake(0, 100, 300, 300)
            
        } else if datas[indexPath.row]=="WMMenuViewStyleFloodHollow" {
            pc.title = "Hollow"
            pc.menuViewStyle = WMMenuViewStyleFooldHollow
            pc.titleSizeSelected = 15
        }
        self.navigationController?.showViewController(pc, sender: nil)
    }
    
    
}



