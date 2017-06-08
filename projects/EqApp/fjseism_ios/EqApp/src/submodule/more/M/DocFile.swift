
//
//  DocFile.swift
//  EqApp
//
//  Created by apple on 16/9/15.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class DocFile: NSObject {
    
    var  name:String?, path:String?,url:String?,showname:String?;
    var  size:Int64=0
    var  genTime:NSDate?
    
    class func getByPath(path:String)->DocFile{
        let dc =  DocFile()
        dc.path = path
        if iFm.fileExistsAtPath(dc.path!){
            dc.size = (try! iFm.attributesOfItemAtPath(dc.path!)[NSFileSize] as! NSNumber).longLongValue
        }
        dc.name = (path as NSString).lastPathComponent
        dc.showname = (path as NSString).lastPathComponent
        return dc
    }
    class func  getByPrefix(pref:String,showPref:String,info:EQInfo)->DocFile{
        let dc =  DocFile()
        dc.showname="\(showPref)\(info.obsTime).doc"
        //        dc.name="\(pref)\(info.obsTime).doc"
        dc.name="\(pref)\(info.occurTime!.stringByReplacingOccurrencesOfString(",", withString: "").stringByReplacingOccurrencesOfString(":", withString: "").stringByReplacingOccurrencesOfString(".0000", withString: "")).doc"
        
        dc.path = dc.name?.strByAp2Doc()
        dc.genTime = NSDate()
        dc.url = iConst.eqFilePrefix+dc.name!
        if iFm.fileExistsAtPath(dc.path!){
            
            dc.size = Int64(iData4F(dc.path!)?.length ?? 0)
//            dc.genTime = (try! iFm.attributesOfItemAtPath(dc.path!))[NSFileModificationDate] as! NSDate

        }
        return dc
    }
    
}
