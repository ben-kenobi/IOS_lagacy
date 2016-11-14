
//
//  NavVC.swift
//  day50-pageController-ThirdParty
//
//  Created by apple on 15/12/19.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class NavVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().translucent=false
        UINavigationBar.appearance().tintColor=UIColor.orangeColor()
        UINavigationBar.appearance().backgroundColor=iGlobalGreen
        UINavigationBar.appearance().titleTextAttributes=[NSFontAttributeName:ibFont(22),NSForegroundColorAttributeName:UIColor.orangeColor()]
        
    }
    
    
    
    
    
    
    
    
    
    
    init(){
        super.init(rootViewController:MainVC())
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


  

}
