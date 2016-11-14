//
//  SQLiteManager.swift
//  01-FMDB演练
//
//  Created by itheima on 15/12/21.
//  Copyright © 2015年 itheima. All rights reserved.
//

import Foundation

/// 数据库文件名
private let dbName = "status.db"

class SQLiteManager {
    
    /// 单例
    static let sharedManager = SQLiteManager()
    
    /// 全局数据库访问队列 - 常量在定义的时候，如果只是指定了类型，有一次设置初始值的机会
    let queue: FMDatabaseQueue
    
    /// 如果希望外部只通过 shared 成员访问单例，可以给 init 增加一个 private 修饰符
    private init() {
        
        var path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        path = (path as NSString).stringByAppendingPathComponent(dbName)
        
        print(path)
        
        // 打开数据库队列 
        // 参数：path 是数据库的全路径
        // - 如果数据库不存在，建立数据库，然后实例化数据库队列对象
        // - 如果数据库存在，打开数据库，然后实例化数据库队列对象
        queue = FMDatabaseQueue(path: path)
        
        // 创表
        createTable()
    }
    
    /// 执行 sql 返回查询结果的 字典数组
    func execRecordSet(sql: String) -> [[String: AnyObject]]? {

        // `定义`结果集合数组
        var result: [[String: AnyObject]]?
        
        queue.inDatabase { (db) -> Void in
            
            guard let rs = db.executeQuery(sql) else {
                print("查询错误")
                return
            }
            
            // 实例化结果数组
            result = [[String: AnyObject]]()
            
            while rs.next() {
                
                // 0. 定义一个字典
                var row = [String: AnyObject]()
                
                // 1. 有几列
                let colCount = rs.columnCount()
                
                for col in 0..<colCount {
                    
                    // 2. 遍历每一列的列名
                    let colName = rs.columnNameForIndex(col)
                    
                    // 3. 每一列的值
                    let value = rs.objectForColumnIndex(col)
                    
                    // 依次给字典设置值
                    row[colName] = value
                }
                
                // 添加到数组
                result!.append(row)
            }
        }
        
        return result
    }
    
    /// 创建数据表
    private func createTable() {
        
        // 1. 准备 sql
        let path = NSBundle.mainBundle().pathForResource("db.sql", ofType: nil)
        let sql = try! String(contentsOfFile: path!)
        
        // 2. 执行 sql - 内部使用了串行队列同步任务，能够保证同一时间，只有一个任务操作数据库！
        // 无论我们程序员在任何一个线程，使用 queue 操作数据库，都能够保证数据的完整性！
        // 注意：不要嵌套使用！
        queue.inDatabase { (db) -> Void in
            
            // NSThread.sleepForTimeInterval(1.0)
            
            if db.executeStatements(sql) {
                print("创建数据表成功")
            } else {
                print("创建数据表失败")
            }
        }
        
        print("come here");
    }
}