//
//  ViewController.swift
//  01-SQLite体验
//
//  Created by 刘凡 on 15/12/20.
//  Copyright © 2015年 joyios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manyPerson4()
    }
    
    // MARK: - 批量更新
    /// 标准写法
    private func manyPerson4() {
        print("start")
        let start = CACurrentMediaTime()
        
        SQLiteManager.sharedManager.execSQL("BEGIN TRANSACTION;")
        
        for i in 0..<10000 {
            if !Person(dict: ["name": "zhang - \(i)", "age": 18, "height": 1.7]).insertPerson() {
                SQLiteManager.sharedManager.execSQL("ROLLBACK TRANSACTION;")
                break;
            }
        }
        
        SQLiteManager.sharedManager.execSQL("COMMIT TRANSACTION;")
        
        print("over \(CACurrentMediaTime() - start)")
    }
    
    /// 模拟失败
    private func manyPerson3() {
        print("start")
        let start = CACurrentMediaTime()
        
        SQLiteManager.sharedManager.execSQL("BEGIN TRANSACTION;")
        
        for i in 0..<10000 {
            Person(dict: ["name": "zhang - \(i)", "age": 18, "height": 1.7]).insertPerson()
            
            if i == 1000 {
                SQLiteManager.sharedManager.execSQL("ROLLBACK TRANSACTION;")
                // 注意：一定要使用 break 退出循环
                break;
            }
        }
        
        SQLiteManager.sharedManager.execSQL("COMMIT TRANSACTION;")
        
        print("over \(CACurrentMediaTime() - start)")
    }
    
    /// 使用事务插入多条数据 - 测试记录 0.4s
    private func manyPerson2() {
        print("start")
        let start = CACurrentMediaTime()
        
        SQLiteManager.sharedManager.execSQL("BEGIN TRANSACTION;")
        
        for i in 0..<10000 {
            Person(dict: ["name": "zhang - \(i)", "age": 18, "height": 1.7]).insertPerson()
        }
        
        SQLiteManager.sharedManager.execSQL("COMMIT TRANSACTION;")
        
        print("over \(CACurrentMediaTime() - start)")
    }
    
    /// 不使用事务插入多条记录 - 测试记录 5s
    private func manyPerson1() {
        print("start")
        let start = CACurrentMediaTime()
        
        for i in 0..<10000 {
            Person(dict: ["name": "zhang - \(i)", "age": 18, "height": 1.7]).insertPerson()
        }
        print("over \(CACurrentMediaTime() - start)")
    }

    // MARK: - 简单数据操作
    private func demoDelete() {
        let p = Person(dict: ["id": 3000, "name": "老王", "age": 108, "height": 1.7])
        
        if p.deletePerson() {
            print("删除成功 \(p)")
        } else {
            print("删除失败")
        }
    }
    
    private func demoUpdate() {
        let p = Person(dict: ["id": 1, "name": "老王", "age": 108, "height": 1.7])
        
        if p.updatePerson() {
            print("更新成功 \(p)")
        } else {
            print("更新失败")
        }
    }
    
    private func demoInsert() {
        let p = Person(dict: ["name": "zhang", "age": 18, "height": 1.7])
        
        if p.insertPerson() {
            print("插入成功 \(p)")
        } else {
            print("插入失败")
        }
    }
}

