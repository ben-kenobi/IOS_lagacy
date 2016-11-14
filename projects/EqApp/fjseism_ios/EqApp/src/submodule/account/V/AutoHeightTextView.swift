//
//  AutoHeightTextView.swift
//  EqApp
//
//  Created by apple on 16/9/8.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class AutoHeightTextView: UITextView {
    var autoWid:Bool = false
    var wid:CGFloat = 1{
        didSet{
            updateSize()
        }
    }
    var minH:CGFloat = 100
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.Old, context: nil)
        //        iNotiCenter.addObserver(self, selector: #selector(self.updateHight), name:UIScreenModeDidChangeNotification, object: nil)
        iNotiCenter.addObserver(self, selector: #selector(self.updateSize), name:UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath=="contentSize"{
            updateSize()
            
        }
    }
    func updateSize(){
        snp_updateConstraints(closure: { (make) in
            let verinset=contentInset.bottom+contentInset.top
            let height = min(contentSize.height+verinset , iScrH*0.9)
            
            make.height.equalTo(max(height, minH))
            if autoWid{
                let width = wid>1 ? wid:iScrW*wid
                make.width.equalTo(width)
            }
        })
        
    }
    
    
    deinit{
        removeObserver(self, forKeyPath: "contentSize")
        iNotiCenter.removeObserver(self)
    }
   

}
