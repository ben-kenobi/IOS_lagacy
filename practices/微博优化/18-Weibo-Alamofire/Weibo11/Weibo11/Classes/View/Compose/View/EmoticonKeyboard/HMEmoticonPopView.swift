//
//  HMEmoticonPopView.swift
//  Weibo11
//
//  Created by itheima on 15/12/17.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

class HMEmoticonPopView: UIView {

    
    @IBOutlet weak var emoticonButton: HMEmoticonButton!
    
    
    class func popView() -> HMEmoticonPopView {
        return NSBundle.mainBundle().loadNibNamed("HMEmoticonPopView", owner: nil, options: nil).last! as! HMEmoticonPopView
    }
}
