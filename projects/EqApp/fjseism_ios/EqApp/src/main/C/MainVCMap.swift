//
//  MainVCMap.swift
//  EqApp
//
//  Created by apple on 16/9/5.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
import ArcGIS
extension MainVC{
    
    
    func initMap(){
        try! AGSRuntimeEnvironment.setClientID("1eFHW78avlnRUPHm")
        view.addSubview(mapV)
//        mapV.enableWrapAround()
        mapV.disableWrapAround()
        mapV.layerDelegate=self
        let t_fj_vec =  TianDiTuTiledMapServiceLayer(mapType: TianDiTuLayerType.FJ_VEC_C)
        let t_fj_cva =  TianDiTuTiledMapServiceLayer(mapType: TianDiTuLayerType.FJ_CVA_C)
        
        let t_vec =  TianDiTuTiledMapServiceLayer(mapType: TianDiTuLayerType.VEC_C)
        let t_cva =  TianDiTuTiledMapServiceLayer(mapType: TianDiTuLayerType.CVA_C)
        mapV.addMapLayer(t_vec)
        mapV.addMapLayer(t_cva)
        mapV.addMapLayer(t_fj_vec)
        mapV.addMapLayer(t_fj_cva)
        mapV.touchDelegate=self
        
        poiLayer = AGSGraphicsLayer()
        mapV.addMapLayer(poiLayer, withName:"poi")
        mapV.callout.accessoryButtonHidden=true
        let lab = UILabel()
        lab.numberOfLines=0
        mapV.callout.delegate=self
        mapV.callout.customView=lab
        
        
    }
    
    func locateEq(){
        // TODO locate EQ
        if let info = EQInfo.getIns(){
            mapV.zoomToScale(288571.86822143558, withCenterPoint: info.toAGSPO(), animated: true)
            let g = GraphicUtil.createPictureMarkerSymbol(iimg("mark")!, attributes: nil, po: info.toAGSPO())
            if earthquakeLayer == nil{
                earthquakeLayer = AGSGraphicsLayer()
                mapV.addMapLayer(earthquakeLayer)
            }
            earthquakeLayer!.removeAllGraphics()
            earthquakeLayer!.addGraphic(g)
            
        }else{
            iPop.toast("当前没有地震点")
        }
        
    }
    
