//
//  EQInfoPop.swift
//  EqApp
//
//  Created by apple on 16/9/2.
//  Copyright © 2016年 apple. All rights reserved.
//

import Foundation
class EQInfoPop: DropdownPop {
    var contents:[String] = ["无","无","无","无","无 / 无"]
    var contentLabs:[UILabel] = []
    let colh:CGFloat = 28
    let pad:CGFloat = 8
    var locbtn:UIButton?
    var cb:((str:String,pos:Int)->())?
    class func eqInfoPopWith(cb:(str:String,pos:Int)->())->Self{
        let pop = popWith()
        pop.cb=cb
        return pop
    }
    
    required init(frame: CGRect) {
        super.init(frame: frame)
        mainView.snp_updateConstraints { (make) in
            make.height.equalTo(colh * CGFloat(contents.count) + pad * 2)
            make.width.equalTo(iScrW-18*2)
        }
        initUI()
        updateUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        let titles:[String]=["地震发生时间: ","震中位置: ","经度: ","纬度: ","震级/深度: "]
        let titlew:CGFloat = 130
        for i in 0..<contents.count{
            let lab = UILabel(frame: CGRectMake(0, pad+colh*CGFloat(i), titlew, colh), txt: titles[i], color: iColor(0xff000000), font: iFont(17), align: .Right, line: 1)
             mainView.addSubview(lab)
            let clab = UILabel(frame: CGRectMake(lab.r+8, pad+colh*CGFloat(i), titlew+100, colh), txt: contents[i], color: iColor(0xff555555), font: iFont(16), align: .Left, line: 1)
            mainView.addSubview(clab)
            contentLabs.append(clab)
            if i ==  contents.count - 1 {
                lab.textColor=iColor(0xffee5555)
            }
            
        }
        locbtn=UIButton(frame: CGRectMake(iScrW-18*2-44, pad+colh*2, 35, colh*2), img: iimg("location"),bgcolor: iColor(0x00000000),  tar: self, action: #selector(self.locate(_:)), tag: 0)
        locbtn!.imageView!.contentMode = .ScaleAspectFit
        mainView.addSubview(locbtn!)
    }
    
    func updateUI(){
        let info = EQInfo.getIns()
        if let info = info {
            contents = [info.occurTime!,info.occurRegionName!,
            "\(info.lon)","\(info.lat)","\(info.magnitude ?? "") / \(info.focalDepth)"]
            locbtn?.hidden=false
        } else {
            contents = ["无","无","无","无","无 / 无"]
            locbtn?.hidden=true
        }
        for (idx,lab) in contentLabs.enumerate(){
            lab.text=contents[idx]
        }
    }
    func locate(sender:UIButton){
        cb?(str: "",pos:0)
        dismiss()
    }
    
    
}
