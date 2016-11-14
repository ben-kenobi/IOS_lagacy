//
//  MainVC.swift
//  EqApp
//
//  Created by apple on 16/8/26.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
import MapKit
import ArcGIS
import MobileCoreServices

let instructionBadgeKey:String="instructionbadgeKey"

class MainVC: BaseVC {
    static var flag:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        iNotiCenter.addObserver(self, selector: #selector(self.didReceiveMsg(_:)), name: kJPFNetworkDidReceiveMessageNotification, object: nil)
        (btns[3] as! ImgPaddingBtn).badgeCount = Int(PrefUtil.getByUser(instructionBadgeKey, defau: "0"))!
    }
    
  
    deinit{
        iNotiCenter.removeObserver(self)
        timer?.invalidate()
        timer = nil
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        UserInfo.logout()
    }
    
    lazy var btns:[UIButton] = [UIButton]()
    lazy var  userInfo:UIButton = {
        let b = ImgPaddingBtn(frame: nil, img: iimg("user_manage"),  bgimg: iimg(iColor(0x00000000)), hlbgimg: iimg(iColor(0xaadddddd)),tar:self,action:#selector(self.onClick(_:)))
        b.pad=8
        return b
    }()
    lazy var  setting:UIButton = {
        let b =  ImgPaddingBtn(frame: nil, img: iimg("nav"),  bgimg: iimg(iColor(0x00000000)), hlbgimg: iimg(iColor(0xaadddddd)),tar:self,action:#selector(self.onClick(_:)))
        b.pad=8
        return b
    }()
    lazy var  search:UIButton = {
        let b  = ImgPaddingBtn(frame: nil, img: iimg("search"),  bgimg: iimg(iColor(0x00000000)), hlbgimg: iimg(iColor(0xaadddddd)),tar:self,action:#selector(self.onClick(_:)))
        b.pad=8
        return b
    }()
    let searchTf = ClearableTF()
    var controlflowPop:ControlflowPop?
    var selLayerIdx:Int = -1
    var wmsLyr:AGSWMSLayer?
    lazy var wmssample:WMSSampleB = {
        let ws=WMSSampleB(frame: nil, bg: iColor(0xffeeeeee), corner: 5, bordercolor: iColor(0xff000000), borderW: 1)
        ws.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        ws.titleLabel?.font=ibFont(13)
        ws.titleLabel?.textAlignment = .Center
        ws.alpha = 0.7
        self.view.addSubview(ws)
        ws.snp_makeConstraints(closure: { (make) in
            make.right.equalTo(-12)
            make.bottom.equalTo(-12)
        })
        return ws
    }()

    var mLocationChooserPop:LocationChooserPop?
    var curLoc:EQLocation? = EQLocation(latitude: 29, longitude: 129, type: "manualprovider")
    lazy var mapV:AGSMapView={
        return AGSMapView(frame: CGRectMake(0, 0, iScrW, iScrH), bg: iConst.iGlobalBG)
    }()
    var lDisplayManager:AGSLocationDisplay?
    var poiLayer:AGSGraphicsLayer?
    var earthquakeLayer:AGSGraphicsLayer?

    var layerMap:[String:AGSLayer] = [:]
    var timer:NSTimer?
    var locationMan:CLLocationManager?
    var lastLoc:CLLocation?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if MainVC.flag == 1{
            let vc = PendingSubmissionVC()
            self.presentViewController(MainNavVC(rootViewController: vc), animated: true, completion: nil)
            MainVC.flag = 0
        }
    }
}


extension MainVC{
    func initUI(){
        print("============"+NSHomeDirectory()+"=============")
        initMap()
        
        let h:CGFloat = 44
        let v = UIView(frame: CGRectMake(18, 22+iStBH, iScrW-36, h), bg: iColor(0xffffffff), corner: 5, bordercolor: iColor(0x88cccccc), borderW: 0.5)
        view.addSubview(v)
        
        userInfo.frame=CGRectMake(0, 0, h, h)
        setting.frame=CGRectMake(v.w-h, 0, h, h)
        search.frame=CGRectMake(v.w-h*2, 0, h, h)
        searchTf.frame=CGRectMake(h, 0, v.w-h*3, h)
        v.addSubview(userInfo)
        v.addSubview(setting)
        v.addSubview(search)
        v.addSubview(searchTf)
        let linepad:CGFloat = 5
        v.addSubview(UIView(frame: CGRectMake(h, linepad, 1, h-linepad*2), bg: iColor(0xffbbbbbb)))
        v.addSubview(UIView(frame: CGRectMake(v.w-h-1, linepad, 1, h-linepad*2), bg: iColor(0xffbbbbbb)))
        
        
        
        let imgary = ["info","cam","controlflow","message","distribution"]
        let w:CGFloat = 36,bx:CGFloat=iScrW-w-18.0,by:CGFloat=v.b+18
        for (idx,str) in imgary.enumerate(){
            btns.append(newbtn(CGRectMake(bx, by+(CGFloat(idx)*(w+2)), w, w),img: iimg(str)!))
        }
        btns.append(newbtn(CGRectMake(18,iScrH-w-18.0,w,w),img: iimg("locationing")!))
        
        
        
    }
    
    
   
    func newbtn(frame:CGRect,img:UIImage)->UIButton{
        let btn  = ImgPaddingBtn(frame: frame, img: img,  bgimg: iimg(iColor(0xbbffffff)), hlbgimg: iimg(iColor(0xaadddddd)),  corner: 3, bordercolor: iColor(0xaabbbbbb), borderW: 0.5, tar: self, action: #selector(self.onClick(_:)), tag: 0)
        view.addSubview(btn)
        return btn
    }
    
    func onClick(sender:View){
        view.endEditing(true)
        if sender == userInfo{
            let vc = MainNavVC(rootViewController: UserInfoVC())
            presentViewController(vc, animated: true, completion: nil)
        }else if sender == search{
            onSearch(sender)
        }else if sender == setting{
            initNshowGroupOption(sender)
        }else if (sender == btns[4]){
            showEarthquakeDistributionPop(sender)
        }else if sender == btns[0]{
            showEarthquakePop(sender)
        }else if sender == btns[2]{
            showControlflowPop(sender)
        }else if sender == btns[5]{
            
            if(curLoc==nil||"manualprovider"==(curLoc?.type)){
                let uc = UIAlertController(title: "提示", message: "定位失败，是否手动选择位置", preferredStyle: UIAlertControllerStyle.Alert)
                uc.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil))
                uc.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: { (ua) in
                    self.initNshowLocationChooser(sender)
                    
                }))
                presentViewController(uc, animated: true, completion: nil)
                return ;
            }
            if let ld = lDisplayManager where ld.dataSourceStarted{
                if ld.autoPanMode == .Default{
                    ld.autoPanMode = .CompassNavigation
                }else{
                    ld.autoPanMode = .Default
                    mapV.rotationAngle = 0
                }
            }
            
            
        }else if sender == btns[1]{
            if let cl = curLoc{
                let vc = EditSceneVC()
                vc.flag=1
                presentViewController(MainNavVC(rootViewController: vc), animated: true, completion: nil)
                
                let ts =  Tscene()
                ts.loc_lat = (cl.latitude) ?? 0
                ts.loc_lon = cl.longitude ?? 0
                vc.curscene=ts
                
                
                return
            }
            iPop.toast("未定位到当前位置，无法进行采集")
            
        }else if sender == btns[3]{
            let vc = InstructionsListVC()
            presentViewController(MainNavVC(rootViewController: vc), animated: true, completion: nil)
            (sender as! ImgPaddingBtn).badgeCount=0
        }
    }
    
}


