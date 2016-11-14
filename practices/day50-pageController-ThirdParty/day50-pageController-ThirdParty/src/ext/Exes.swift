

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
let iLoop = NSRunLoop.mainRunLoop()
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


func iCommonLog2(desc:AnyObject,file:String=__FILE__,line:Int=__LINE__,fun:String=__FUNCTION__) {
    iPrint(String(format: "file：%@    line：%d    function：%@     desc：\(desc)",file,line,fun))
}
func iCommonLog(desc:AnyObject,file:String=__FILE__,line:Int=__LINE__){
    iPrint(String(format:"class:%@   line:%d   desc:\(desc)",file.componentsSeparatedByString("/").last ?? "",__LINE__))
}

func iPrint(items: Any...){
    #if DEBUG
        print(items)
    #endif
}

func idelay(sec:NSTimeInterval,asy:Bool,cb:(()->())){
    dispatch_after(dispatch_time(0, Int64(sec * 1e9)),asy ? dispatch_get_global_queue(0, 0):dispatch_get_main_queue(),cb)
}



func iRes(res:String,bundle:NSBundle=NSBundle.mainBundle())->String?{
    return bundle.pathForResource(res, ofType: nil)
}
func iBundle(iden:String)->NSBundle?{
    
    if let path = iRes(iden){

        return NSBundle(path: path )
    }
    return nil
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

func iUrl(str:String?)->NSURL?{
    guard let url=str else{
        return nil
    }
    return NSURL(string: url)
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

func iData(name:String?)->NSData?{
    
    guard let url=iUrl(name) else{
        return nil
    }
    return  NSData(contentsOfURL:url)
}

func iData4F(name:String?)->NSData?{
    guard let name=name else{
        return nil
    }
    return NSData(contentsOfFile:name)
}

func imgFromData(name:String?)->UIImage?{
    guard let data=iData(name) else{
        return nil
    }
    return   UIImage(data: data)
}


func  imgFromData4F(name:String?)->UIImage? {
    guard let data=iData4F(name) else{
        return nil
    }
    return UIImage(data: data)
}


func imgFromF(name:String?)->UIImage?{
    guard let name=name else{
        return nil
    }
    return UIImage(contentsOfFile: name)
}
func iimg(name:String?)->UIImage?{
    guard let name=name else{
        return nil
    }
    return UIImage(named: name)
}



func iRes4Ary(path:String,bundle:NSBundle=NSBundle.mainBundle())->[AnyObject]{
    return   NSArray(contentsOfFile: iRes(path,bundle: bundle)!) as! [AnyObject]
}

func iRes4Dic(path:String,bundle:NSBundle=NSBundle.mainBundle())->[String:AnyObject]{
    return NSDictionary(contentsOfFile: iRes(path,bundle: bundle)!) as! Dictionary
}
func iVCFromStr(name:String)->UIViewController?{
    if let type = NSClassFromString(name) as? UIViewController.Type{
        return type.init()
    }
    return nil
}

func iTimer(inteval:NSTimeInterval,tar:AnyObject,sel:Selector)->NSTimer{
    let timer = NSTimer(timeInterval: inteval, target: tar, selector: sel, userInfo: nil, repeats: true)
    iLoop.addTimer(timer, forMode: NSRunLoopCommonModes)
    return timer
}
func iDisLin(tar:AnyObject,sel:Selector)->CADisplayLink{
    let dislin = CADisplayLink(target: tar, selector: sel)
    dislin.addToRunLoop(iLoop, forMode: NSRunLoopCommonModes)
    return dislin
}




extension UIView{
    
    var x:CGFloat{
        get{
            return frame.origin.x
        }
        set{
            frame.origin.x=newValue
        }
    }
    
    var y:CGFloat{
        get{
            return frame.origin.y
        }
        set{
            frame.origin.y=newValue
        }
    }

    var r:CGFloat{
        get{
            return frame.origin.x+frame.width
        }
        set{
            frame.origin.x=newValue-frame.width
        }
    }

    var b:CGFloat{
        get{
            return frame.origin.y+frame.height
        }
        set{
             frame.origin.y=newValue-frame.height
        }
    }

    
    var x2:CGFloat{
        get{
            return x
        }
        set{
            frame.size.width += frame.origin.x-newValue
            frame.origin.x=newValue
        }
    }
    
    var y2:CGFloat{
        get{
            return y
        }
        set{
            frame.size.height += frame.origin.y-newValue
            frame.origin.y=newValue
        }
    }
  
    var r2:CGFloat{
        get{
            return r
        }
        set{
            frame.size.width=newValue-frame.origin.x
        }
    }
    
    var b2:CGFloat{
        get{
            return b
        }
        set{
            frame.size.height=newValue-frame.origin.y
        }
    }
    
  
    var w:CGFloat{
        get{
            return frame.width
        }
        set{
            frame.size.width=newValue
        }
    }
    
    var h:CGFloat{
        get{
            return frame.height
        }
        set{
            frame.size.height=newValue
        }
    }
    
    
    
    var cx:CGFloat{
        get{
            return center.x
        }
        set{
            center.x=newValue
        }
    }
  
   
    var cy:CGFloat{
        get{
            return center.y
        }
        set{
          center.y=newValue
        }
    }
    
    
    
    
    var ic:CGPoint{
        return CGPoint(x: w * 0.5, y: h * 0.5)
    }
    
    var icx:CGFloat{
        return w*0.5
    }
    var icy:CGFloat{
        return h*0.5
    }
    
    var size:CGSize{
        get{
            return frame.size
        }
        set{
            frame.size=newValue
        }
    }
    
    
    var ori:CGPoint{
        get{
            return frame.origin
        }
        set{
           frame.origin=newValue
        }
    }
    
    
}

extension CALayer{
    var x:CGFloat{
        get{
            return frame.origin.x
        }
        set{
            frame.origin.x=newValue
        }
    }
    
    var y:CGFloat{
        get{
            return frame.origin.y
        }
        set{
            frame.origin.y=newValue
        }
    }
    
    var r:CGFloat{
        get{
            return frame.origin.x+frame.width
        }
        set{
            frame.origin.x=newValue-frame.width
        }
    }
    
    var b:CGFloat{
        get{
            return frame.origin.y+frame.height
        }
        set{
            frame.origin.y=newValue-frame.height
        }
    }
    
    
    var x2:CGFloat{
        get{
            return x
        }
        set{
            frame.size.width += frame.origin.x-newValue
            frame.origin.x=newValue
        }
    }
    
    var y2:CGFloat{
        get{
            return y
        }
        set{
            frame.size.height += frame.origin.y-newValue
            frame.origin.y=newValue
        }
    }
    
    var r2:CGFloat{
        get{
            return r
        }
        set{
            frame.size.width=newValue-frame.origin.x
        }
    }
    
    var b2:CGFloat{
        get{
            return b
        }
        set{
            frame.size.height=newValue-frame.origin.y
        }
    }
    
    
    var w:CGFloat{
        get{
            return frame.width
        }
        set{
            frame.size.width=newValue
        }
    }
    
    var h:CGFloat{
        get{
            return frame.height
        }
        set{
            frame.size.height=newValue
        }
    }
    
    
    
    var cx:CGFloat{
        get{
            return position.x
        }
        set{
            position.x=newValue
        }
    }
    
    
    var cy:CGFloat{
        get{
            return position.y
        }
        set{
            position.y=newValue
        }
    }
    
    
    
    
    var ic:CGPoint{
        return CGPoint(x: w * 0.5, y: h * 0.5)
    }
    
    var icx:CGFloat{
        return w*0.5
    }
    var icy:CGFloat{
        return h*0.5
    }
    
    var size:CGSize{
        get{
            return frame.size
        }
        set{
            frame.size=newValue
        }
    }
    
    
    var ori:CGPoint{
        get{
            return frame.origin
        }
        set{
            frame.origin=newValue
        }
    }
}



extension String{
    var len:Int{
        return characters.count
    }
    func strByAp2Cache()->String{
        return iFileUtil.cachePath().stringByAppendingString("/\(self)")
    }
    func strByAp2Doc()->String{
        return iFileUtil.docPath().stringByAppendingString("/\(self)")
    }
    func strByAp2Temp()->String{
        return iFileUtil.tempPath().stringByAppendingString("/\(self)")
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







