


//
//  HomeVC.swift
//  day50-sqlite
//
//  Created by apple on 15/12/23.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title="Home"
        view.backgroundColor=irandColor()
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var dict = Dictionary<String,String>()
        dict["k1","k2","k3"]=["qwe","qweqw","qwdwq"]

        print(dict)
    }

}
