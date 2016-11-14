//
//  LocationInfo.swift
//  EqApp
//
//  Created by apple on 16/9/6.
//  Copyright © 2016年 apple. All rights reserved.
//

import Foundation
class LocationInfo:NSObject{
    
    var  ID:Int=0,LV:Int=0;
    var  REGION_ID:String="",REGION_NAME:String="",PARENT_REGION_ID:String="";
    var LON:Double=0,LAT:Double=0;
    
    override var description: String{
        get{
            return REGION_NAME+"--"+REGION_ID+"--"+PARENT_REGION_ID
        }
    }
}
