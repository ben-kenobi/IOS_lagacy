//
//  TMedia.swift
//  EqApp
//
//  Created by apple on 16/9/7.
//  Copyright © 2016年 apple. All rights reserved.
//

import Foundation
class TMedia {
    var _id:Int=0,sceneid:Int=0
    var  content_name:String?,content_path:String?
    var flag:Int=0
    
    func getFile(inout map:[String:String])->(){
        map[content_name!]=content_path
    }
    
    
}
