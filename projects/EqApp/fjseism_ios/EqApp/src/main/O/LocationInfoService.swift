//
//  LocationInfoService.swift
//  EqApp
//
//  Created by apple on 16/9/6.
//  Copyright © 2016年 apple. All rights reserved.
//

import Foundation
class LocationInfoService:IDBDao {
    static  let ins:LocationInfoService = LocationInfoService(table: ISQLite.TABLE_LOCATIONINFO)
    
    
    func findByParent(parent:LocationInfo?)->[LocationInfo]{
        var  items:[LocationInfo] = []
        var result:[[String:AnyObject]] = []
        if(parent == nil){
            result = query(false, cols: [], wher: "LV=1 order by REGION_ID ", args: [])
            
        }else{
            result = query(false, cols: [], wher: "PARENT_REGION_ID=? order by REGION_ID ", args: [parent!.REGION_ID])
            
        }
        
        for dict in result{
            items.append(LocationInfo(dict:dict))
        }
        return items
    }
    
}


