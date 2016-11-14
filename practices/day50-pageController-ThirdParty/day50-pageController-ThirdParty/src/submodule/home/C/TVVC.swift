
//
//  TVVC.swift
//  day50-pageController-ThirdParty
//
//  Created by apple on 15/12/19.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class TVVC: UITableViewController {
    let celliden="celliden"

    var age:Int=0{
        didSet{

        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor=UIColor.whiteColor()
        tableView.rowHeight=80
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: celliden)
        let loopv=TVLoopV2(frame: CGRectMake(0, 0, self.view.w, self.view.w*0.6))
        tableView.tableHeaderView = loopv
        loopv.autoPlay=true
        loopv.interval=2
        loopv.imgs=[iimg("zoro.jpg"),iimg("three.jpg"),iimg("onepiece.jpg"),iimg("zoro.jpg"),iimg("three.jpg"),iimg("onepiece.jpg")]
        loopv.onSelAt={
            [weak self](lv:TVLoopV2,idx:Int)->() in
            print("select at \(idx)")
        }

    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
     
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return 11
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(celliden, forIndexPath: indexPath)
        cell.backgroundColor=irandColor()
        cell.textLabel?.text="my name is XXX"
        cell.detailTextLabel?.text="age is \(age)"
        cell.detailTextLabel?.textColor=UIColor.grayColor()
        cell.imageView?.image=iimg("github.png")

        return cell
    }



}






