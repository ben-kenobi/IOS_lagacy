//
//  DLDialog.swift
//  EqApp
//
//  Created by apple on 16/9/16.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class DLDialog: CommonDialog {
    
    lazy var textLab:UILabel={
        let title = UILabel(txt: "", color:iColor(0xff333333) , font: iFont(19), align: NSTextAlignment.Center, line: 0)
        self.midContent.addSubview(title)
        title.snp_makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
        return title
    }()
    
    lazy var pv:ProgressV={
        let pv = ProgressV(frame: CGRectMake(0, 0, 0, 22), bg: iColor(0xffeeeeee), corner: 8, bordercolor: iColor(0xffee88aa), borderW: 2)
        
        return pv
    }()
    
    static func dialogWith(title:String,mes:String?,btns:[String],cb:((pos:Int,dialog:CommonDialog)->Bool)?)->Self{
        let av = self.dialogWith()
        av.midContent.addSubview(av.pv)
        av.pv.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(av.textLab.snp_bottom).offset(20)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.bottom.equalTo(-22)
            make.height.equalTo(22)
        })
        av.titleLab.text=title
        av.textLab.text=mes
        av.btns=btns
        av.cb=cb
        av.dismissOnTouchOutside=false
        return av
    }

}
