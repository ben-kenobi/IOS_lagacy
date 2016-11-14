//
//  MapMod.swift
//  EqApp
//
//  Created by apple on 16/9/20.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
import ArcGIS
class MapMod{
    static let controlflows:[String]=["学校","医院","疏散场地"]
//    static let shapefiles:[String]=["eqAppData/fj_school/school.shp",
//                                    "eqAppData/fj_hospital/hospital.shp",
//                                    "eqAppData/fj_city_site/city_site.shp"]
    static let shapefiles:[String]=["eqAppData/fj_school.geodatabase",
                                    "eqAppData/fj_hospital.geodatabase",
                                    "eqAppData/fj_city_site.geodatabase"]
    static let shapeSymbol:[AGSPictureMarkerSymbol]=[
        AGSPictureMarkerSymbol(imageNamed: "school_1"),
        AGSPictureMarkerSymbol(imageNamed: "hospital_i"),
        AGSPictureMarkerSymbol(imageNamed: "shelters"),
    ]
}
