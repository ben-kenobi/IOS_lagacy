//
//  AppDelegate.swift
//  01-SQLite体验
//
//  Created by 刘凡 on 15/10/29.
//  Copyright © 2015年 joyios. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        SQLiteManager.sharedManager.openDB("my.db")
        
        return true
    }
}

