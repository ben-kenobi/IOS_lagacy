 //
//  DeathThematicQueryVC.swift
//  EqApp
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
import ArcGIS

class DeathThematicQueryVC: BaseVC {
    
    var idx:Int = 0
    var radius:Double = 0.1
    var po:AGSPoint?
    
    var lDisplayManager:AGSLocationDisplay?
    var poiLayer:AGSGraphicsLayer?
    lazy var mapV:AGSMapView={
        return AGSMapView(frame: CGRectMake(0, 0, iScrW, iScrH), bg: iConst.iGlobalBG)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "周边展示"
        initMapView()
    }
    
    func initMapView(){
        view.addSubview(mapV)
        mapV.enableWrapAround()
        
        let t_fj_vec =  TianDiTuTiledMapServiceLayer(mapType: TianDiTuLayerType.FJ_VEC_C)
        let t_fj_cva =  TianDiTuTiledMapServiceLayer(mapType: TianDiTuLayerType.FJ_CVA_C)
        
        mapV.addMapLayer(t_fj_vec)
        mapV.addMapLayer(t_fj_cva)
        
        
        poiLayer = AGSGraphicsLayer()
        mapV.addMapLayer(poiLayer, withName:"poi")
        mapV.callout.accessoryButtonHidden=true
        let lab = UILabel()
        lab.numberOfLines=0
        mapV.callout.delegate=self
        mapV.layerDelegate=self
        mapV.callout.customView=lab
//        startLocating()
        startQuery()
    }
    
    func startLocating(){
        lDisplayManager = mapV.locationDisplay
        
        lDisplayManager?.startDataSource()
        lDisplayManager?.autoPanMode = .Off
        lDisplayManager?.showsAccuracy=true
        lDisplayManager?.zoomScale=577143.73644287116
        lDisplayManager?.wanderExtentFactor = 0.75
               
    }
    
    func startQuery(){
        iPop.showProg()
        let pg=GraphicUtil.getCircle(po!, radius: radius)
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            self.queryBy(self.getShapefileInfo(self.idx), gp: pg)
        }
        self.poiLayer?.addGraphic(GraphicUtil.fillGraphicWith(pg))
        
    }
    
    
    func  queryBy(tuple:(String,AGSPictureMarkerSymbol),gp:AGSPolygon){
        let path = tuple.0.strByAp2Doc()
        
        if iFm.fileExistsAtPath(path){
            let db = try! AGSGDBGeodatabase(path: path)
            let tb = db.featureTables()[0] as! AGSGDBFeatureTable
            let query = AGSQuery()
            
            query.geometry=gp
            query.returnGeometry=true
            query.outFields=["*"]
            query.spatialRelationship = AGSSpatialRelationship.Within
            query.outSpatialReference = AGSSpatialReference(WKID: iConst.AGSKWID)
            
          
            tb.queryResultsWithParameters(query, completion: { (datas, err) in
                dispatch_async(dispatch_get_main_queue(), {
                    iPop.dismProg()
                    let tbi = tb
                    if let err = err{
                        print(err)
                    }else{
                        for  obj in datas{
                            if let fea = obj as? AGSGDBFeature{
                                var attr = fea.allAttributes()
                                attr["layerId"] = tuple.0
                                
                               self.poiLayer?.addGraphic(AGSGraphic(geometry: fea.geometry, symbol: tuple.1, attributes: attr))
                            }
                        }
                        
                    }
                })
               
            })
            
        }
        
        
    }
    func getShapefileInfo(idx:Int)->(String,AGSPictureMarkerSymbol){
        return (MapMod.shapefiles[idx],MapMod.shapeSymbol[idx])
    }

}

 
 
 extension DeathThematicQueryVC:AGSCalloutDelegate,AGSMapViewLayerDelegate{
    
    func mapViewDidLoad(mapView: AGSMapView!) {
        mapV.zoomToScale(577143.73644287116, withCenterPoint: po, animated: true)
    }
    
   
    func callout(callout: AGSCallout!, willShowForFeature feature: AGSFeature!, layer: AGSLayer!, mapPoint: AGSPoint!) -> Bool {
        if feature.allAttributes().isEmpty{
            return false
        }
        
        if idx == 1{
            let lab = callout.customView as! UILabel
            lab.text="名称:\(feature.attributeAsStringForKey("name"))\n等级:\(feature.attributeAsStringForKey("grade"))\n主管单位:\(feature.attributeAsStringForKey("membership"))"
            lab.sizeToFit()
            
        }else if idx == 2{
            let lab = callout.customView as! UILabel
            lab.text="名称:\(feature.attributeAsStringForKey("name"))\n等级:\(feature.attributeAsStringForKey("class"))"
            lab.sizeToFit()
        }else if idx == 0{
            let lab = callout.customView as! UILabel
            lab.text="名称:\(feature.attributeAsStringForKey("unitname"))\n类别:\(feature.attributeAsStringForKey("note_"))"
            lab.sizeToFit()
        }
        return true
    }
    
    
 }
