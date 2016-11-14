//
//  SceneService.swift
//  EqApp
//
//  Created by apple on 16/9/7.
//  Copyright © 2016年 apple. All rights reserved.
//

import Foundation

class SceneService:IDBDao {
    static let ins:SceneService = SceneService(table: ISQLite.TABLE_SCENE)
    
 
    func findAllBy(username:String,flag:String) -> [Tscene] {
        var items:[Tscene] = []
        // 如果flag=1 即查找历史数据，若当前obstime不是最新地震的obstime，则只查找当前obstime地震的历史数据
        // 若是最新地震，则展示全部历史数据
        var dictary:[[String:AnyObject]] = []
        if "1" == flag && EQInfo.getIns() != nil && !EQInfo.getIns()!.isCurrentEQ() {
            dictary = query(false, cols: [], wher: T_SCENE.LOGINNAME + "=? and " +
                T_SCENE.FLAG + "=? and "+T_SCENE.EVENTID+"=? order by " + T_SCENE.ID  + "  desc ", args: [username,flag,"\(EQInfo.getIns()!.obsTime)"])
        }else {
            dictary = query(false, cols: [], wher: T_SCENE.LOGINNAME + "=? and " +
                T_SCENE.FLAG + "=? order by " + T_SCENE.ID  + "  desc ", args: [username,flag])
        }
        for dict in dictary {
            
            let item =  Tscene()

                item._id = dict[T_SCENE.ID] as! Int
                item.event_id = dict[T_SCENE.EVENTID] as! String
                item.loginname = dict[T_SCENE.LOGINNAME] as? String
                item.flag = dict[T_SCENE.FLAG] as! Int
            item.addtime = NSDate(timeIntervalSince1970:NSTimeInterval(dict[T_SCENE.ADDTIME] as! Int/1000))
                item.title = dict[T_SCENE.TITLE] as? String
                item.detail = dict[T_SCENE.DETAIL] as? String
                item.remark = dict[T_SCENE.REMARK] as? String
                item.eqlevelidx = dict[T_SCENE.EQLEVELIDX] as! Int
                item.summaryidx = dict[T_SCENE.SUMMARYIDX] as! Int
                item.loc_lat = dict[T_SCENE.LOC_LAT] as! Double
                item.loc_lon = dict[T_SCENE.LOC_LON] as! Double
                item.submittime = NSDate(timeIntervalSince1970:NSTimeInterval(dict[T_SCENE.SUBMITTIME] as! Int/1000))
                item.fpaths = MediaService.ins.findAllFIileBy("0",sid: item._id)
                
                items.append(item)
        }
    
        return items;
    }
}
