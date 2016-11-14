
//
//  VC01.swift
//  day43-shoppingcart
//
//  Created by apple on 15/12/19.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class VC01: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor=UIColor.whiteColor()
        self.title="vc01"
        let lab = UITextView(frame: self.view.bounds)
        view.addSubview(lab)

        lab.text="\(ShoppingCart.ins.dict)"
        lab.font=iFont(25)
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        navigationController?.showViewController(YFMainVC(), sender: nil)
    }
  
}
