//
//  HMDiscoverTableViewController.swift
//  Weibo11
//
//  Created by itheima on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

class HMDiscoverTableViewController: HMVisitorTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 如果没有登录,就设置访客视图的内容
        if !userLogin {
            visitorView?.setVisitorInfo("visitordiscover_image_message", message: "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过")
            return
        }
        
        setupUI()
    }
    
    func setupUI(){
        // 初始化控件
        let searchView = HMDiscoverSearchView.searchView()
        searchView.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 35)
        // 设置成 title View
        navigationItem.titleView = searchView
        
        tabBarItem.badgeValue = "哈哈"
        
//        
//        // 现在能够直接拿到是 tabBar
//        
//        for tabBarChild in self.tabBarController!.tabBar.subviews {
//            // 如果是　tabBarButton
//            if tabBarChild.isKindOfClass(NSClassFromString("UITabBarButton")!) {
//                // 继续往下找
//                for tabBarButtonChild in tabBarChild.subviews {
//                    if tabBarButtonChild.isKindOfClass(NSClassFromString("_UIBadgeView")!) {
//                        for badgeViewChild in tabBarButtonChild.subviews {
//                            if badgeViewChild.isKindOfClass(NSClassFromString("_UIBadgeBackground")!) {
//                                printLog("终于等于你,还好没放弃\(badgeViewChild)")
//                                
//                                // 用于记录获取回来的成员变量是有多少个
//                                var count: UInt32 = 0
//                                // 通过运行时候,获取其身上的属性或者成员变量
//                                // 参数1:传入 class,参数2: 传入一个指针,记录个数
//                                let ivars = class_copyIvarList(NSClassFromString("_UIBadgeBackground")!, &count)
//                                
//                                // 遍历成员变量的列表
//                                for i in 0..<count {
//                                    // 取到对应位置的值
//                                    let ivar = ivars[Int(i)]
//                                    // 获取其名字
//                                    let name = ivar_getName(ivar)
//                                    let type = ivar_getTypeEncoding(ivar)
//                                    // 转 NSString
//                                    let nameString = NSString(CString: name, encoding: NSUTF8StringEncoding)
//                                    let typeString = NSString(CString: type, encoding: NSUTF8StringEncoding)
//                                    printLog("\(nameString)====\(typeString)")
//                                    // 判断其对应属性, 通过 kvc 赋值其值
//                                    if nameString!.isEqualToString("_image"){
//                                        badgeViewChild.setValue(UIImage(named: "main_badge"), forKey: (nameString as! String))
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        
//        tabBarItem.badgeValue = nil
//        // 因为在设置完成之后就需要去遍历一下,所以可以抽取到 badgeValue 的 didSet 方法里面去
//        tabBarItem.badgeValue = "哈哈"
        
        
        
    }

}