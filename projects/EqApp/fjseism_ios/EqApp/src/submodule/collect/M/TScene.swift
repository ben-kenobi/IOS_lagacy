//
//  TScene.swift
//  EqApp
//
//  Created by apple on 16/9/7.
//  Copyright © 2016年 apple. All rights reserved.
//

import Foundation
class Tscene :NSObject{
    
    var  _id:Int=0
    var  event_id:String = "\(PrefUtil.getObsTime_instant())", loginname:String? = UserInfo.me.NAME, title:String?, detail:String?, remark:String?;
    var flag:Int=0, eqlevelidx:Int=0, summaryidx:Int=0;
    var addtime:NSDate = NSDate(), submittime:NSDate = NSDate();
    var loc_lat:Double=0, loc_lon:Double=0;
    
    
    var  fpaths:[String] = []
    
    
    func insertOrUpdate() {
        var dict = self.convert2dict()
        dict.removeValueForKey("fpaths")
        dict.removeValueForKey("_id")
        dict["addtime"]=Int(addtime.timeIntervalSince1970*1000)
        dict["submittime"]=Int(submittime.timeIntervalSince1970*1000)
        
        if (_id == 0) {
            _id = Int(SceneService.ins.insert(dict))
            for path in fpaths{
                var fd = [String:AnyObject]()
                fd[T_MEDIA.CONTENTNAME] = (path as NSString).lastPathComponent
                fd[T_MEDIA.CONTENTPATH] = path
                fd[T_MEDIA.SCENEID] = _id
                MediaService.ins.insert(fd)
            }
        } else {
            SceneService.ins.updateById(dict, id: _id)
            MediaService.ins.deleteBySid(_id);
            for path in fpaths{
                var fd = [String:AnyObject]()
                fd[T_MEDIA.CONTENTNAME] = (path as NSString).lastPathComponent
                fd[T_MEDIA.CONTENTPATH] = path
                fd[T_MEDIA.SCENEID] = _id
                MediaService.ins.insert(fd)
            }
            
        }
        
        
    }
    
    func uploaded(usesrc:Bool) {
        var dict:[String:AnyObject] = [String:AnyObject]()
        dict[T_SCENE.FLAG] = 1
        dict[T_SCENE.SUBMITTIME] = Int(NSTimeIntervalSince1970 * 1000)
        dict[T_SCENE.REMARK] = usesrc ? "1" : "0"
        
        SceneService.ins.updateById(dict, id: _id)
        flag = 1;
        
    }
    
    func delete() {
        
        SceneService.ins.delete("\(_id)")
        MediaService.ins.deleteBySid(_id)
        let dir:String =  FileUtil.docPath()
        for path in fpaths{
//            if path.hasPrefix(dir){ 
                if iFm.fileExistsAtPath(path){
                    try! iFm.removeItemAtPath(path)
                }
                let f2 = dir+"/"+iConst.SMALLFILEPREFIX+(path as NSString).lastPathComponent
                if iFm.fileExistsAtPath(f2){
                    try! iFm.removeItemAtPath(f2)
                }
//            }
        }
    }
    
    func rmFAtIdx(idx:Int) {
        let path:String=fpaths.removeAtIndex(idx)
        if iFm.fileExistsAtPath(path){
            try! iFm.removeItemAtPath(path)
        }

        
    }
}