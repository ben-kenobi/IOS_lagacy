
//
//  MainVC.swift
//  day50-sqlite
//
//  Created by apple on 15/12/20.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor=irandColor()
        title="sqlite"
       
        
        
        
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
//        let g:dispatch_group_t = dispatch_group_create()
//        
//        dispatch_group_enter(g)
//        dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
//            
//            NSThread.sleepForTimeInterval(0.4)
//            print("1",NSThread.currentThread())
//            dispatch_group_leave(g)
//        }
//        
//        dispatch_group_enter(g)
//        dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
//            
//            NSThread.sleepForTimeInterval(0.2)
//            print("2",NSThread.currentThread())
//            dispatch_group_leave(g)
//        }
//        dispatch_group_notify(g, dispatch_get_main_queue()) { () -> Void in
//            print("33333")
//        }
//        
        iDBMan.ins.queue.inTransaction { (db, b) in
            for i in 0...3{
                
                db.executeUpdate("insert into t_person (name,age) values(:name,:age);", withParameterDictionary: ["name":"aaaa-\(i)","age":11,"score":22.3,"birth":"1-1"])
                if i==2{
                    b.memory=ObjCBool(true)
                }
            }
        }
        print(Person01.personsFromDB().count)

        print(Person01.personsFromDB())
        
      
        
    }
    
    func fmdbtest(){
        let p = Person01(dict: ["name":"ggggg","age":33])
        p.inser2DB()
        p.name="eewrwerewr"
        p.update2DB()
        p.del2DB()
        
        print(Person01.personsFromDB())
    }
    
    
    
    
    
    func sqltest(){
        SqliteMan.ins.execTran { () -> Bool in
            for i in 0...4{
                let p =  Person(dict: ["name":"aaaa-\(i)","age":11,"score":22.3,"birth":"1-1"])
                p.inser2DB()
            }
            return true
        }
        
        print(Person.personsFromDB())
    }
    
}
