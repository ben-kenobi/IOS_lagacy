//
//  PeripheralBottomPop.swift
//  EqApp
//
//  Created by apple on 16/9/20.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class PeripheralBottomPop: BottomPopV {
    
    lazy var btn:UIButton={
        let btn = UIButton(frame: nil, img: iimg("saft_tjcx"), title: "周边查询", font: iFont(19), titleColor: iColor(0xff555555),  tar: self, action: #selector(self.onClick(_:)), tag: 0)
        return btn
        
    }()
    
    var btnClickCb:((sender:UIButton)->())?
    
    override func custCotent(cv: UIView) {
        cv.addSubview(btn)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10)
        btn.snp_makeConstraints { (make) in
            make.top.left.equalTo(10)
            make.bottom.equalTo(-10)
            make.width.equalTo(180)
        }
    }
    
    override func onClick(sender: UIButton) {
        if(sender == btn){
            dismiss()
            btnClickCb?(sender:sender)
        }else{
            super.onClick(sender)
        }
        
    }

}