    func locateAt(po:AGSPoint,graphic:Bool){
          self.mapV.zoomToScale(mapV.mapScale, withCenterPoint:po, animated: true)
        if(graphic){
            let g = GraphicUtil.createPictureMarkerSymbol(iimg("mark")!, attributes: nil, po: po)
            if earthquakeLayer == nil{
                earthquakeLayer = AGSGraphicsLayer()
                mapV.addMapLayer(earthquakeLayer)
            }
            earthquakeLayer!.removeAllGraphics()
            earthquakeLayer!.addGraphic(g)
        }
    }
    
    
    
    
    func startLocating(){
        lDisplayManager = mapV.locationDisplay
        
        lDisplayManager?.startDataSource()
        lDisplayManager?.autoPanMode = .Default
        lDisplayManager?.showsAccuracy=true
        lDisplayManager?.zoomScale=577143.73644287116
        lDisplayManager?.wanderExtentFactor = 0.75
        lDisplayManager?.addObserver(self, forKeyPath: "location", options: .New, context: nil)
        timer?.invalidate()
        timer=nil
//       timer = iTimer(5, tar: self, sel:#selector(self.startUploadLoc))
        
        
        
        if (nil == locationMan){
            locationMan=CLLocationManager()
        }
        
        locationMan!.delegate = self
        locationMan!.desiredAccuracy = kCLLocationAccuracyBest;
        
//        locationMan!.distanceFilter = kCLDistanceFilterNone
        locationMan!.distanceFilter = 2
        locationMan!.startUpdatingLocation()
        locationMan!.pausesLocationUpdatesAutomatically=true
        locationMan!.disallowDeferredLocationUpdates()
        locationMan!.activityType = .AutomotiveNavigation
        

            if #available(iOS 9.0, *) {
                locationMan?.allowsBackgroundLocationUpdates=true
            } else {
                // Fallback on earlier versions
            }
        
        
        
        
    }
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "location" {
            let po = (mapV.locationDisplay.mapLocation())
            self.curLoc = EQLocation(po:po)
        }
    }
    
    func startUploadLoc(){
        let lon=self.curLoc?.longitude,lat = self.curLoc?.latitude
        let path = "\(iConst.submitLocation)?token=\(UserInfo.me.token ?? "")&currDate=\(iConst.TIMESDF2.stringFromDate(NSDate()))&lon=\(lon)&lat=\(lat)"
        NetUtil.commonNoProgRequest(true, path: path, para: nil) { (dict, idx) in
            iCommonLog(dict.description+"--------------------")
        }
   
    }
    
    func initNShowBottomPop(mappoint:AGSPoint){
        let bp = PeripheralBottomPop(frame: CGRectMake(0, 0, 0, 120))
        bp.btnClickCb = {
            (sender) in
            let vc = DeathTheaticSearchVC()
            vc.po = mappoint
            self.presentViewController(MainNavVC(rootViewController: vc), animated: true, completion: nil)
        }
        
        bp.onDismiss = {
            (pop) in
            self.poiLayer?.removeAllGraphics()
        }
        bp.show()
    }
    
    func  addDeathThematicLayer(tuple:(String,AGSPictureMarkerSymbol))->AGSLayer?{
        let path = tuple.0.strByAp2Doc()
        //        path = "fjs1.geodatabase".strByAp2Doc()
        
        if iFm.fileExistsAtPath(path){
            
            let db = try! AGSGDBGeodatabase(path: path)
            let tb = db.featureTables()[0] as! AGSGDBFeatureTable
            let lyr=AGSFeatureTableLayer(featureTable: tb)
            lyr.renderer = AGSSimpleRenderer(symbol: tuple.1)
            mapV.addMapLayer(lyr)
            
            return lyr
        }
        return nil
        
    }
    func getShapefileInfo(str:String)->(String,AGSPictureMarkerSymbol){
        let idx = MapMod.controlflows.indexOf(str) ?? 0
        return (MapMod.shapefiles[idx],MapMod.shapeSymbol[idx])
    }
    
    
    func loadWmsAt(pos:Int,title:String){
        let imgs:[String]=StaticMod.wmslayersampleimgs
        wmssample.hidden=true
        if self.selLayerIdx != -1{
            self.mapV.removeMapLayer(self.wmsLyr)
        }
        self.selLayerIdx = self.selLayerIdx ==  pos ? -1 : pos
        if self.selLayerIdx == -1{
            return
        }
        guard let info = EQInfo.getIns() else{
            iPop.toast("当前没有可展示的分布图")
            self.selLayerIdx = -1
            return
        }
        if !info.isHasLayer(){
            iPop.toast("当前没有可展示的分布图")
            self.selLayerIdx = -1
            return
        }
        
        
        wmsLyr = AGSWMSLayer(URL: iUrl("http://\(NetUtil.serverIPWithoutPort()):20081/geoserver/fjseism/wms"))
        wmsLyr?.opacity = 0.5
        wmsLyr?.imageFormat = AGSImageFormat.PNG
        
        wmssample.hidden=false
        wmssample.setTitle(title, forState: .Normal)
        wmssample.setImage(iimg(imgs[pos]), forState: .Normal)
        
        let str=String(format: "ha%02d_\(info.obsTime)", pos+1)
        wmsLyr?.visibleLayers = [str]
        mapV.addMapLayer(wmsLyr)
        
    }
    
    func onSearch(sender:UIView){
        
        if empty(searchTf.text){
            iPop.toast("请输入关键字")
        }else{
            self.view.endEditing(true)
            poiLayer?.removeAllGraphics()
            mapV.callout.dismiss()
            let searchtext=searchTf.text!
            let path = String(format: iConst.poiServiceUrl, searchtext)
            
            NetUtil.commonRequestPlainJson(true, path: path, para: nil, succode: [], cb: { (data) in
                if let dict = data as? [String:AnyObject] where  (dict["count"] as? Int ?? 0) > 0{
                    
                    if let ary = dict["result"] as? [AnyObject]{
                        self.initNShowSearchResult(ary)
                    }
                    
                    
                }else{
                    iPop.toast("未查询到任何数据")
                }
            })
            
        }
        
    }
    
    
    func initNShowSearchResult(datas:[AnyObject]){
        let lv = ComListAdap.comListAdapWith(datas,w: searchTf.w, tag: 0, cb: { (d, pos) in
            if let dict = d.datas![pos] as? [String:AnyObject]{
                let lon = dict["LNG"] as! Double
                let lat = dict["LAT"] as! Double
                let po = AGSPoint(x: lon, y: lat, spatialReference: GraphicUtil.sr)
                
                let g:AGSGraphic=GraphicUtil.createPictureMarkerSymbol(iimg("mark")!, attributes: dict, po: po)
                
                self.poiLayer?.removeAllGraphics()
                self.poiLayer?.addGraphic(g)
                self.mapV.zoomToScale(18035.741763839724, withCenterPoint: po, animated: true)
//                self.mapV.callout.showCalloutAtPoint(po, forGraphic: g, animated: true)
                self.mapV.callout.showCalloutAtPoint(po, forFeature: g, layer: self.poiLayer, animated: true)

            }
            
            
            }, getv: { (d, pos) -> UITableViewCell in
                let cell = d.tv.dequeueReusableCellWithIdentifier("celliden")  ?? UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "celliden")
                let dict = d.datas![pos] as! [String:AnyObject]
                
                cell.textLabel!.text = dict["NAME"] as? String
                
                return cell
        })
        lv.tv.separatorStyle = .SingleLine
        lv.dropdownYoffset=1
        lv.defH=50
        lv.show(basev:self.view,anchor:searchTf)
    }
}

