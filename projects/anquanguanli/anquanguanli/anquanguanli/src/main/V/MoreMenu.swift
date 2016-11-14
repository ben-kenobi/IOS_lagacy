

//
//  MoreMenu.swift
//  day-43-microblog
//
//  Created by apple on 15/12/12.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit
import pop
class MoreMenu: UIView {
    var target:UIViewController?
    
    var dismissing:Bool=false
   
       
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bg)
        addSubview(slogan)
        slogan.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(0)
            make.top.equalTo(100)
        }
    }
    
    
    func showToVC(vc:UIViewController){
        self.target=vc
        vc.view.addSubview(self)
        bg.image=UIImage.imgFromView(vc.view).applyLightEffect()
        for (i,btn) in self.btns.enumerate(){
            animBtn(btn, reverse: false, idx:i)

        }
        
    }
    
    func dismiss(){
        if(dismissing){
            return
        }
        dismissing=true
        
        for (i,btn) in self.btns.reverse().enumerate() {
            animBtn(btn, reverse: true, idx: i)
        }
        dispatch_after(dispatch_time(0, Int64(5e8)), dispatch_get_main_queue(), { () -> Void in
           self.removeFromSuperview()
            self.dismissing=false
        })

    }
    
    func animBtn(btn:UIButton,reverse:Bool,idx:Int){
        let delta:CGFloat=reverse ? 350 : -350
//        UIView.animateWithDuration(0.5, delay: delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: { () -> Void in
//            btn.y+=delta
//            },completion: nil)
        
        let anim=POPSpringAnimation(propertyNamed: kPOPViewCenter)
        
        anim.toValue=NSValue(CGPoint: CGPointMake(btn.cx, btn.cy+delta))
        anim.springBounciness = 8
        anim.springSpeed = 10
        anim.beginTime=CACurrentMediaTime() + Double(idx)*0.025
        btn.pop_addAnimation(anim, forKey: nil)
//
        
    }
    
    
    func btnClick(btn:UIButton){
        UIView.animateWithDuration(0.25, delay: 0, options: [], animations: { () -> Void in
            for b in self.btns{
                b.alpha=0.5
                if b == btn{
                    b.transform=CGAffineTransformMakeScale(2, 2)
                }else{
                     b.transform=CGAffineTransformMakeScale(0.5,0.5)
                }
            }
            }) { (_) -> Void in
                
                let info=self.btninfos[self.btns.indexOf(btn)!]
                guard let vcstr = info["vc"] where (NSClassFromString(vcstr as! String) as? UIViewController.Type) != nil else{
                    UIView.animateWithDuration(0.25, animations: { () -> Void in
                        for b in self.btns{
                            b.alpha=1
                            b.transform=CGAffineTransformIdentity
                        }
                    })
                    
                    return
                }
                
                let vc = (NSClassFromString(vcstr as! String) as! UIViewController.Type).init()
                
                self.target?.presentViewController(UINavigationController(rootViewController: vc) , animated: true, completion: { () -> Void in
                    for b in self.btns{
                        b.alpha=1
                        b.transform=CGAffineTransformIdentity

                    }
                    self.dismiss()
                    
                })
                
                
        }
      
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        dismiss()
        
    }
    
    
    
    
    
    lazy var bg:UIImageView={
        let bg=UIImageView(frame: self.bounds)
        return bg
        
    }()
    
    lazy var btns:[UIButton]={
        var btns=[UIButton]()
        var colcount:CGFloat=3,btnw:CGFloat=100,btnh:CGFloat=100,col:CGFloat,row:CGFloat
        let pad=(self.w-(btnw)*colcount)*0.5
        for var i in 0...5{
            col=CGFloat(i%Int(colcount))
            row=CGFloat(i/Int(colcount))
            btns.append(MenuBtn(frame: CGRectMake(col*btnw+pad,self.h+row*(btnh+20), btnw, btnh), img: iimg(self.btninfos[i]["icon"] as! String), title: self.btninfos[i]["title"] as? String, font: iFont(18), titleColor: UIColor.grayColor(),  tar: self, action: "btnClick:", tag: 0))
            self.addSubview(btns.last!)
            
        }
        return btns
    }()
    
    
    
    private lazy var btninfos:[[String:AnyObject]] = {
        return iRes4Ary("compose.plist") as! [[String:AnyObject]]
    }()
    
    
    private lazy var slogan:UIImageView=UIImageView(img: iimg("compose_slogan"))
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}


class MenuBtn:UIButton{
   override var highlighted:Bool{
        get{
            return false
        }
        set{
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.textAlignment=NSTextAlignment.Center
        imageView?.contentMode = UIViewContentMode.ScaleAspectFit
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView?.frame=CGRectMake(self.w*0.15, 0, self.w*0.7, self.w*0.7)
        titleLabel?.frame=CGRectMake(0, self.h-25, self.w, 25)
        
    }
    
    
    
    
}
