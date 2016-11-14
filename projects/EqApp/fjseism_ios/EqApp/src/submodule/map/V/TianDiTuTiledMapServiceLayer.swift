//
//  TianDiTuTiledMapServiceLayer.swift
//  EqApp
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
import ArcGIS

class TianDiTuTiledMapServiceLayer: AGSTiledServiceLayer,AGSLayerDelegate{
    let spatialRef = AGSSpatialReference(WKID: iConst.AGSKWID)
    var  _mapType:TianDiTuLayerType?
    var  tiandituTileInfo:AGSTileInfo?
    override var fullEnvelope: AGSEnvelope!{
        get{
            return AGSEnvelope(xmin: 92.93146146525402, ymin:  18.546482511842392, xmax: 126.21035393190226, ymax: 38.449495570658648, spatialReference: spatialRef)
        }
    }
    
    override var tileInfo: AGSTileInfo!{
        get{
          return self.tiandituTileInfo
        }
    }
  
    override var spatialReference: AGSSpatialReference!{
        get{
            return spatialRef
        }
    }
    
    
    override convenience init(){
        self.init(mapType: nil,usercredentials: nil,flag: true)
        
        
    }
    convenience init( mapType:TianDiTuLayerType) {
        self.init(mapType: mapType,usercredentials: nil,flag: true)
        
    }
    
    convenience init( mapType:TianDiTuLayerType,  usercredentials:AGSCredential) {
        self.init(mapType: mapType,usercredentials: usercredentials,flag: true)
        
    }
    
     init(mapType:TianDiTuLayerType?,usercredentials:AGSCredential?,flag:Bool){
        super.init()
        
        self._mapType=mapType
//        self.setCredentials(usercredentials)
        if(flag){
            dispatch_async(dispatch_get_global_queue(0, 0), {
                self.initLayer()
            })
        }

    }
    
    required init!(JSON json: [NSObject : AnyObject]!) {
        fatalError("init(JSON:) has not been implemented")
    }
    
   
    
    func  getMapType()->TianDiTuLayerType? {
        return self._mapType;
    }
    
    func initLayer(){
        self.buildTileInfo()
        self.tileInfo.computeTileBounds(AGSEnvelope(xmin: 112.93146146525402, ymin:  21.546482511842392, xmax: 125.21035393190226, ymax: 30.449495570658648, spatialReference: spatialRef))
        initialEnvelope = AGSEnvelope(xmin: 119.11, ymin: 25.97, xmax: 119.49, ymax: 26.19, spatialReference: spatialRef)
        self.delegate=self
        super.layerDidLoad()
        

    }
    
    
    
    override func requestTileForKey(key: AGSTileKey!) {
        super.requestTileForKey(key)
    }
    override func refresh() {
        super.refresh()
    }
    
    
    override func urlForTileKey(key: AGSTileKey!) -> NSURL! {
        
        return iUrl(getTianDiMapUrl(key.level, col: key.column, row: key.row))
    }
    
    



    func getTianDiMapUrl( level:Int,  col:Int,  row:Int)->String? {
        return TDTUrl(level: level, col: col, row: row, type: self._mapType!).generatUrl()
    }
   
    


func  buildTileInfo() {
    let  originalPoint = AGSPoint(x: -180, y: 90, spatialReference: spatialRef)
    
    
    
    let res:[Double] = [
        1.40625,
        0.703125,
        0.3515625,
        0.17578125,
        0.087890625,
        0.0439453125,
        0.02197265625,
        0.010986328125,
        0.0054931640625,
        0.00274658203125,
        0.001373291015625,
        0.0006866455078125,
        0.00034332275390625,
        0.000171661376953125,
        8.58306884765625e-005,
        4.291534423828125e-005,
        2.1457672119140625e-005,
        1.0728836059570313e-005,
        5.36441802978515E-06//,
        //2.68220901489258E-06,
        //1.34110450744629E-06
    ]
    let scale:[Double] = [
        400000000,
        295497598.5708346,
        147748799.285417,
        73874399.6427087,
        36937199.8213544,
        18468599.9106772,
        9234299.95533859,
        4617149.8915429693,
        2308574.9457714846,
        1154287.4728857423,
        577143.73644287116,
        288571.86822143558,
        144285.93411071779,
        72142.967055358895,
        36071.483527679447,
        18035.741763839724,
        9017.8708819198619,
        4508.9354409599309,
        2254.467762533835//,
        //1127.2338812669175,
        //563.616940
    ]
    let levels = 19
    var lods:[AGSLOD]=[]
    for (idx,d) in res.enumerate(){
        lods.append(AGSLOD(level: (UInt(idx)+1), resolution: d, scale: scale[idx])
)
    }
    
    self.tiandituTileInfo = AGSTileInfo(dpi: 96, format: kUTTypePNG as String, lods: lods, origin: originalPoint, spatialReference: spatialRef, tileSize: CGSizeMake(256, 256))
    
}
}


