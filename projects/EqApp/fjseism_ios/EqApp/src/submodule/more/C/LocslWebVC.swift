//
//  LocslWebVC.swift
//  EqApp
//
//  Created by apple on 16/9/30.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class LocslWebVC: YFWebVC {
    
    
    var path:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor=UIColor.whiteColor()
        wv.loadRequest(iReq(path!))
        view.addSubview(wv)
        
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        iPop.dismProg()
    }
 
}
