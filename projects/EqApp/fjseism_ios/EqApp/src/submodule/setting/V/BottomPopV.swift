//
//  BottomPopV.swift
//  EqApp
//
//  Created by apple on 16/9/14.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class BottomPopV: UIView {
    var title:String?
    var leftB:(String,((obj:AnyObject)->Bool)?)?
    var rightB:(String,((obj:AnyObject)->Bool)?)?
    var bgColor:UIColor?
    var dismissOnTouchOutside = true
    var contentH:CGFloat = 0
    var titleH:CGFloat = 52

    var onDismiss:((pop:BottomPopV)->())?

    lazy var view:UIView={
        return self.loadView()
    }()
    lazy var contentView:UIView={
        return self.loadContentView()
    }()
    
    
    lazy var titleBar:UIView={
        return self.loadTitleBar()
    }()
    
    

    required override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(view)
        view.addSubview(contentView)
        contentH=frame.height
        bgColor=iColor(0x66000000)
    }
    
    func loadTitleBar()->UIView{
        return UIView(frame: nil, bg: iConst.iGlobalBG)
    }
    func loadView()->UIView{
        let contentView = UIView()
        contentView.layer.masksToBounds=true
        contentView.layer.backgroundColor = iColor(0xffffffff).CGColor
        contentView.layer.cornerRadius=8
        return contentView
    }
    func loadContentView()->UIView{
        let contentView = UIView()
        return contentView
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
        
        UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.alpha=0.2
            self.view.y=self.h
        }) { (b) in
            self.removeFromSuperview()
            self.onDismiss?(pop: self)
        }
    }
    
    
    func show(vc:UIViewController?=nil,basev:UIView?=nil)->Self{
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
        self.frame=view!.bounds
        
        self.view.frame = CGRectMake(0, view!.h, view!.w, contentH)
        self.view.alpha=0.2
        if let _ = self.title{
            self.view.addSubview(self.titleBar)
            self.titleBar.frame=CGRectMake(0, 0, view!.w, titleH)
            self.contentView.frame = CGRectMake(0, self.titleBar.b, view!.w, contentH-self.titleBar.h)
            self.initTitleBar()
        }else{
            self.contentView.frame = self.view.bounds
        }
        
        custCotent(self.contentView)
    
        UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.view.alpha=1
            self.view.y=self.h-self.contentH
        },completion: nil)
        
        self.backgroundColor = bgColor
        
        
        return self
    }
    
    func initTitleBar(){
        let lab = UILabel(frame: nil, txt: title ?? "", color: UIColor.orangeColor(), font: ibFont(17), align: NSTextAlignment.Center, line: 1)
        titleBar.addSubview(lab)
        lab.sizeToFit()
        lab.center=titleBar.ic
        
        if let leftB=leftB{
            let lb = UIButton(frame: CGRectMake(0, 0, 90, titleH), title: leftB.0, font: iFont(17), titleColor: iConst.TextBlue, titleHlColor: iColor(0xffffffff), tar: self, action: #selector(self.onClick(_:)), tag: 1)
            self.titleBar.addSubview(lb)
            
        }
        if let rightB=rightB{
            let rb = UIButton(frame: CGRectMake( titleBar.w-90,0, 90, titleH), title: rightB.0, font: iFont(17), titleColor: iConst.TextBlue, titleHlColor: iColor(0xffffffff), tar: self, action: #selector(self.onClick(_:)), tag: 2)
            self.titleBar.addSubview(rb)
        }
        
    }

    
    
    func onClick(sender:UIButton){
        if sender.tag == 1{
            if  leftB?.1?(obj: self) ?? true {
                dismiss()
            }
        }else if sender.tag == 2{
            if rightB?.1?(obj: self) ?? true{
                dismiss()
            }
        }
        
    }
    
    func custCotent(cv:UIView){
        
    }
}