public struct EQLocation{
    public var latitude: CLLocationDegrees
    public var longitude: CLLocationDegrees
    public var type:String?
    public init(latitude: CLLocationDegrees, longitude: CLLocationDegrees,type:String?=nil){
        self.latitude=latitude
        self.longitude=longitude
        self.type=type
    }
    public init(po:AGSPoint){
        self.init(latitude:po.y,longitude: po.x)
    }
    func toAGSPo()->AGSPoint{
        return AGSPoint(x: longitude, y: latitude, spatialReference: AGSSpatialReference(WKID: iConst.AGSKWID))
    }
}

class ImgPaddingBtn:UIButton{
    lazy var badge:UILabel={
        let lab = UILabel(frame: CGRectMake(0, 0, 14, 14), txt: "", color: iColor(0xffffffff), font: iFont(12), align: NSTextAlignment.Center, line: 1, bgColor: iColor(0xffee4444))
        lab.layer.cornerRadius=7
        lab.layer.masksToBounds=true
        self.layer.masksToBounds=false
        self.addSubview(lab)
        lab.center=CGPointMake(self.w-4, 4)
        return lab
    }()
    var pad:CGFloat=5
    
    var badgeCount:Int = 0{
        didSet{
           badge.text="\(badgeCount)"
            badge.hidden=badgeCount==0
            PrefUtil.putByUser(instructionBadgeKey, value:"\(badgeCount)" )
        }
    }
    
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        return CGRectMake(pad, pad, contentRect.width-pad*2, contentRect.height-pad*2)
    }
  
}

