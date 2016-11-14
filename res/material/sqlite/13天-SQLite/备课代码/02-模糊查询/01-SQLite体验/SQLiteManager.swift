//
//  SQLiteManager.swift
//  01-SQLite体验
//
//  Created by 刘凡 on 15/10/29.
//  Copyright © 2015年 joyios. All rights reserved.
//

import Foundation

/// SQLite 管理工具
class SQLiteManager {
    
    /// 单例
    static let sharedManager = SQLiteManager()
    
    /// 全局数据库句柄
    var db: COpaquePointer = nil
    
    /// 打开数据库
    ///
    /// - parameter dbName: 数据库文件名
    func openDB(dbName: String) {
        
        var path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        path = (path as NSString).stringByAppendingPathComponent(dbName)
        print(path)
        
        if sqlite3_open(path, &db) != SQLITE_OK {
            print("打开数据库失败")
            return
        }
        
        if createTable() {
            print("创建数据表成功")
        } else {
            print("创建数据表失败")
        }
    }
    
    // MARK: - 绑定参数
    /// 利用绑定参数插入数据
    ///
    /// - parameter sql:  SQL
    /// - parameter args: 参数列表
    func execInsert(sql: String, args: CVarArgType...) -> Int {

        // 1. 预编译 SQL
        var stmt: COpaquePointer = nil
        if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) != SQLITE_OK {
            print("SQL 错误")
            sqlite3_finalize(stmt)
            
            return -1
        }
        
        // 2. 绑定参数
        var index: Int32 = 1
        for arg in args {
            
            if arg is Double {
                sqlite3_bind_double(stmt, index, arg as! Double)
            } else if arg is Int {
                sqlite3_bind_int64(stmt, index, sqlite3_int64(arg as! Int))
            } else if arg is String {
                let str = (arg as! String).cStringUsingEncoding(NSUTF8StringEncoding)
                sqlite3_bind_text(stmt, index, str!, -1, SQLITE_TRANSIENT)
            }
            
            index++
        }
        
        // 3. 单步执行
        if sqlite3_step(stmt) != SQLITE_DONE {
            print("插入失败")
        }

        // 4. 释放 stmt
        sqlite3_finalize(stmt)

        return Int(sqlite3_last_insert_rowid(db))
    }
    /**
     typedef void (*sqlite3_destructor_type)(void*);
     #define SQLITE_STATIC      ((sqlite3_destructor_type)0)
     #define SQLITE_TRANSIENT   ((sqlite3_destructor_type)-1)
    */
    private let SQLITE_STATIC = unsafeBitCast(0, sqlite3_destructor_type.self)
    private let SQLITE_TRANSIENT = unsafeBitCast(-1, sqlite3_destructor_type.self)
    
    // MARK: - 事务处理
    /// 开启事务
    func beginTransaction() {
        sqlite3_exec(db, "BEGIN TRANSACTION;", nil, nil, nil)
    }

    /// 提交事务
    func commitTransaction() {
        sqlite3_exec(db, "COMMIT TRANSACTION;", nil, nil, nil)
    }

    /// 回滚事务
    func rollbackTransaction() {
        sqlite3_exec(db, "ROLLBACK TRANSACTION;", nil, nil, nil)
    }
    
    // MARK: - 查询数据
    /// 执行 SQL 返回结果集合
    ///
    /// - parameter sql: sql
    func execRecord(sql: String) -> [[String: AnyObject]]? {
        
        // 1. 预编译 SQL
        /**
            参数 
        
            1. 已经打开的数据库句柄
            2. 要执行的 SQL
            3. 以字节为单位的 SQL 最大长度，传入 -1 会自动计算
            4. SQL 语句地址
                - 后续操作当前查询结果的操作全部基于此地址
                - 需要释放
            5. 未使用的指针地址，通常传入 nil
        */
        var stmt: COpaquePointer = nil
        if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) != SQLITE_OK {
            print("SQL 错误")
            return nil
        }
        
        // 2. 单步执行获取结果集内容
        var result = [[String: AnyObject]]()
        while sqlite3_step(stmt) == SQLITE_ROW {
            result.append(record(stmt))
        }
        
        // 3. 释放语句句柄
        sqlite3_finalize(stmt)
        
        // 4. 返回结果
        return result
    }
    
    /// 从 stmt 中获取一条完整的记录
    ///
    /// - parameter stmt: stmt
    private func record(stmt: COpaquePointer) -> [String: AnyObject] {
        // 查询结果列数
        let colCount = sqlite3_column_count(stmt)
        
        // 单行记录字典
        var rowDict = [String: AnyObject]()
        // 遍历每一列
        for col in 0..<colCount {
            // 列名
            let cName = sqlite3_column_name(stmt, col)
            let name = String(CString: cName, encoding: NSUTF8StringEncoding)
            // 数据类型
            let type = sqlite3_column_type(stmt, col)

            var value: AnyObject?
            switch type {
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
            
            rowDict[name!] = value ?? NSNull()
        }
        
        return rowDict
    }
    
    // MARK: - 执行 SQL
    /// 执行 更新 / 删除 SQL
    ///
    /// - parameter sql: sql
    ///
    /// - returns: 返回 更新 / 删除 的数据行数
    func execUpdate(sql: String) -> Int {
        if sqlite3_exec(db, sql, nil, nil, nil) != SQLITE_OK {
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
    func execInsert(sql: String) -> Int {
        if sqlite3_exec(db, sql, nil, nil, nil) != SQLITE_OK {
            return -1
        }
        // 返回自动增长 id
        return Int(sqlite3_last_insert_rowid(db))
    }
    
    /// 执行 SQL
    ///
    /// - parameter sql: SQL
    ///
    /// - returns: 是否成功
    func execSQL(sql: String) -> Bool {
        
        /**
            参数
            1. 数据库句柄
            2. 要执行的 SQL 语句
            3. 执行完成后的回调，通常为 nil
            4. 回调函数第一个参数的地址，通常为 nil
            5. 错误信息地址，通常为 nil
        */
        return sqlite3_exec(db, sql, nil, nil, nil) == SQLITE_OK
    }
    
    // MARK: - 创建数据表
    /// 创建数据表 - 从 bundle 加载并执行 db.sql
    ///
    /// - returns: 是否成功
    private func createTable() -> Bool {
        // 1. 准备 SQL
        let path = NSBundle.mainBundle().pathForResource("db.sql", ofType: nil)!
        guard let sql = try? NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding) else {
            print("加载 SQL 失败")
            return false
        }
        
        // 2. 执行 SQL
        return execSQL(sql as String)
    }
    
    /// 创建数据表
    ///
    /// - returns: 是否成功
    private func createTable2() -> Bool {
        // 1. 准备 SQL
        let sql = "CREATE TABLE IF NOT EXISTS 'T_Person' ( \n" +
        "'id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, \n" +
        "'name' TEXT, \n" +
        "'age' INTEGER, \n" +
        "'height' REAL \n" +
        ");"
        
        // 2. 返回执行 SQL 的结果
        return execSQL(sql)
    }
}