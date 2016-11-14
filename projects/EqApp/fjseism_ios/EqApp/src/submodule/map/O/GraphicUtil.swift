//
//  GraphicUtil.swift
//  EqApp
//
//  Created by apple on 16/9/20.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
import ArcGIS

class GraphicUtil {
    static let sr = AGSSpatialReference(WKID: iConst.AGSKWID)
    
    class func  createPictureMarkerSymbol(img:UIImage,
                                          attributes:[String:AnyObject]?,
                                          po:AGSPoint) ->AGSGraphic{
        let pic = AGSPictureMarkerSymbol(image: img)
        
        
        
        
        return AGSGraphic(geometry: po, symbol: pic, attributes: attributes)
    }
    
    
    class func  createPictureMarkerSymbol(symbol:AGSPictureMarkerSymbol,
                                          attributes:[String:AnyObject]?,
                                          po:AGSPoint) -> AGSGraphic{
        
        
        
        return AGSGraphic(geometry: po, symbol: symbol, attributes: attributes)
    }
    
    
    class func fillGraphicWith(pg:AGSPolygon)->AGSGraphic{
         let sib=AGSSimpleFillSymbol(color: iColor(0x11ff0000), outlineColor: iColor(0x88888888))
        return AGSGraphic(geometry: pg, symbol: sib, attributes: nil)
    }
    
    class func  getCircle(center:AGSPoint,radius:Double)->AGSPolygon {
        
        let polygon = AGSMutablePolygon(spatialReference: sr)
        polygon.addRingToPolygon()
        for po in getPoints(center, radius: radius){
            polygon.addPointToRing(po)
        }
        polygon.closePolygon()
        
        return polygon
    }
    
    class func getPoints( center:AGSPoint,  radius:Double) ->[AGSPoint]{
        let count = 50
        var pos:[AGSPoint] = []
        
        for i in 0..<count{
            let arc = M_PI*2/Double(count)*Double(i)
            pos.append(AGSPoint(x:center.x + radius*cos(arc), y: center.y + radius*sin(arc), spatialReference: sr))
        }
        return pos
    }
}