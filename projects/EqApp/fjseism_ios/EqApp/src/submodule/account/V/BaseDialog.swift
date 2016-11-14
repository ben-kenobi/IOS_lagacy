//
//  BaseDialog.swift
//  am
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class BaseDialog: UIView {
    var fade:Bool = true
    var scale:Bool = true
    var dismissOnTouchOutside = true
    var dropdownYoffset:CGFloat=6
    var bgcolor:UIColor? = nil
    lazy var view:UIView={
        return self.loadView()
    }()
    lazy var contentView:UIView={
        return self.loadContentView()
    }()
    
    func loadView()->UIView{
        let view = UIView()
        
        view.layer.backgroundColor=UIColor.whiteColor().CGColor
        view.layer.cornerRadius=8
        view.layer.borderColor=iColor(190,190,190).CGColor
        view.layer.borderWidth=1
        view.layer.shadowOpacity=1
        view.layer.shadowOffset=CGSizeMake(2, 2)
        view.layer.shadowRadius=6
        view.layer.shadowColor=iColor(0xff666666).CGColor
        view.layer.masksToBounds=false
        
        return view
    }
    func loadContentView()->UIView{
        let contentView = UIView()
        contentView.layer.masksToBounds=true
        contentView.layer.backgroundColor=iConst.khakiBg.CGColor
        contentView.layer.cornerRadius=8
        return contentView
    }
    
    var anchor:UIButton?
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor=UIColor.clearColor()
        addSubview(view)
        view.addSubview(contentView)
        contentView.snp_makeConstraints { (make) in
            make.top.left.width.height.equalTo(view)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if !view.frame.contains((touches.first?.locationInView(self))!) && dismissOnTouchOutside{
            dismiss()
        }
    }
    
    func dismiss(){
        
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.alpha=0.02
            //            self.transform=CGAffineTransformMakeScale(0.1,0.1)
        }) { (b) in
            self.removeFromSuperview()
            self.anchor?.selected=false
        }
    }
    
    func showCenter(){
        view.snp_makeConstraints { (make) in
            make.center.equalTo(0)
        }
        if fade{
            alpha=0
        }
        if scale{
            view.transform=CGAffineTransformMakeScale(0, 0)
        }
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.alpha=1
            self.view.transform=CGAffineTransformIdentity
        }) { (b) in
            
        }
    }
    func drowDown(anchor:View){
        //        let rect = anchor.convertRect(anchor.bounds, toView:self)
        if scale{
            view.transform=CGAffineTransformMakeScale(1, 0)
            view.layer.anchorPoint=CGPointMake(0.5, 0)
            view.snp_makeConstraints { (make) in
                make.centerY.equalTo(anchor.snp_bottom).offset(dropdownYoffset)
                make.right.equalTo(anchor.snp_right)
            }
        }else{
            view.snp_makeConstraints { (make) in
                make.top.equalTo(anchor.snp_bottom).offset(dropdownYoffset)
                make.right.equalTo(anchor.snp_right)
                make.bottom.lessThanOrEqualTo(self.snp_bottom)
            }
        }
        
      
        if fade{
            alpha=0
        }
        
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.alpha=1
            self.view.transform=CGAffineTransformIdentity
        }) { (b) in
            // self.view.layer.anchorPoint=CGPointMake(0.5, 0.5)
            
        }
        if anchor.isKindOfClass(UIButton.self) && !anchor.isKindOfClass((NSClassFromString("UINavigationButton")!)){
            self.anchor=anchor as? UIButton
            self.anchor?.selected=true
        }
        
    }
    
    
    
    
    
    class func dialogWith()->Self{
        let dialog = self.init(frame:CGRectMake(0, 0, 0, 0))
        return dialog
    }
    func show(vc:UIViewController?=nil,basev:UIView?=nil,anchor:View?=nil)->Self{
        var view:View? = nil
        if let nav = vc?.navigationController {
            view = nav.view
        }else if let vc = vc{
            view=vc.view
        }else if let basev = basev{
            view=basev
        }else{
            view = iApp.windows[iApp.windows.count-1]
        }
        view!.addSubview(self)
        self.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        self.backgroundColor = bgcolor
        self.beforeShow(vc, basev: basev, anchor: anchor)

        if let anchor = anchor{
            drowDown(anchor)
        }else{
            showCenter()
        }
        self.afterShow(vc, basev: basev, anchor: anchor)
        
        return self
    }
    
    func beforeShow(vc:UIViewController?,basev:UIView?,anchor:View?){
        
    }
    func afterShow(vc:UIViewController?,basev:UIView?,anchor:View?){
        
    }
}


