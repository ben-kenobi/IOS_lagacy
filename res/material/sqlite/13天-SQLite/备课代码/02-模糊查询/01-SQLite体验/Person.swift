//
//  Person.swift
//  01-SQLite体验
//
//  Created by 刘凡 on 15/10/29.
//  Copyright © 2015年 joyios. All rights reserved.
//

import UIKit

/// 个人模型
class Person: NSObject {

    // MARK: - 模型属性
    /// 代号
    var id = 0
    /// 姓名
    var name: String?
    /// 年龄
    var age = 0
    /// 身高
    var height: Double = 0
    
    // MARK: - 构造函数
    init(dict: [String: AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override var description: String {
        let keys = ["name", "age"]
        
        return dictionaryWithValuesForKeys(keys).description
    }
    
    // MARK: - 数据库操作方法
    /// 从数据库中加载 person 数组
    class func persons(text: String?) -> [Person]? {
        
        // 1. 准备 SQL
        var sql = "SELECT id, name, age, height FROM T_Person \n"
        
        if let text = text {
            sql += "WHERE name LIKE '%\(text)%'"
        }
        sql += ";"
        
        // 2. 访问数据库
        guard let array = SQLiteManager.sharedManager.execRecord(sql) else {
            return nil
        }
        
        // 3. 遍历数组字典转模型
        var arrayM = [Person]()
        
        for dict in array {
            arrayM.append(Person(dict: dict))
        }
        
        // 4. 返回结果
        return arrayM
    }
    
    /// 将当前对象从数据库中删除
    ///
    /// - returns: 是否成功
    func deletePerson() -> Bool {
        // 0. 断言
        assert(id > 0, "ID 必须 > 0")
        
        // 1. 准备 SQL
        let sql = "DELETE FROM T_Person WHERE id = \(id);"
        
        // 2. 返回结果
        let rows = SQLiteManager.sharedManager.execUpdate(sql)
        print("删除了 \(rows) 条记录")
        
        return rows > 0
    }
    
    /// 将当前对象的信息更新至数据库
    ///
    /// - returns: 是否成功
    func updatePerson() -> Bool {
        // 0. 断言
        assert(name != nil, "姓名不能为 nil")
        assert(id > 0, "ID 必须 > 0")
        
        // 1. 准备 SQL
        let sql = "UPDATE T_Person SET name = '\(name!)', age = \(age), height = \(height) \n" +
            "WHERE id = \(id);"
        
        // 2. 返回结果
        let rows = SQLiteManager.sharedManager.execUpdate(sql)
        print("更新了 \(rows) 条记录")
        
        return rows > 0
    }
    
    /// 将当前对象插入到数据库
    ///
    /// - returns: 是否成功
    func insertPerson() -> Bool {
        // 0. 断言姓名不为 nil
        assert(name != nil, "姓名不能为 nil")
        
        // 1. 准备 SQL
        let sql = "INSERT INTO T_Person (name, age, height) VALUES ('\(name!)', \(age), \(height));"
        
        // 2. 获得自动增长 id
        id = SQLiteManager.sharedManager.execInsert(sql)
        
        return id > 0
    }
}
