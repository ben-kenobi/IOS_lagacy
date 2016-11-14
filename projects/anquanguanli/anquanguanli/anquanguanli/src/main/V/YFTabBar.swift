
//
//  YFTabBar.swift
//  day-43-microblog
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

protocol TBDele:NSObjectProtocol{
    func onBClick()
}

class YFTabBar: UITabBar {
    weak var dele:TBDele?

    var clo:(()->())?
    
    
   lazy var btn:UIButton = {
       let b = UIButton()
        b.addTarget(self, action: "onBClick:", forControlEvents: UIControlEvents.TouchUpInside)
        b.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
        b.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        b.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        b.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        b.sizeToFit()
        return b
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(btn)
        backgroundImage=iimg("tabbar_background")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let w=self.w * 0.2
        var idx=0
        for child in subviews{
            if child.isKindOfClass(NSClassFromString("UITabBarButton")!){
                child.frame=CGRect(x: CGFloat(idx)*w, y: 0, width: w, height: h)
                idx++
                if idx==2 {
                    idx++
                }
                
            }
        }
        
        btn.center=self.ic
    }
    
    
    @objc private func onBClick(b:UIButton ){
        clo?()
        dele?.onBClick()
    }
}
