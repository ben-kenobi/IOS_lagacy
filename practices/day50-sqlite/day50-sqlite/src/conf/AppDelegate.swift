//
//  AppDelegate.swift
//  day-43-microblog
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit


let updateRootVCNoti="updateRootVCNoti"
let versionKey="CFBundleShortVersionString"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window=UIWindow(frame: UIScreen.mainScreen().bounds)
        setRootVC()
        window!.makeKeyAndVisible()
        window?.backgroundColor=UIColor.whiteColor()
        
        iNotiCenter.addObserver(self, selector: "setRootVC", name: updateRootVCNoti, object: nil)
        return true
    }

    func setRootVC(){
        guard let win = window else{
            return
        }
        
        var img:UIImage?
        if let vc=win.rootViewController{
            img=UIImage.imgFromLayer(vc.view.layer)
        }
        let dict = iRes4Dic("conf.plist") as! [String:String]
        if newVersion(){
            win.rootViewController=iVCFromStr(dict["namespace"]! + "." + dict["introVC"]!)
            saveVersion(curVersion())
            
        }else if !UserInfo.hasWelcomed(){
            win.rootViewController=iVCFromStr(dict["namespace"]! + "." + dict["welcomeVC"]!)
            UserInfo.welcomed(true)
        }else   {
            win.rootViewController=iVCFromStr(dict["namespace"]! + "." + dict["rootVC"]!)
        }
        
        if let img=img {
            let iv:UIImageView=UIImageView(image: img)
            win.addSubview(iv)
            UIView.animateWithDuration(1, animations: { () -> Void in
                iv.alpha=0.1
                iv.transform=CGAffineTransformMakeScale(2, 2)
                }, completion: { (b) -> Void in
                    iv.removeFromSuperview()
            })
        }
        
    }
    
   
    
    
    
    
    deinit{
        iNotiCenter.removeObserver(self)
    }
    
    
    
    
    func newVersion()->Bool{
        
        return curVersion().compare(savedVersion() ?? "")==NSComparisonResult.OrderedDescending
        
    }
    
    
    func curVersion()->String{
        return iBundle.infoDictionary![versionKey] as! String
    }
    
    func savedVersion()->String?{
        return iPref(nil)?.stringForKey(versionKey)
    }
    
    func saveVersion(ver:String){
        iPref(nil)?.setObject(ver, forKey: versionKey)
        iPref(nil)?.synchronize()
    }
    
    
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

