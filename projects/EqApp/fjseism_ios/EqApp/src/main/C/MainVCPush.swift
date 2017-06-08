//
//  MainVCPush.swift
//  EqApp
//
//  Created by apple on 16/9/29.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
extension MainVC{
    func didReceiveMsg(noti:NSNotification){
        let userInfo = noti.userInfo!
        
        let content = userInfo["content"] as? String
        
        
        let str = AppDelegate.logDic(userInfo)
        let currentContent = String(format: "收到自定义消息:\n%@\n", str)
        print(currentContent)
        
        handleLayerNoti(content!)
    }
    
    func handleLayerNoti(content:String){
        var dict1:[String:AnyObject]?=nil
        do{
         dict1 = try NSJSONSerialization.JSONObjectWithData(content.dataUsingEncoding(4)!, options: []) as? [String:AnyObject]
        }catch{}

        guard let dict = dict1 else{
            return
        }
        
        let serverId = "\(dict["serviceId"]!)"
        
        
        if("ha000001" == (serverId)){
            iPop.toast("灾损专题图开始生成")
            
        }else if ("ha000002" == (serverId)){
            let result = dict["data"] as! [String:AnyObject]
            let obsTime = result["obsTime"]!.integerValue
            
            PrefUtil.putObsTime(obsTime)
            
            let  layerNames = result["layerNames"] as! [String:String]
            
//            let  resport = result["reports"] as! [String:String]
            
            iPop.toast("灾损专题图生成完毕")
            
        }else if("ha000003" == (serverId)){
            let result = dict["data"] as! [String:AnyObject]
            PrefUtil.putEQInfo(try! NSJSONSerialization.dataWithJSONObject(result, options: []))
            
            EQInfo.setInsWith(result)
            
            let obsTime = result["obsTime"]!.integerValue
            PrefUtil.putObsTime_instant(obsTime)
            
            let info = "\(result["occurRegionName"]!) 发生 \(result["magnitude"]!)级地震,震源深度\(result["focalDepth"]!)"
            iPop.toast(info)
            locateEq()
            showEarthquakePop(btns[0])
            
        }else if("cm000001" == (serverId)){
            let m = dict["data"] as! [String:AnyObject]
            iPop.toast("收到一条指令: \(m["msg"]!)")
            (btns[3] as! ImgPaddingBtn).badgeCount += 1
//            onClick(btns[3])
        }
    }
    
}
