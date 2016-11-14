//
//  TsceneProg.swift
//  EqApp
//
//  Created by apple on 16/9/12.
//  Copyright © 2016年 apple. All rights reserved.
//

import Foundation
class TsceneProg:NSObject{
    
    var _id:Int=0,total:Int64=0,_progress:Int64=0
    var progress:Int64{
        get{
          return _progress
        }
        set{
            _progress=newValue
            cb?.update()
        }
    }
    var state:Int{
        get{
            return _state
        }
        set{
            _state=newValue
            cb?.update()
        }
    }
    var compressing:Bool=true
    var  _state:Int=0 // 0 uploading  1 complete  2 failure
    var describe:String?
    var uploadhandler:AFHTTPRequestOperation?
    weak var cb:UploadProgUpdater?
    
}


public protocol UploadProgUpdater:NSObjectProtocol{
    func update()
}
