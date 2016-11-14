//
//  AppDelegate.swift
//  Weibo11
//
//  Created by itheima on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit
import AFNetworking

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var observer: NSObjectProtocol?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        SQLiteManager.sharedManager
//        let result = HMEmoticonTools.shareTools.allEmoticons
//        printLog(result)
        
        // AFN 设置网络指示器，但是 3.0.4 版本不好使！
        AFNetworkActivityIndicatorManager.sharedManager().enabled = true
        
        printLog(NSBundle.mainBundle())
        
        
        // 1. 初始化 window
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        
        // 2.更改背景颜色
        window?.rootViewController = HMUserAccountViewModel.sharedAccount.userLogon ? defatulRootViewController() : HMMainViewController()
        
        // 3.成为主窗口并显示
        window?.makeKeyAndVisible()
        
        observer = NSNotificationCenter.defaultCenter().addObserverForName(HMSwitchRootVCNotification, object: nil, queue: nil) {[weak self] (noti) -> Void in
            printLog("切换根控制器")
            if noti.object is HMOAuthViewController {
                self?.window?.rootViewController = HMWelcomeViewController()
            }else{
                self?.window?.rootViewController = HMMainViewController()
            }
        }
        return true
    }
    
    /// 应用程序退出到后台，清理数据缓存
    func applicationDidEnterBackground(application: UIApplication) {
        HMStatusDAL.clearDBCache()
    }
    
    /// 判断是否
    ///
    /// - returns: <#return value description#>
    private func defatulRootViewController() -> UIViewController {
        
        if hasNewVersion() {
            return HMNewfeatureViewController()
        }else {
            return HMWelcomeViewController()
        }
    }
    
    /// 是否有新版本
    ///
    /// - returns: true: 有,false 没有
    private func hasNewVersion() -> Bool {
        
        let versionKey = "versionKey"
        
        // 取出本地保存的版本号
        let localVersion = NSUserDefaults.standardUserDefaults().stringForKey(versionKey)
        
        // 取出当前 app 的版本号 
        let currentVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"]! as! String
        
        // 把当前版本号保存到本地
        NSUserDefaults.standardUserDefaults().setObject(currentVersion, forKey: versionKey)
        
        // currentVersion 比 local 大
        // "a" "b" --> 自然排序
        
        // 以后开发中比较版本号尽量使用字符串
        // app的版本号不要超过2个小数点 不能使用(1.1.1.1)
        // 比较的时候,尽是不要比较字符串是否一样.
        if let local = localVersion where  currentVersion.compare(local)  != NSComparisonResult.OrderedDescending{
            return false
        }
        
        printLog("\(localVersion),\(currentVersion)")
        // 进行对比
        return true
    }

    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(observer!)
    }
}