extension TianDiTuTiledMapServiceLayer{
    func layerDidLoad(layer: AGSLayer!) {
        
    }
    func layer(layer: AGSLayer!, didFailToLoadWithError error: NSError!) {
        
    }
    func layer(layer: AGSLayer!, didInitializeSpatialReferenceStatus srStatusValid: Bool) {
        
    }
}




class TDTUrl{
    var _tiandituMapServiceType:TianDiTuLayerType = .FJ_VEC_C
    var  _level:Int = 0
    var  _col:Int = 0
    var  _row:Int = 0
    init(level:Int,col:Int,row:Int,type:TianDiTuLayerType){
        self._level=level
        self._col=col
        self._row=row
        self._tiandituMapServiceType=type
    }
    
    func  generatUrl()->String?{
        switch self._tiandituMapServiceType {
        case .VEC_C,
             .CVA_C,
             .CIA_C,
             .IMG_C:
            return generateTianDiTuUrl();
        case .FJ_VEC_C,
             .FJ_CVA_C:
            return generateFjTianDiTuUrl();
        default:
            return nil
        }
    }
    func   generateTianDiTuUrl()->String?{
        /**
         * 天地图矢量、影像
         * */
        var  url="http://t"
        url += "\(irand(6)+1)"
        switch(self._tiandituMapServiceType){
        case .VEC_C:
            url += ".tianditu.com/DataServer?T=vec_c&X=\(self._col)&Y=\(self._row)&L=\(self._level)"
            
        case .CVA_C:
            url += ".tianditu.com/DataServer?T=cva_c&X=\(self._col)&Y=\(self._row)&L=\(self._level)"
        case .CIA_C:
            url += ".tianditu.com/DataServer?T=cia_c&X=\(self._col)&Y=\(self._row)&L=\(self._level)"
            
        case .IMG_C:
            url += ".tianditu.com/DataServer?T=img_c&X=\(self._col)&Y=\(self._row)&L=\(self._level)"
            
        default:
            return nil;
        }
        return url
    }
    func generateFjTianDiTuUrl()->String?{
        /**
         * 天地图福建矢量
         * */
        var url = "http://service.fjmap.net/"
        switch(self._tiandituMapServiceType){
        case .FJ_VEC_C:
            url += "vec_fj/wmts?LAYER=vec_fj&STYLE=vec_fj"
            
        case .FJ_CVA_C:
            url += "cva_fj/wmts?LAYER=cva_fj&STYLE=cva_fj"
            
        default:
            return nil
        }
        url += "&TILEMATRIXSET=Matrix_0&FORMAT=image/png&SERVICE=WMTS&REQUEST=GetTile&VERSION=1.0.0&TILECOL=\(self._col)&TILEROW=\(self._row)&TILEMATRIX=\(self._level)"
        
        return url
    }
}


public enum TianDiTuLayerType : Int {
    
    /**
     * 天地图矢量
     * */
    case VEC_C
    /**
     * 天地图影像
     * */
    case IMG_C
    /**
     * 天地图矢量标注
     * */
    case CVA_C
    /**
     * 天地图影像标注
     * */
    case CIA_C
    /**
     * 天地图福建矢量
     */
    case FJ_VEC_C
    /**
     * 天地图福建矢量标注
     */
    case FJ_CVA_C
}
