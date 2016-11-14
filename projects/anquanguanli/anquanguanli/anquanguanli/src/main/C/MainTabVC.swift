

//
//  MainTabVC.swift
//  day-43-microblog
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit


class MainTabVC: UITabBarController {
    
    lazy var menu:MoreMenu={
        let menu=MoreMenu(frame: self.view.bounds)
        return menu
    }()
    
    
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tb=YFTabBar(frame:tabBar.frame)
        setValue(tb, forKeyPath:"tabBar")
        tb.clo={[weak self] in
            if !UserInfo.isLogin(){
                iPop.showMsg("login first")
                return 
            }
            self?.menu.showToVC(self!)
        }

        
        
//        tabBar.tintColor=UIColor.orangeColor()
        UITabBar.appearance().translucent=false
        UINavigationBar.appearance().translucent=false
        UINavigationBar.appearance().titleTextAttributes=[NSFontAttributeName:ibFont(19),NSForegroundColorAttributeName:UIColor.orangeColor()]

      
        
        addChildVC( MainVC(), img: UIImage(named: "tabbar_home"),selimg: UIImage(named: "tabbar_home_selected"), title: "Home")
        
         addChildVC( MainVC(), img: UIImage(named: "tabbar_message_center"), selimg: UIImage(named: "tabbar_message_center_selected"),title: "Message")
         addChildVC( MainVC(), img: UIImage(named: "tabbar_discover"),selimg: UIImage(named: "tabbar_discover_selected"), title: "Discovery")
         addChildVC( MainVC(), img: UIImage(named: "tabbar_profile"),selimg: UIImage(named: "tabbar_profile_selected"), title: "Profile")
       
  
        
            
        
    }
    func addChildVC(vc:UIViewController,img:UIImage?,selimg:UIImage?,title:String){
        vc.tabBarItem=CustTabBarItem()
        vc.tabBarItem.title=title
        vc.navigationItem.title=title
        vc.tabBarItem.image=img
        vc.tabBarItem.selectedImage=selimg?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        vc.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFontOfSize(12)], forState: UIControlState.Normal)
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orangeColor()], forState: UIControlState.Selected)
        
        addChildViewController(MainNavVC(rootViewController:vc))
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        let iv=UIImageView(frame:iScreen.bounds)
//        iv.image = UIImage.launchImg()
//        view.addSubview(iv)
//        
//        UIView.animateWithDuration(3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: { () -> Void in
//                iv.transform=CGAffineTransformMakeScale(2, 2)
//                iv.alpha=0
//            }) { (b) -> Void in
//                iv.removeFromSuperview()
//
//        }
    }

  
}
