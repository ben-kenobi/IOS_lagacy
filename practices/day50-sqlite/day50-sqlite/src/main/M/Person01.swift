
//
//  Modle01.swift
//  day50-sqlite
//
//  Created by apple on 15/12/21.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class Person01: NSObject {
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
        let count =  iDBMan.ins.update("delete from   t_person where _id = :_id;", dict: ["_id":Int(_id)])

        return  count > 0
    }
    
    func update2DB()->Bool{
        let count =  iDBMan.ins.update("update  t_person set name=\(name!),age=\(age) ;")
        
        return  count > 0
    }
    func inser2DB()->Bool{
       let id =  iDBMan.ins.insert("insert into t_person (name,age) values(?,?);", args: [name!,age])
        _id=id
        return  id > 0
    }
    
    
    class func personsFromDB()->[Person01]{
        var ary = [Person01]()
        
        
        for dict in iDBMan.ins.query("select _id,name,age from t_person ;",args: []){
            ary.append(Person01(dict: dict))
        }
                
        return ary
    }
}
