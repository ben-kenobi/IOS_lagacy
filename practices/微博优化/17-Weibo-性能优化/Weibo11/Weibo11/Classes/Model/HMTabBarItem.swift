//
//  HMTabBarItem.swift
//  Weibo11
//
//  Created by itheima on 15/12/12.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

class HMTabBarItem: UITabBarItem {
    
    override var badgeValue: String? {
        didSet{
            printLog("设置badgeValue了")
//             遍历子控件,设置背景
            
            if badgeValue == nil {
                return
            }
            
            // window 的 rootViewcontroller --> 是可以
            let controller = valueForKeyPath("_target") as! UITabBarController
            
            for tabBarChild in controller.tabBar.subviews {
                // 如果是　tabBarButton
                if tabBarChild.isKindOfClass(NSClassFromString("UITabBarButton")!) {
                    // 继续往下找
                    for tabBarButtonChild in tabBarChild.subviews {
                        if tabBarButtonChild.isKindOfClass(NSClassFromString("_UIBadgeView")!) {
                            for badgeViewChild in tabBarButtonChild.subviews {
                                if badgeViewChild.isKindOfClass(NSClassFromString("_UIBadgeBackground")!) {
                                    printLog("终于等于你,还好没放弃\(badgeViewChild)")
                                    // badgeViewChild.setValue(UIImage(named: "main_badge"), forKey: "_image")
    
                                    // 用于记录获取回来的成员变量是有多少个
                                    var count: UInt32 = 0
                                    // 通过运行时候,获取其身上的属性或者成员变量
                                    // 参数1:传入 class,参数2: 传入一个指针,记录个数
                                    let ivars = class_copyIvarList(NSClassFromString("_UIBadgeBackground")!, &count)
    
                                    // 遍历成员变量的列表
                                    for i in 0..<count {
                                        // 取到对应位置的值
                                        let ivar = ivars[Int(i)]
                                        // 获取其名字
                                        let name = ivar_getName(ivar)
                                        let type = ivar_getTypeEncoding(ivar)
                                        // 转 NSString
                                        let nameString = NSString(CString: name, encoding: NSUTF8StringEncoding)
                                        let typeString = NSString(CString: type, encoding: NSUTF8StringEncoding)
                                        printLog("\(nameString)====\(typeString)")
                                        // 判断其对应属性, 通过 kvc 赋值其值
                                        if nameString!.isEqualToString("_image"){
                                            badgeViewChild.setValue(UIImage(named: "main_badge"), forKey: (nameString as! String))
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
