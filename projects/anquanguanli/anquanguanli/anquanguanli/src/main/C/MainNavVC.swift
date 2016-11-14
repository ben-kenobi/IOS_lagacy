

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


    }

    

    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
       
        if(childViewControllers.count>1){
            viewController.navigationItem.leftBarButtonItem=UIBarButtonItem(img:UIImage(named: "navigationbar_back_withtext"),hlimg:UIImage(named: "navigationbar_back_withtext_highlighted"), title: "返回"
           , tar: self, action: "back")
            viewController.hidesBottomBarWhenPushed=true
        }else if(childViewControllers.count==1){
            viewController.navigationItem.leftBarButtonItem=UIBarButtonItem(img:UIImage(named: "navigationbar_back_withtext"),hlimg:UIImage(named: "navigationbar_back_withtext_highlighted"), title: homeTitle()
                , tar: self, action: "back")
             viewController.hidesBottomBarWhenPushed=true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    
    
    func homeTitle()->String{
        if let  tit = self.childViewControllers.first!.navigationItem.title{
            if tit.len>3 {
                return "首页"
            }else{
                return tit
            }
        }else{
            return "首页"
        }
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return childViewControllers.count>1
    }
    
    
    func back(){
        popViewControllerAnimated(true)
    }
    
   

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
     init(){
        let vc = MainVC()
        vc.title="福建省人工影响天气指挥系统"
        super.init(rootViewController: vc)

    }
    

    
    
}
