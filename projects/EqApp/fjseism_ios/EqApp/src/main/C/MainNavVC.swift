

//
//  MainNavVC.swift
//  day-43-microblog
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class MainNavVC: UINavigationController,UIGestureRecognizerDelegate {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate=self
        navigationBar.setBackgroundImage(iimg(iConst.iGlobalBG), forBarMetrics: UIBarMetrics.Default)
        
    }
    
    
    
    override func pushViewController(viewController: UIViewController, animated: Bool){
        if viewController.dynamicType.description() == "QLPreviewController" {
            super.pushViewController(viewController, animated: animated)
            return
        }
        if viewController.navigationItem.leftBarButtonItem?.accessibilityElementCount() > 0{
            super.pushViewController(viewController, animated: animated)
            return
        }
        if(childViewControllers.count>1){
            viewController.navigationItem.leftBarButtonItem=UIBarButtonItem(img:UIImage(named: "back_pressed"),hlimg:UIImage(named: "back_nopress"), title: ""
                , tar: self, action: #selector(MainNavVC.back))
            viewController.hidesBottomBarWhenPushed=true
        }else if(childViewControllers.count==1){
            viewController.navigationItem.leftBarButtonItem=UIBarButtonItem(img:UIImage(named: "back_pressed"),hlimg:UIImage(named: "back_nopress"), title: homeTitle()
                , tar: self, action: #selector(MainNavVC.back))
            viewController.hidesBottomBarWhenPushed=true
        }else if(childViewControllers.count==0){
            viewController.navigationItem.leftBarButtonItem=UIBarButtonItem(img:UIImage(named: "back_pressed"),hlimg:UIImage(named: "back_nopress"), title: ""
                , tar: self, action: #selector(MainNavVC.back))
            
            viewController.hidesBottomBarWhenPushed=true
        }
        let btn = viewController.navigationItem.leftBarButtonItem?.customView as! UIButton
        btn.imageEdgeInsets=EdgeInsetsMake(-5, left: -20, bottom: 5, right: 20)
        super.pushViewController(viewController, animated: animated)
    }
    
    
    
    func homeTitle()->String{
        return ""
        //        if let  tit = self.childViewControllers.first!.navigationItem.title{
        //            if tit.len>3 {
        //                return "back"
        //            }else{
        //                return tit
        //            }
        //        }else{
        //            return "back"
        //        }
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return childViewControllers.count>1
        
    }
    
    
    func back(){
        if(childViewControllers.count>1){
            popViewControllerAnimated(true)
        }else{
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    
    
    
    
    
}
