//
//  ContactSer.swift
//  EqApp
//
//  Created by apple on 16/9/22.
//  Copyright © 2016年 apple. All rights reserved.
//

import Foundation
class ContactSer:IDBDao{
    static let ins:ContactSer = ContactSer(table: ISQLite.CONTACT)
    
    
    func findBy(arg:ContactSearchArgs) -> [ContactM] {
        var items:[ContactM] = []
        var dictary:[[String:AnyObject]] = []
        dictary = query(false, cols: [], wher: arg.genWhere(), args: [])
//        print(arg.genWhere())
//        print(dictary)
        for dict in dictary {
            
            let item =  ContactM(dict:dict)
          
            items.append(item)
        }
        return items;
    }
    func findGroupBy(arg:ContactSearchArgs)->[String:ContactGroup]{
        var dict = [String:ContactGroup]()
        let ary = findBy(arg)
        for m in ary {
            if let key = m.sortKey{
                var group = dict[key]
                if group == nil {
                    group = ContactGroup()
                    dict[key] = group
                }
                group!.mods.append(m)
            }
        }
        return dict
    }
    func findGroupsBy(arg:ContactSearchArgs)->ContactGroups{
        let cgs=ContactGroups()
        cgs.dict = findGroupBy(arg)
        return cgs
    }
    
    
    func synWithServer(dicts:[[String:AnyObject]])->(Int,Int){
        var result:(Int,Int) = (0,0)
        ISQLite.ins.transaction { (db, rollback) in
            ISQLite.ins.delete(self.table!, wher: "uploaded=?", args: [0])
            for var dict in dicts{
                let tid = dict.removeValueForKey("TID")
                dict["id"]=tid
                if ISQLite.ins.insert(self.table!, dict: dict,db: db) > 0{
                    result.0 += 1
                }else{
                    result.1 += 1
                }
            }
        }
        return result
    }
    
    
    
}