extension MainVC:AGSMapViewLayerDelegate,AGSMapViewTouchDelegate,AGSCalloutDelegate{
    func mapViewDidLoad(mapView: AGSMapView!) {
        startLocating();
    }
    
    
    
    
    
    
    func mapView(mapView: AGSMapView!, shouldProcessClickAtPoint screen: CGPoint, mapPoint mappoint: AGSPoint!) -> Bool{
        return true
    }
    
    
    
    
    func mapView(mapView: AGSMapView!, didClickAtPoint screen: CGPoint, mapPoint mappoint: AGSPoint!, features: [NSObject : AnyObject]!){
        view.endEditing(true)
    }
    
    
    
    
    func mapView(mapView: AGSMapView!, didTapAndHoldAtPoint screen: CGPoint, mapPoint mappoint: AGSPoint!, features: [NSObject : AnyObject]!){
        poiLayer?.removeAllGraphics()
        poiLayer?.addGraphic(GraphicUtil.createPictureMarkerSymbol(iimg("mark")!, attributes: nil, po: mappoint))
        
        mapV.zoomToScale(mapV.mapScale, withCenterPoint: mappoint, animated: true)
        initNShowBottomPop(mappoint)
    }
    
    func callout(callout: AGSCallout!, willShowForFeature feature: AGSFeature!, layer: AGSLayer!, mapPoint: AGSPoint!) -> Bool {
        if feature.allAttributes().isEmpty{
            return false
        }
        print(feature.allAttributes())
        
        if layer == poiLayer{
            let lab = callout.customView as! UILabel
            lab.text="地名:\(feature.attributeAsStringForKey("NAME"))\n电话:\(feature.attributeAsStringForKey("TELEPHONE"))\n地址:\(feature.attributeAsStringForKey("ADDRESS"))"
            lab.sizeToFit()
        }else if layer.name == "hospital"{
            let lab = callout.customView as! UILabel
            lab.text="名称:\(feature.attributeAsStringForKey("name"))\n等级:\(feature.attributeAsStringForKey("grade"))\n主管单位:\(feature.attributeAsStringForKey("membership"))"
            lab.sizeToFit()
            
        }else if layer.name == "city_site"{
            let lab = callout.customView as! UILabel
            lab.text="名称:\(feature.attributeAsStringForKey("name"))\n等级:\(feature.attributeAsStringForKey("class"))"
            lab.sizeToFit()
        }else if layer.name == "school"{
            let lab = callout.customView as! UILabel
            lab.text="名称:\(feature.attributeAsStringForKey("unitname"))\n类别:\(feature.attributeAsStringForKey("note_"))"
            lab.sizeToFit()
        }
        return true
    }
    
    
}

