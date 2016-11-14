//
//  NavVC.swift
//  day50-sqlite
//
//  Created by apple on 15/12/20.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class NavVC: UINavigationController {

    
    init(){
        super.init(rootViewController: MainVC())
        UINavigationBar.appearance().tintColor=iGlobalGreen
        UINavigationBar.appearance().titleTextAttributes=[NSFontAttributeName:ibFont(22),NSForegroundColorAttributeName:iGlobalGreen]
        UINavigationBar.appearance().translucent=false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
}
