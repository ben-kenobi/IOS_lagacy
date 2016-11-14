//
//  CommonAlertView.swift
//  am
//
//  Created by apple on 16/5/27.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class CommonAlertView: CommonDialog {
    lazy var textLab:UILabel={
        let title = UILabel(txt: "", color:iColor(0xff333333) , font: iFont(19), align: NSTextAlignment.Center, line: 0)
        self.midContent.addSubview(title)
        title.snp_makeConstraints { (make) in
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
        return title
    }()
    
    static func viewWith(title:String,mes:String?,btns:[String],cb:((pos:Int,dialog:CommonDialog)->Bool)?)->Self{
        let av = self.dialogWith()
        av.titleLab.text=title
        av.textLab.text=mes
        av.btns=btns
        av.cb=cb
        return av
    }
}


