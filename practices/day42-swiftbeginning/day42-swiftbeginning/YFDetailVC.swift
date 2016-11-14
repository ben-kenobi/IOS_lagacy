



//
//  YFDetailVC.swift
//  day42-swiftbeginning
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class YFDetailVC: UIViewController {


    convenience init?(f:Bool){
        if(f){
            return nil;
        }
        self.init()

    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var m:Person?
    var clo:(()->())?
    
    var name:UITextField?
    var age:UITextField?
    
    var sava:UIButton?
    var exit:UIButton?
    
    
    private static var namesss = "sss"
    
    override func viewDidLoad() {
        print(YFDetailVC.namesss)
        
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.randColor()
        let pad:CGFloat=20.0
        name=UITextField(frame: CGRect(x: pad, y: pad, width: view.frame.width-(pad*2.0), height: 30))
        age=UITextField(frame: CGRect(x: pad, y: name!.b()+pad, width:name!.w(), height: name!.h()))
        name?.backgroundColor=UIColor .whiteColor()
        age?.backgroundColor=UIColor.whiteColor()
        view.addSubview(name!)
        view.addSubview(age!)
        sava=UIButton(frame: CGRect(x: view.icx()-120, y: age!.b()+pad*3, width: 80, height: 28))
        exit=UIButton(frame: CGRect(x: view.icx()+40, y: sava!.y(), width: 80, height: 28))
        sava?.layer.cornerRadius=4
        sava?.layer.borderColor=UIColor.randColor().CGColor
        sava?.layer.borderWidth=1
        view.addSubview(sava!)
        view.addSubview(exit!)
        sava?.setTitle("save", forState: UIControlState.Normal)
        exit?.setTitle("exit", forState: UIControlState.Normal)
        sava?.backgroundColor=UIColor.randColor()
        exit?.backgroundColor=UIColor.randColor()
        exit?.layer.cornerRadius=4
        exit?.layer.borderColor=UIColor.randColor().CGColor
        exit?.layer.borderWidth=1
        sava?.setTitleColor(UIColor.grayColor(), forState: [UIControlState.Highlighted])
        exit?.setTitleColor(UIColor.grayColor(), forState: [UIControlState.Highlighted])
        
        sava?.setTitleColor(UIColor.grayColor(), forState: [UIControlState.Disabled])
        exit?.setTitleColor(UIColor.grayColor(), forState: [UIControlState.Disabled])
        
        name?.text=m?.name
        age?.text="\(m?.age ?? 0)"
        
        
        exit?.addTarget(self, action: Selector("onBClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        sava?.addTarget(self, action: Selector("onBClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        name?.addTarget(self, action: Selector("onChange:"), forControlEvents: UIControlEvents.EditingChanged)
        
        age?.addTarget(self, action: Selector("onChange:"), forControlEvents: UIControlEvents.EditingChanged)
        
    }

    func onChange(tf:UITextField){
        if(name?.text?.characters.count==0 || age?.text?.characters.count==0){
            sava?.enabled=false
        }else{
             sava?.enabled=true
        }
       
    }
    
    func onBClick(b:UIButton){
        if(b==exit){
            self.dismissViewControllerAnimated(true, completion: nil)
        }else if(b==sava){
            m?.name=name?.text
            m?.age=Int((age?.text)!) ?? 0
            clo?()
            dismissViewControllerAnimated(true, completion: nil)
        }
    }

}
