//
//  HMNavigationController.swift
//  Weibo11
//
//  Created by itheima on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

class HMNavigationController: UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.interactivePopGestureRecognizer?.delegate = self
        // bug: 如果在根控制器按住边缘向右滑,再次 push 新控制器的话,push 失败
        // Do any additional setup after loading the view.
    }

    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        // 更改左上角的返回按钮
        
        
        // 如果当前导航控制器里面有1个子控制器,那么执行到这个地方的时候,就代表
        // 将要push进来第2个,把 push 进来 的控制器的左边按钮改成第一个控制器的title
        
        // 判断内部如果已经存在过控制器,才执行逻辑
        if childViewControllers.count != 0 {
            var title: String = "返回"
            
            // 如果当前导航控制器里面有1个子控制器,那么做特殊处理
            if childViewControllers.count == 1 {
                // push 第2个
                title = childViewControllers.first!.title ?? title
            }
            
            // 判断如果当前push进来的是rootviewcontroller,就不设置
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(imgName: "navigationbar_back_withtext", title: title, target: self, action: "back")
            
            // 隐藏底部 tabbar
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
        
    }
    
    
    @objc private func back(){
        popViewControllerAnimated(true)
    }
    
    
    // MARK: - ges delegate
    
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        printLog("哈哈")
        // 判断,如果是根控制器,就不要识别这个手势
//        if childViewControllers.count == 1 {
//            return false
//        }
//        return true
        
        return childViewControllers.count != 1
    }
}
