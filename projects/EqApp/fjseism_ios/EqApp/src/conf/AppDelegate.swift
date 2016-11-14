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
let versionKey2 = "CFBundleVersion"

func updateRVC(){
    iNotiCenter.postNotificationName(updateRootVCNoti, object: nil, userInfo: nil)
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var accessKey:String?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window=UIWindow(frame: UIScreen.mainScreen().bounds)
        setRootVC()
        window!.makeKeyAndVisible()
        iApp.statusBarHidden=false
        window?.backgroundColor=UIColor.whiteColor()
        
        iNotiCenter.addObserver(self, selector: #selector(AppDelegate.setRootVC), name: updateRootVCNoti, object: nil)
        
        
        // -----JPUSH------------------begin----//
        JPUSHService.registerForRemoteNotificationTypes(UIUserNotificationType.Badge.rawValue|UIUserNotificationType.Sound.rawValue|UIUserNotificationType.Alert.rawValue, categories: nil)
        
        JPUSHService.setupWithOption(launchOptions, appKey: "064a6f3285b53f7b34b808b4", channel: "Publish channel", apsForProduction: false, advertisingIdentifier: nil)
        
        JPUSHService.registrationIDCompletionHandler { (code, rid) in
            if code == 0 {
                print("registrationID获取成功：\(rid)")
            }else{
                print("registrationID获取失败，code:\(code)")
            }
        }
    

        // -----JPUSH--------------------end--//

//        let path = "consoleLog.txt".strByAp2Doc()
//        let cstr=path.cStringUsingEncoding(4)!
//        let type = "a+".cStringUsingEncoding(1)!
//        freopen(cstr,type , stderr)
        
        
        return true
    }
    
    
    func setRootVC(){
        
        UITabBar.appearance().translucent=false
        UINavigationBar.appearance().translucent=false
        UINavigationBar.appearance().titleTextAttributes=[NSFontAttributeName:ibFont(19),NSForegroundColorAttributeName:UIColor.orangeColor()]
        //        UINavigationBar.appearance().tintColor=iGlobalGreen
        //        UINavigationBar.appearance().setBackgroundImage(iimg("login_bg"), forBarMetrics: UIBarMetrics.Default)
        
        
        
        
        
        guard let win = window else{
            return
        }
        
        var img:UIImage?
        if let vc=win.rootViewController{
            img=UIImage.imgFromLayer(vc.view.layer)
        }
        let dict = iRes4Dic("conf.plist") as! [String:String]
        if newVersion(){
            win.rootViewController=iVCFromStr( dict["introVC"]!)
            saveVersion(curVersion())
            
        }else if !UserInfo.isLogin(){
            win.rootViewController=iVCFromStr( dict["loginVC"]!)
        }else if !UserInfo.hasWelcomed(){
            win.rootViewController=iVCFromStr(dict["welcomeVC"]!)
            UserInfo.welcomed(true)
        }else   {
            win.rootViewController=iVCFromStr( dict["rootVC"]!)
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
        
        
        
        if UserInfo.isLogin(){
            
        }else{
            
        }
    }
    
    
    
        
    
    deinit{
        iNotiCenter.removeObserver(self)
    }
    
    
    
    
    func newVersion()->Bool{
        return false
       // return curVersion().compare(savedVersion() ?? "")==NSComparisonResult.OrderedDescending
        
    }
    
    
    func curVersion()->String{
        return iInfoDict[versionKey] as! String
    }
    
    func savedVersion()->String?{
        return iPref(nil)?.stringForKey(versionKey)
    }
    
    func saveVersion(ver:String){
        iPref(nil)?.setObject(ver, forKey: versionKey)
        iPref(nil)?.synchronize()
    }
    
    class func iversion()->Int{
        return iInfoDict[versionKey2]!.integerValue
    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        application.applicationIconBadgeNumber=0
        
        
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        application.applicationIconBadgeNumber=0
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    

    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        JPUSHService.registerDeviceToken(deviceToken)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        print(AppDelegate.logDic(userInfo))
        JPUSHService.handleRemoteNotification(userInfo)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        if application.applicationState == .Active{
           
        }
        JPUSHService.handleRemoteNotification(userInfo)
      
        completionHandler(UIBackgroundFetchResult.NewData)
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("didFailToRegisterForRemoteNotificationsWithError  \(error)")
    }
    
    
  
    
    class func logDic(dict:[NSObject:AnyObject])->String{
        if dict.count <= 0{
            return "nil"
        }
        let temp1 = dict.description.stringByReplacingOccurrencesOfString("\\u", withString: "\\U")
        let temp2=temp1.stringByReplacingOccurrencesOfString("\"", withString: "\\\"")
        let temp3 = "\"\(temp2)\""
        
        let data = temp3.dataUsingEncoding(4)
        let str = NSPropertyListSerialization.propertyListFromData(data!, mutabilityOption: NSPropertyListMutabilityOptions.Immutable, format: nil, errorDescription: nil)!.description
        return str
    }
    
  
}

