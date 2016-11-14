//
//  SQLiteManager.swift
//  01-SQLite体验
//
//  Created by 刘凡 on 15/12/20.
//  Copyright © 2015年 joyios. All rights reserved.
//

import Foundation

/// SQLite 管理器
class SQLiteManager {
    
    /// 单例
    static let sharedManager = SQLiteManager()

    /// 全局数据库访问句柄
    var db: COpaquePointer = nil
    
    /// 打开数据库
    func openDB(dbName: String) {
        
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let filePath = (path as NSString).stringByAppendingPathComponent(dbName)
        
        print(filePath)
        if sqlite3_open(filePath, &db) != SQLITE_OK {
            print("打开数据库失败")
            
            return
        }
        
        if createTable3() {
            print("创表成功")
        } else {
            print("创表失败")
        }
    }
    
    // MARK: - 数据查询
    /// 执行 SQL 返回查询结果集
    ///
    /// - parameter sql: 任意给定的 SELETE 查询 SQL
    func execRecordSet(sql: String) -> [[String: AnyObject]]? {
        
        // 1. 预编译 SQL
        /**
            参数
            
            1. 已经打开的数据库句柄
            2. 要执行的 SQL
            3. 以字节为单位的 SQL 最大长度，传入 -1 会自动计算
            4. SQL 语句句柄
                - 后续针对当前查询结果的操作全部基于此句柄
                - 需要调用 sqlite3_finalize 释放
            5. 未使用的指针地址，通常传入 nil
        */
        var stmt: COpaquePointer = nil
        if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) != SQLITE_OK {
            print("SQL 错误")
            return nil
        }
        
        // 创建结果数组
        var rows = [[String: AnyObject]]()
        
        // 2. 遍历集合
        while sqlite3_step(stmt) == SQLITE_ROW {
            // 将单条记录字典添加到结果数组中
            rows.append(record(stmt))
        }
        
        // 3. 释放语句句柄 - 很重要，否则会内容泄漏
        sqlite3_finalize(stmt)
        
        // 4. 返回结果数组
        return rows
    }
    
    /// 从 stmt 中获取当前记录的完整内容
    ///
    /// - parameter stmt: stmt 句柄
    private func record(stmt: COpaquePointer) -> [String: AnyObject] {
        
        // 1. 获取查询结果列数
        let colCount = sqlite3_column_count(stmt)
        
        // 单条记录字典
        var row = [String: AnyObject]()
        
        // 2. 遍历所有列，获取每一列的信息
        for col in 0..<colCount {
            // 1> 获取列名
            let cName = sqlite3_column_name(stmt, col)
            let name = String(CString: cName, encoding: NSUTF8StringEncoding) ?? ""
            
            // 2> 获取每列数据类型
            let type = sqlite3_column_type(stmt, col)
            
            // 3> 根据数据类型获取对应结果
            var value: AnyObject?
            switch(type) {
            case SQLITE_FLOAT:
                value = sqlite3_column_double(stmt, col)
            case SQLITE_INTEGER:
                value = Int(sqlite3_column_int64(stmt, col))
            case SQLITE3_TEXT:
                let cText = UnsafePointer<Int8>(sqlite3_column_text(stmt, col))
                value = String(CString: cText, encoding: NSUTF8StringEncoding)
            case SQLITE_NULL:
                value = NSNull()
            default:
                print("不支持的数据类型")
            }
            
    //            print("列名 \(name) 值 \(value)")
            row[name] = value ?? NSNull()
        }
        
        return row
    }
    
    // MARK: - 数据库操作
    /// 执行 更新 / 删除 SQL
    ///
    /// - parameter sql: sql
    ///
    /// - returns: 返回 更新 / 删除 的数据行数
    func execUpdate(sql: String) -> Int {
        if !execSQL(sql) {
            return -1
        }
        // 返回影响的数据行数
        return Int(sqlite3_changes(db))
    }
    
    /// 执行插入 SQL
    ///
    /// - parameter sql: sql
    ///
    /// - returns: 返回自动增长 id
    func execInsert(sql: String) -> Int64 {
        if !execSQL(sql) {
            return -1
        }
        // 返回自动增长 id
        return Int64(sqlite3_last_insert_rowid(db))
    }
    
    func execSQL(sql: String) -> Bool {
        return sqlite3_exec(db, sql, nil, nil, nil) == SQLITE_OK
    }
    
    // MARK: - 私有方法
    /// 加载 base64 编码后的 SQL
    /// 
    /// 提示：
    ///     - BASE64 编码
    ///         $ base64 db.sql -o db64.txt
    ///     - BASE64 解码
    ///         $ base64 db64.txt -D -o db.sql
    /// - returns: 是否成功
    private func createTable3() -> Bool {
        // 1. 准备 SQL
        let path = NSBundle.mainBundle().pathForResource("db64.txt", ofType: nil)!
        let base64 = try! String(contentsOfFile: path)
        let data = NSData(base64EncodedString: base64, options: [.IgnoreUnknownCharacters])!
        
        // base64 解码
        let sql = NSString(data: data, encoding: NSUTF8StringEncoding)! as String
        
        // 2. 执行 SQL
        return execSQL(sql)
    }
    
    /// 加载 SQL 文件创建数据表
    private func createTable2() -> Bool {
        // 1. 准备 SQL
        let path = NSBundle.mainBundle().pathForResource("db.sql", ofType: nil)!
        let sql = try! String(contentsOfFile: path)
        
        // 2. 执行 SQL
        return execSQL(sql)
    }
    
    /// 建立数据表
    private func createTable1() -> Bool {
        // 1. 准备 SQL
        let sql = "CREATE TABLE IF NOT EXISTS 'T_Person' ( \n" +
        "'id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, \n" +
        "'name' TEXT, \n" +
        "'age' INTEGER, \n" +
        "'height' REAL \n" +
        ")"
        
        // 2. 执行 SQL
        return execSQL(sql)
    }
}