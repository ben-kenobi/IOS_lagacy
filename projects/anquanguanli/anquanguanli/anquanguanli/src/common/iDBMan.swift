//
//  FMDBMan.swift
//  day50-sqlite
//
//  Created by apple on 15/12/21.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class iDBMan {
    
    private let path="fmtest.db"
    private let sqlfile="tables.sql"
    
    static let ins:iDBMan=iDBMan()
    
    let queue:FMDatabaseQueue
    
    private init(){
        queue=FMDatabaseQueue(path: path.strByAp2Doc())
        if !iDBMan.execSql4F(iRes(sqlfile)!){
            iCommonLog(" fail to init fmdb")
        }
    }
    
    
    class func execSql4F(path:String)->Bool{
        return execSql(try! String(contentsOfFile: path))
    }
    class func execSql(sql:String)->Bool{
        var b:Bool = false
        ins.queue.inDatabase { (db) -> Void in
           b = db.executeStatements(sql)
        }
        return b
    }
    
    
    
    
    
     
    class func insert(sql:String,args:[AnyObject]?=nil,dict:[String:AnyObject]?=nil)->Int64{
        var b:Bool=false
        var id:Int64 = 0
        ins.queue.inDatabase { (db) -> Void in
            if args != nil{
                b=db.executeUpdate(sql, withArgumentsInArray: args)
            }else if dict != nil{
                b=db.executeUpdate(sql, withParameterDictionary: dict)
            }else{
                b=db.executeUpdate(sql)
            }
         
            id = db.lastInsertRowId()

        }
         return b ? id: -1
    }
    
    
    
    
  
    
    class func update(sql:String,args:[AnyObject]?=nil,dict:[String:AnyObject]?=nil)->Int{
        var b:Bool=false
        var count:Int = 0
        ins.queue.inDatabase { (db) -> Void in
            if args != nil{
                b=db.executeUpdate(sql, withArgumentsInArray: args)
            }else if dict != nil{
                b=db.executeUpdate(sql, withParameterDictionary: dict)
            }else{
                b=db.executeUpdate(sql)
            }
            
            count = Int(db.changes())
        }
        return b ? count : -1
    }
    
    
    class func query(sql:String,args:[AnyObject]?=nil,dict:[String:AnyObject]?=nil)->[[String:AnyObject]]{
        var ary = [[String:AnyObject]]()
        ins.queue.inDatabase { (db) -> Void in
            var rs:FMResultSet?
            if args != nil{
                rs=db.executeQuery(sql, withArgumentsInArray: args)
            }else if dict != nil {
                rs=db.executeQuery(sql, withParameterDictionary: dict)
            }else{
                rs=db.executeQuery(sql)
            }
            
            
            if let rs = rs{
                while rs.next(){
                    ary.append(self.rowInfo(rs))
                }
            }
        }
        return ary
    }
    

    
    class func rowInfo(rs:FMResultSet)->[String:AnyObject]{
        var row = [String:AnyObject]()
        
        let count = rs.columnCount()
        for i in 0..<count{
            row[rs.columnNameForIndex(i)]=rs.objectForColumnIndex(i)
        }
        return row
    }
    
 
    
}


