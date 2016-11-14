//
//  ListPop.swift
//  am
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class DropdownPop: BaseDialog {
   
    override func loadView() -> UIView {
        let v =  UIView()
        return v
    }
    override func loadContentView() -> UIView {
        return UIView()
    }
   
    
    
    lazy var disBtn:ImgPaddingBtn={
        let btn = ImgPaddingBtn(frame: nil, img: iimg("deletered"), bgcolor: iColor(0xffffffff), corner: 3, tar: self, action: #selector(self.onClicK(_:)))
        return btn
    }()
    
    lazy var mainView:UIView = {
        return self.loadMainView()
    }()
    
    func loadMainView()->UIView{
        let v =  RoundV()
        v.backgroundColor=UIColor.whiteColor()
        return v
    }
    required init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(disBtn)
        contentView.addSubview(mainView)
        mainView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(disBtn.snp_bottom).offset(-3)
        }
    }
    override func beforeShow(vc: UIViewController?, basev: UIView?, anchor: View?) {
        self.dropdownYoffset = -anchor!.h
        disBtn.snp_makeConstraints { (make) in
            make.top.right.equalTo(0)
            make.width.height.equalTo(anchor!)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension DropdownPop{
    
    class func popWith()->Self{
        let pop = dialogWith()
        pop.bgcolor = iColor(0x88000000)
        pop.scale = false
        pop.dismissOnTouchOutside = false
        return pop
    }
    
    func onClicK(sender:View){
        self.dismiss()
    }
    
    
}

class RoundV:UIView{
    override func layoutSubviews() {
        super.layoutSubviews()
         self.addCurve((true, 11), tr: (false, 0), br: (true, 11), bl: (true, 11), bounds: self.bounds)
    }
}


