//
//  ControlflowPop.swift
//  EqApp
//
//  Created by apple on 16/9/5.
//  Copyright © 2016年 apple. All rights reserved.
//

import Foundation

import Foundation
class ControlflowPop: DropdownPop {
    var onItemSelCB:((str:String,pos:Int,sel:Bool)->Void)?

    var datas:[String]=[]
    var icons:[String]=[]
    var hlicons:[String]=[]
    @available(iOS 9.0, *)
    lazy var sv:BGStackV={
        let sv = BGStackV(frame:CGRectMake(0, 0, 0, 0))
        
        return sv
        
    }()
    
    required init(frame: CGRect) {
        super.init(frame: frame)
        if #available(iOS 9.0, *) {
            mainView.addSubview(sv)
            sv.snp_makeConstraints { (make) in
                make.height.equalTo(100)
                make.width.equalTo(iScrW-18*2-20)
                make.edges.equalTo(UIEdgeInsetsMake(10, 10, -10, -10))
            }
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    class func controlflowPopWith(datas:[String],imgs:[String],hlimgs:[String],cb:(str:String,pos:Int,sel:Bool)->())->Self{
        let pop = popWith()
        
        pop.datas=datas
        pop.icons=imgs
        pop.hlicons=hlimgs
        
        pop.onItemSelCB = cb
        pop.updateUI()
        return pop
    }
    
    
    func updateUI(){
        if #available(iOS 9.0, *) {
            sv.distribution = .FillEqually
            for i in 0..<datas.count{
                let b = GridBtn(frame: nil, img: iimg(icons[i]), hlimg:iimg( hlicons[i]), title: datas[i], font: iFont(16), titleColor: iColor(0xff333333), titleHlColor: iColor(0xff3388ff), tar: self, action: #selector(self.onSel(_:)), tag: i)
                sv.addArrangedSubview(b)
                b.setImage(iimg( hlicons[i]), forState: UIControlState.Selected)
                b.setTitleColor(iColor(0xff3388ff), forState: UIControlState.Selected)
            }
        } else {
            // Fallback on earlier versions
        }
        
        
    }
    
    func onSel(sender: UIButton) {
        sender.selected = !sender.selected
        onItemSelCB?(str: sender.titleForState(.Normal)!,pos:sender.tag,sel:sender.selected)
    }
    
}

class GridBtn:UIButton{
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.titleLabel?.textAlignment = .Center
}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        return CGRectMake((contentRect.maxX-60)*0.5,10, 60, 60)
    }
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        return CGRectMake(4, contentRect.maxY-26, contentRect.width-8, 20)
    }
}



