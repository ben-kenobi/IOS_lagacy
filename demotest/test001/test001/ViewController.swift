//
//  ViewController.swift
//  test001
//
//  Created by apple on 16/5/26.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       let tv = UITableView(frame: self.view.bounds, style: UITableViewStyle.Plain)
        view.addSubview(tv)
        tv.delegate = self
        tv.registerClass(UITableViewCell.self, forCellReuseIdentifier: "celliden")
        tv.dataSource=self
        
    }
    lazy var datas:[String]=["qweqw","aaa","dsdasdas","qweqw","aaa","dsdasdas","qweqw","aaa","dsdasdas","qweqw","aaa","dsdasdas"]

    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        print("\(datas.count)")
        return datas.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
       let cell = tableView.dequeueReusableCellWithIdentifier("celliden",forIndexPath: indexPath)
        cell.textLabel!.text=datas[indexPath.row]
        return cell
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
        
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        datas.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
       
    }
    
    
  
}

