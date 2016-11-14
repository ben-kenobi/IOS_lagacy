//
//  Person.swift
//  01-SQLite体验
//
//  Created by 刘凡 on 15/12/20.
//  Copyright © 2015年 joyios. All rights reserved.
//

import UIKit

class Person: NSObject {
    var id: Int64 = 0
    var name: String?
    var age = 0
    var height: Double = 0;
    
    // MARK: - 构造函数
    init(dict: [String: AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override var description: String {
        let keys = ["id", "name", "age", "height"]
        
        return dictionaryWithValuesForKeys(keys).description
    }
    
    // MARK: - 数据查询
    /// 从数据库中加载 person 数组
    class func persons() -> [Person]? {

        // 1. 准备 SQL
        let sql = "SELECT id, name, age, height FROM T_Person;"
        
        // 2. 访问数据库获得字典数组
        guard let rows = SQLiteManager.sharedManager.execRecordSet(sql) else {
            return nil
        }
        
        // 3. 遍历字典数组 - 字典转模型
        var arrayM = [Person]()
        for row in rows {
            arrayM.append(Person(dict: row))
        }
        
        // 4. 返回结果集合
        return arrayM
    }
    
    // MARK: - 数据操作
    /// 将当前对象从数据库中删除
    ///
    /// - returns: 是否成功
    func deletePerson() -> Bool {
        if id <= 0 {
            print("id 不正确")
            
            return false
        }
        
        let sql = "DELETE FROM T_Person WHERE id = \(id);"
        
        return SQLiteManager.sharedManager.execUpdate(sql) > 0
    }

    /// 将当前对象信息更新到数据库
    ///
    /// - returns: 是否成功
    func updatePerson() -> Bool {
        guard let name = name else {
            print("姓名不能为空")
            
            return false
        }
        if id <= 0 {
            print("id 不正确")
            
            return false
        }
        
        let sql = "UPDATE T_Person set name = '\(name)', age = \(age), height = \(height) \n" +
            "WHERE id = \(id);"
        
        return SQLiteManager.sharedManager.execUpdate(sql) > 0
    }
    
    /// 将当前对象添加到数据库
    ///
    /// - returns: 是否成功
    func insertPerson() -> Bool {
        guard let name = name else {
            print("姓名不能为空")
            
            return false
        }
        
        let sql = "INSERT INTO T_Person (name, age, height) VALUES ('\(name)', \(age), \(height));"
        
        id = SQLiteManager.sharedManager.execInsert(sql)
        
        return id > 0
    }
}
