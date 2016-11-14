//
//  ViewController.swift
//  01-SQLite体验
//
//  Created by 刘凡 on 15/10/29.
//  Copyright © 2015年 joyios. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    lazy var persons = Person.persons(nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        insertManyPerson2()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 60
        
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        searchBar.delegate = self
        tableView.tableHeaderView = searchBar
        
        tableView.keyboardDismissMode = .OnDrag
    }
    
    /// 使用事务插入数据 - 测试结果3.6秒
    func insertManyPerson2() {
        
        let start = CACurrentMediaTime()
        let lastNames = ["zhang", "wang", "li", "zhao"]
        let firstNames = ["老大", "小二", "小三"]
        
        SQLiteManager.sharedManager.execSQL("BEGIN TRANSACTION;")
        for _ in 0..<20 {
            let name = lastNames[random() % lastNames.count] + firstNames[random() % firstNames.count]
            let age = 20 + random() % 10
            let height = 1.5 + Double(random() % 5) / 10
            
            if !Person(dict: ["name": name, "age": age, "height": height]).insertPerson() {
                SQLiteManager.sharedManager.execSQL("ROLLBACK TRANSACTION;")
                break
            }
        }
        SQLiteManager.sharedManager.execSQL("COMMIT TRANSACTION;")
        print("结束 \(CACurrentMediaTime() - start)")
    }
}

extension ViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = persons![indexPath.row].description
        
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {

        persons = Person.persons(searchText)
        tableView.reloadData()
    }
}