extension  MainVC:CLLocationManagerDelegate{
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        let eventDate = location.timestamp
        let howRecent = eventDate.timeIntervalSinceNow
        
        
        if abs(howRecent) > 5.0 {
            return
        }
//        print("++++++++++++++++++++++++++++++++++")
        if let last = lastLoc{
            let latval = last.coordinate.latitude - location.coordinate.latitude
            let lonval = last.coordinate.longitude - location.coordinate.longitude
            let timeval = eventDate.timeIntervalSinceDate(last.timestamp)
            
            if (abs(latval) < 2E-5 && abs(lonval) < 2E-5) || abs(timeval)<10.0
            {
                return
            }
            
        }
        
        lastLoc=location
//       let str = String(format:"latitude %+.6f, longitude %+.6f\n",
//               location.coordinate.latitude,
//               location.coordinate.longitude);
//        print(str)
        startUploadLocBG()
        
    }
    
    func locationManagerDidPauseLocationUpdates(manager: CLLocationManager) {
        print("pause")
    }
    func locationManagerDidResumeLocationUpdates(manager: CLLocationManager) {
        print("resume")
    }
    
    
    func startUploadLocBG(){
        let po = convert2CurSR(self.lastLoc!)
        let lon=po.x,lat = po.y
        let path = "\(iConst.submitLocation)?token=\(UserInfo.me.token ?? "")&currDate=\(iConst.TIMESDF2.stringFromDate(NSDate()))&lon=\(lon)&lat=\(lat)"
        NetUtil.commonNoProgRequest(true, path: path, para: nil) { (dict, idx) in
//            iCommonLog(dict.description+"--------------------")
        }
        
       
        
    }
    
    func convert2CurSR(loc:CLLocation)->AGSPoint{
        let lon=loc.coordinate.longitude,lat = loc.coordinate.latitude
        let po = AGSPoint(x: lon, y: lat, spatialReference:AGSSpatialReference.wgs84SpatialReference())
        let po2 = AGSGeometryEngine.defaultGeometryEngine().projectGeometry(po, toSpatialReference: AGSSpatialReference(WKID: iConst.AGSKWID))
        return po2 as! AGSPoint
    }
}


class WMSSampleB:UIButton{
    var titleH:CGFloat =  28
    override func setImage(image: UIImage?, forState state: UIControlState) {
        super.setImage(image, forState: state)
        self.snp_updateConstraints { (make) in
            make.width.equalTo(image!.w)
            make.height.equalTo(image!.h+titleH)
        }
    }
    override func contentRectForBounds(bounds: CGRect) -> CGRect {
        return bounds
    }
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        return CGRectMake(0, titleH, contentRect.width, contentRect.height-titleH)
    }
    
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        return CGRectMake(0, 0, contentRect.width, titleH)
        
    }
    
    
}



