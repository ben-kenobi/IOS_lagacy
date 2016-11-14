

//
//  Exes.swift
//  day42-swiftbeginning
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit






let iScr = UIScreen.mainScreen()
let iScrW = iScr.bounds.size.width
let iScrH = iScr.bounds.size.height
let iBundle = NSBundle.mainBundle()
let iApp = UIApplication.sharedApplication()
let iFm = NSFileManager.defaultManager()
let iScale=UIScreen.mainScreen().scale
let iNotiCenter = NSNotificationCenter.defaultCenter()

let iVersion = Float(UIDevice.currentDevice().systemVersion)

let iStBH:CGFloat = 20
let iNavH:CGFloat = 44
let iTopBarH:CGFloat = (iStBH+iNavH)
let iTabBarH:CGFloat = 49


let iBaseURL:String = "http://"
//let iBaseURL:String "http://"



func iCommonLog2(desc:String,file:String=__FILE__,line:Int=__LINE__,fun:String=__FUNCTION__) {
    iPrint(String(format: "file：%@    line：%d    function：%@     desc：%@",file,line,fun,desc))
}
func iCommonLog(desc:String,file:String=__FILE__,line:Int=__LINE__){
    iPrint(String(format:"class:%@   line:%d   desc:%@",file.componentsSeparatedByString("/").last ?? "",__LINE__,desc))
}

func iPrint(items: Any...){
    #if DEBUG
        print(items)
    #endif
}



func iRes(res:String)->String?{
    return NSBundle.mainBundle().pathForResource(res, ofType: nil)
}

func iPref(name:String?)->NSUserDefaults?{
    return NSUserDefaults(suiteName: name)
}


func iColor(r:Int,g:Int,b:Int,a:CGFloat=1)->UIColor{
    return UIColor(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: a)
}


let iGlobalBG = iColor(230,g: 230,b: 230)
let iGlobalGreen = iColor(33,g: 197,b: 180)

let iGlobalBlue = iColor(63,g:169,b:248)

 func irandColor()->UIColor{
    return iColor(random()%256, g: random()%256, b: random()%256)
}



func iFont(size:CGFloat)->UIFont{
    return UIFont.systemFontOfSize(size)
}

func ibFont(size:CGFloat)->UIFont{
    return UIFont.boldSystemFontOfSize(size)
}

func iUrl(str:String)->NSURL?{
    return NSURL(string: str)
}

func iReq(str:String)->NSURLRequest{
    if let url=iUrl(str){
        return NSURLRequest(URL: url)
    }
    return NSURLRequest()
}
func imReq(str:String)->NSMutableURLRequest{
    guard let url=iUrl(str) else{
        return NSMutableURLRequest()
    }
    return NSMutableURLRequest(URL: url)
}

func iData(name:String)->NSData?{
    guard let url=iUrl(name) else{
        return nil
    }
    return  NSData(contentsOfURL:url)
}

func iData4F(name:String)->NSData?{
    return NSData(contentsOfFile:name)
}

func imgFromData(name:String)->UIImage?{
    guard let data=iData(name) else{
        return nil
    }
    return   UIImage(data: data)
}


func  imgFromData4F(name:String)->UIImage? {
    guard let data=iData4F(name) else{
        return nil
    }
    return UIImage(data: data)
}


func imgFromF(name:String)->UIImage?{
    return UIImage(contentsOfFile: name)
}
func iimg(name:String)->UIImage?{
    return UIImage(named: name)
}







extension UIView{
    func x()->CGFloat{
        return frame.origin.x
    }
    func y()->CGFloat{
        return frame.origin.y
    }
    func r()->CGFloat{
        return frame.origin.x+frame.width
    }
    func b()->CGFloat{
        return frame.origin.y+frame.height
    }
    
    func x(x:CGFloat){
        frame.origin.x=x
    }
    func y(y:CGFloat){
        frame.origin.y=y
    }
    func r(r:CGFloat){
        frame.origin.x=r-frame.width
    }
    func b(b:CGFloat){
        frame.origin.y=b-frame.height
    }
    
    func x2(x:CGFloat){
        frame.size.width += frame.origin.x-x
        frame.origin.x=x
    }
    func y2(y:CGFloat){
        frame.size.height += frame.origin.y-y
        frame.origin.y=y
    }
    func r2(r:CGFloat){
        frame.size.width=r-frame.origin.x
    }
    func b2(b:CGFloat){
        frame.size.height=b-frame.origin.y
    }
    
    func w()->CGFloat{
        return frame.width
    }
    func h()->CGFloat{
        return frame.height
    }
    
    func w(w:CGFloat){
        frame.size.width=w
    }
    func h(h:CGFloat){
        frame.size.height=h
    }
    func cx()->CGFloat{
        return center.x
    }
    func cy()->CGFloat{
        return center.y
    }
    func cx(cx:CGFloat){
        center.x=cx
    }
    func cy(cy:CGFloat){
        center.y=cy
    }
    
    func ic()->CGPoint{
        return CGPoint(x: w() * 0.5, y: h() * 0.5)
    }
    
    func icx()->CGFloat{
        return w()*0.5
    }
    func icy()->CGFloat{
        return h()*0.5
    }
    
    func size()->CGSize{
        return frame.size
    }
    
    func size(size:CGSize){
        frame.size=size
    }
    
    func ori()->CGPoint{
        return frame.origin
    }
    
    func ori(ori:CGPoint){
        frame.origin=ori
    }
}





extension String{
    func len()->Int{
        return characters.count
    }
    func strByAp2Cache()->String{
        return FileUtil.cachePath().stringByAppendingString("/\(self)")
    }
    func strByAp2Doc()->String{
        return FileUtil.docPath().stringByAppendingString("/\(self)")
    }
    func strByAp2Temp()->String{
        return FileUtil.tempPath().stringByAppendingString("/\(self)")
    }
}



extension UIColor{
    
    class func randColor()->UIColor{
        return UIColor(red: randF(255.0), green: randF(255.0), blue: randF(255.0), alpha: 1)
    }
   class  func randF(base:CGFloat )->CGFloat{
        return CGFloat(random()%(Int(base)+1))/base
    }
   class  func rand(base:Int)->Int{
        return random()%(base+1)
    }
    
    
}




extension NSDate{
    
    @nonobjc static var dateFm:NSDateFormatter = {
        let fm=NSDateFormatter()
        fm.dateFormat = "yyyy-MM-dd"
        return fm
    }()
    


    @nonobjc static var timeFm:NSDateFormatter={
        let fm=NSDateFormatter()
        fm.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return fm
    }()
    
    @nonobjc static var timeFm2:NSDateFormatter={
        let fm=NSDateFormatter()
        fm.dateFormat = "yyyy-MM-dd HH:mm"
        return fm
    }()

    func dateFM()->String{
        return NSDate.dateFm.stringFromDate(self)
    }
    func timeFM()->String{
        return NSDate.timeFm.stringFromDate(self)
    }
    func timeFM2()->String{
        return NSDate.timeFm2.stringFromDate(self)
    }
    class func dateFromStr(str:String)->NSDate?{
        return NSDate.dateFm.dateFromString(str)
    }
    class func timeFromStr(str:String)->NSDate?{
        return NSDate.timeFm.dateFromString(str)
    }
    class func time2FromStr(str:String)->NSDate?{
        return NSDate.timeFm2.dateFromString(str)

    }
    
    class func timestamp() -> String{
        return String(format: "%f", NSDate().timeIntervalSince1970)

    }
    
    
}




