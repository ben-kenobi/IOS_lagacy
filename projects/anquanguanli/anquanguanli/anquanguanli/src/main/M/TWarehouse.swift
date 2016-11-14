//
//  TWarehouse.swift
//  anquanguanli
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 apple. All rights reserved.
//

import Foundation

class TWarehouse :NSObject{
    
    
    
    //主键。UUID。
    var wareHouseId:String?
    //仓库名称。
    var wareHouseName:String?
    //所属区域ID。
    var belongRegionId:String?
    //所属区域。
    var belongRegion:String?
    //仓库编号
    var warehouseNo:String?
    //现有库存
    var stock:String?
    //联系人
    var linkman:String?
    //联系电话
    var tel:String?
    //登入名
    var loginName:String?
    //级别 （0：省，1：市，2：县）
    var LV:String?
    //所属县市
    var belongRegioncoci:String?
    //地址
    var address:String?
    //经度
    var lon:Int?
    //纬度
    var lat:Int?
    //最大库容
    var maxStock:String?
    //低库存容量预警阈值
    var minStock:String?
    //防爆仓库（0：是，-1：否）
    var antiExplosion:String?
    //安全保管箱(0：是，-1：否)
    var safeBox:String?
    //父级ID
    var parentId:String?
    //隶属区域
    var belongRegionci:String?
    //登录密码
    var pwd:String?
    //状态。默认：0。
    var status:Int?
    //备注。
    var remark:String?
    //创建时间。
    var createTime:NSDate=NSDate()
    //创建者。
    var creatorId:String?
    //装备表
    


}


