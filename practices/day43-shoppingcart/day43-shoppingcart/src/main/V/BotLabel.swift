





//
//  BotLabel.swift
//  day43-shoppingcart
//
//  Created by apple on 15/12/17.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class BotLabel: UILabel {
    
    lazy var tap:UITapGestureRecognizer={
        let gest=UITapGestureRecognizer(target: self, action: "gest:")
        return gest
    }()
    lazy var lp:UILongPressGestureRecognizer={
        let gest=UILongPressGestureRecognizer(target: self, action: "gest:")
        return gest
    }()
    
    weak var taptar:AnyObject?
    var tapSel:Selector?
    
   weak var lpBegantar:AnyObject?
    var lpBeganSel:Selector?
    
   weak var lpEndtar:AnyObject?
    var lpEndSel:Selector?
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        NSFontAttributeName
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addTarget(tar:AnyObject,sel:Selector,event:BotLabEvent){
        switch event{
        case .tap:
            self.addGestureRecognizer(tap)
            taptar=tar
            tapSel=sel
            
        case .LPBegan:
            self.addGestureRecognizer(lp)
            lpBegantar=tar
            lpBeganSel=sel
        case .LPEnd:
            self.addGestureRecognizer(lp)
            lpEndtar=tar
            lpEndSel=sel
        }
    }
    
    
    func gest(gest:UIGestureRecognizer){
        if gest == tap{
            switch tap.state{
            case .Began:
                print("tap begin")
            case .Ended,.Failed,.Cancelled:
                self.taptar?.performSelector(tapSel!, withObject: self)
            default:
                break
            }
            
            
            
        }else if gest == lp{
            switch lp.state{
            case .Began:
                 self.lpBegantar?.performSelector(lpBeganSel!, withObject: self)
            case .Ended,.Failed,.Cancelled:
                 self.lpEndtar?.performSelector(lpEndSel!, withObject: self)
            default:
                break
            }
        }
    }
    deinit{
        print("--++++++++++++++---------")
    }
}


enum BotLabEvent : Int {
    
    case tap
    case LPBegan
    case LPEnd
}
