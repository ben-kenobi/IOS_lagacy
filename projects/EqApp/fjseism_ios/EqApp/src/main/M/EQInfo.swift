//
//  EQInfo.swift
//  EqApp
//
//  Created by apple on 16/9/5.
//  Copyright © 2016年 apple. All rights reserved.
//

import Foundation
import ArcGIS
class EQInfo :NSObject{
    private static var ins:EQInfo?  = nil
    
    var lat:Double=0
    var lon:Double=0
    var occurTime:String?
    var focalDepth:Int=0
    var magnitude:String?
    var occurRegionName:String?
    var obsTime:Int=0
    var  hasLayer:Bool=false
    
    func toAGSPO()->AGSPoint{
        return AGSPoint(x:lon,y:lat,spatialReference: AGSSpatialReference(WKID: iConst.AGSKWID))
    }
    func isHasLayer()->Bool{
        if(hasLayer){
            return true;
        }
        return obsTime == PrefUtil.getObsTime()
    }
    func isCurrentEQ()->Bool{
        return obsTime == PrefUtil.getObsTime()
    }
    
    
    class func getIns()->EQInfo?{
    if(ins==nil){
        let js:NSData? = PrefUtil.getEQInfo()
        guard let data = js else{
            return nil
        }
    
        let dict = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! [String:AnyObject]
        
        ins = EQInfo(dict:dict)
    }
    
        return ins
    }
    class func setInsWith(dict:[String:AnyObject]){
        ins = EQInfo(dict:dict)
    }
    class func  setIns(info:EQInfo ){
        ins = info
    }
    

    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    override func setValue(value: AnyObject?, forKey key: String) {
        
        super.setValue(value, forKey: key)
        
    }
    override func valueForUndefinedKey(key: String) -> AnyObject? {
        return 0
    }
    
    override var description:String{
        get{
            return "\(occurRegionName ?? "")_\(occurTime ?? "")"
        }
    }
}
