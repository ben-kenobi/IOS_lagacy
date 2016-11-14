

//
//  NormalVC.swift
//  day50-pageController-ThirdParty
//
//  Created by apple on 15/12/19.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class NormalVC: UIViewController {
    
    lazy var iv:UIImageView=UIImageView(image: iimg("hitMark.jpg"))
    lazy var lab:UILabel=UILabel( txt: "fewkfjkwejfklwejflkewjfklwejfklewefwefwefwwfkjwekjfkwejflk", color: UIColor.blackColor(), font: UIFont(name: "CourierNewPS-BoldMT", size: 22), align: NSTextAlignment.Center, line: 0)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor=UIColor.whiteColor()
        view.addSubview(iv)
        iv.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(0)
            make.top.equalTo(10)
        }
        view.addSubview(lab)
        lab.preferredMaxLayoutWidth=view.w-20
        lab.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(10)
            make.top.equalTo(iv.snp_bottom).offset(5)
        }
        
        
    }

    var model:[String:AnyObject]?{
        didSet{
            if let m = model {
                lab.text=String(format: "%@--%@", m,lab.text!)
            }
        }
    }

}
