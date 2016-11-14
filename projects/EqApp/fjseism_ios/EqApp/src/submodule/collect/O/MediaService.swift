//
//  MediaService.swift
//  EqApp
//
//  Created by apple on 16/9/7.
//  Copyright © 2016年 apple. All rights reserved.
//

import Foundation
class MediaService : IDBDao {
    static let ins =  MediaService(table:ISQLite.TABLE_MEDIA_DATAS)
    
    
    
    func  findAllBy(flag:String,sid:Int)->[TMedia] {
        var items:[TMedia] = []
        
        let dictary:[[String:AnyObject]]=query(false, cols: [], wher: T_MEDIA.SCENEID + "=? and " +
            T_MEDIA.FLAG + "=?  order by "+T_MEDIA.ID  + "  ", args: ["\(sid)",flag])
        
        for dict in dictary {
            
                let item = TMedia()
                item._id = dict[T_MEDIA.ID] as! Int
                item.sceneid = dict[T_MEDIA.SCENEID] as! Int
                item.content_name = dict[T_MEDIA.CONTENTNAME] as? String
                item.content_path = dict[T_MEDIA.CONTENTPATH] as? String
                item.flag = dict[T_MEDIA.FLAG] as! Int
                
                items.append(item);
        }
        
        return items
    }
    
    
    
    func findAllFIileBy(flag:String,sid:Int)->[String] {
        let items = findAllBy(flag,sid: sid)
        var files:[String] = []
        for  me in items{
            
            files.append((me.content_path! as NSString).lastPathComponent.strByAp2Doc());
        }
        return files;
        
    }
    
    
    func deleteBySid(sid:Int)->Int{
        return delete(T_MEDIA.SCENEID+"=\(sid)", args: [])
        
    }
}
