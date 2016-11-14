//
//  HMMainViewController.swift
//  Weibo11
//
//  Created by itheima on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit
import SVProgressHUD

class HMMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBar = HMTabBar()
        
        tabBar.composeButtonClosure = { [weak self] in
            
            if !HMUserAccountViewModel.sharedAccount.userLogon {
                SVProgressHUD.showErrorWithStatus("请先登录")
                return
            }
            
            // 初始化 composeView 
            let composeView = HMComposeView()
            composeView.show(self)
        }
        setValue(tabBar, forKeyPath: "tabBar")
        // 不能直接对一个只读属性赋值
        //self.tabBar = HMTabBar()
        
        addChildViewController(HMHomeTableViewController(), imgName: "tabbar_home", title: "首页")
        addChildViewController(HMMessageTableViewController(), imgName: "tabbar_message_center", title: "消息")
        addChildViewController(HMDiscoverTableViewController(), imgName: "tabbar_discover", title: "发现")
        addChildViewController(HMProfileTableViewController(), imgName: "tabbar_profile", title: "我")
        
//        // 5秒之后销毁
//        self.performSelector("dismiss", withObject: nil, afterDelay: 5)
    }
    
    
    func dismiss(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // 添加子控制器
    func addChildViewController(childController: UIViewController, imgName: String, title: String) {
        
        childController.tabBarItem = HMTabBarItem()
        // 可以使用这种方式统一 tabBar 文字颜色
//        let tabbar = UITabBar.appearance()
//        tabbar.tintColor = UIColor.orangeColor()
        
        // 设置文字
//        childController.tabBarItem.title = title
//        childController.navigationItem.title = title
        childController.title = title
        
        
        // 设置图片
        childController.tabBarItem.image = UIImage(named: imgName)
        // 渲染图片以原样显示
        childController.tabBarItem.selectedImage = UIImage(named: "\(imgName)_selected")?.imageWithRenderingMode(.AlwaysOriginal)
        
        // 设置 tabbar title 颜色
        childController.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.orangeColor()], forState: .Selected)
        // 设置 tabbar title 字体大小
        // childController.tabBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFontOfSize(30)], forState: .Normal)
        
        // 把图标往下移
        // childController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        // 添加子控制器
        addChildViewController(HMNavigationController(rootViewController: childController))
    }
    
    deinit {
        printLog("债见!!!!!!")
    }
    

}
