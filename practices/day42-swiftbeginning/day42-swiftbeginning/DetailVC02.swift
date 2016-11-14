

//
//  DetailVC02.swift
//  day42-swiftbeginning
//
//  Created by apple on 15/12/4.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class DetailVC02: UIViewController {
    
    var m:Modle?
    var cb:(()->())?
    var name:UITextField?
    var age:UITextField?
    var exit:UIButton?
    var save:UIButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.randColor()
        self.initUI()
    }
    
    func initUI(){
        let pad:CGFloat=20,bw:CGFloat=80,bh:CGFloat=33
        
        let newtf={
            (frame:CGRect,txt:String)->UITextField  in
            let tf=UITextField(frame: frame)
            self.view.addSubview(tf)
            tf.backgroundColor=UIColor.whiteColor()
            tf.text=txt
            tf.layer.cornerRadius=4
            tf.layer.borderColor=UIColor.grayColor().CGColor
            tf.layer.borderWidth=1
            tf.leftView=UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
            tf.leftViewMode=UITextFieldViewMode.Always
            tf.addTarget(self, action: Selector("onChange"), forControlEvents: UIControlEvents.EditingChanged)
            return tf
        }
    
        name=newtf(CGRect(x: pad, y: 20+pad, width: view.w()-pad*2, height: bh),(m?.name)!)
        age=newtf(CGRect(x: pad, y: name!.b()+pad, width: name!.w(), height: name!.h()),"\(m?.age ?? 0)")
        
        let newb={
            (frame:CGRect,txt:String)->UIButton in
            let b=UIButton(frame: frame)
            self.view.addSubview(b)
            b.setTitle(txt, forState: UIControlState.Normal)
            b.setTitleColor(UIColor.randColor(), forState: UIControlState.Normal)
            b.setTitleColor(UIColor.randColor(), forState: UIControlState.Highlighted)
            b.setTitleColor(UIColor.randColor(), forState: UIControlState.Disabled)
            b.backgroundColor=UIColor.randColor()
            b.layer.cornerRadius=5
            b.layer.borderWidth=1
            b.layer.borderColor=UIColor.randColor().CGColor
            b.addTarget(self, action: "onClick:", forControlEvents: UIControlEvents.TouchUpInside)
            return b
        }
        save=newb(CGRect(x: view.cx()-pad-bw, y: age!.b()+pad*2, width: bw, height: bh),"save")
        exit=newb(CGRect(x: view.cx()+pad, y: age!.b()+pad*2, width: bw, height: bh),"exit")
        
        
    }
    func onChange(){
        save?.enabled=name?.text?.len()>0 && age?.text?.len()>0
    }
    
    func onClick(b:UIButton){
        if(b==save){
            m?.name=name?.text
            m?.age=Int((age?.text)!) ?? 0
            cb?()
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
 

}
