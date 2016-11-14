

//
//  Person.swift
//  day50-sqlite
//
//  Created by apple on 15/12/20.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class Person: NSObject {
    
    var _id:Int64=0
    var name:String?
    var age: Int=0
    var score: Double=0
    var birth:String?

    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {

    }
    
    
    override var description:String{
        let keys = ["_id","name","age","score","birth"]
        return dictionaryWithValuesForKeys(keys).description
    }
    
    
    func del2DB()->Bool{
        let sql="delete from   t_person  where _id=\(_id);"
        let count=SqliteMan.ins.execDML(sql)
        return count > 0
    }
    
    func update2DB()->Bool{
        let sql="update  t_person set name = '\(name!)' ,age=\(age),score=\(score),birth=\(birth!) where _id=\(_id);"
        let count=SqliteMan.ins.execDML(sql)

        return count > 0
    }
    func inser2DB()->Bool{
        let sql="insert into t_person (name,age,score,birth) values ('\(name!)',\(age),\(score),'\(birth!)');"
        _id = SqliteMan.ins.execInsert(sql)
        return _id > 0
    }
    
    
    class func personsFromDB()->[Person]{
        var ary = [Person]()
        
        let sql="select _id,name,age,score,birth from T_Person ;"
        
        for dict in SqliteMan.ins.query(sql){
            ary.append(Person(dict: dict))
        }
        
        return ary
    }
    
}
