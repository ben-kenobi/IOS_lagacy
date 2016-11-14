//
//  ScrolLab.swift
//  am
//
//  Created by apple on 16/5/23.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class ScrolLab: UIView {
    private var pause:Bool = false
    
    // if content wider than frame
   private  var shouldScroll:Bool=false
    // if scroll
    var scroll: Bool = true
    var repeatCount:Int = -1
    
    var selected:Bool = false{
        didSet{
            self.setNeedsDisplay()
            
        }
    }

    // if can scroll
    private var able:Bool{
        get{
            return shouldScroll && scroll && repeatCount != 0
        }
    }
    var speed:CGFloat=0.4
    var font:UIFont = iFont(18)
    var selFont:UIFont = ibFont(18)

    var textColor:UIColor = iColor(30,30,30)
    var selColor:UIColor = iColor(0xffdd5555)
    
    var text:String=""{
        didSet{
            reset()
        }
    }
    private var textsize:CGSize = CGSizeMake(0, 0)
    var lastPosition:CGFloat = 0{
        didSet{
            if lastPosition == 0 {
                dislin.paused=true
                pause = true
                dispatchDelay(2.5,cb: {
                    self.dislin.paused = !self.able
                    self.pause = false
                })
            }
 
        }
    }
    private lazy var dislin:CADisplayLink=iDisLin(self,sel:#selector(self.dislinRedraw))
    
 
    
    @objc private func dislinRedraw(){
        if self.window==nil  {
            dislin.invalidate()
            return
        }
        setNeedsDisplay()
        
    }
    func reset(){
        lastPosition=0
        textsize = text.sizeWithFont(font)
        setNeedsDisplay()
    }
    override func drawRect(rect: CGRect) {
        
//        let con = UIGraphicsGetCurrentContext()
        
      

        shouldScroll =  rect.width < textsize.width
        
        if lastPosition+textsize.width < (rect.width * 0.5){
            lastPosition = 0
            repeatCount -= 1
        }
        self.dislin.paused = !able || pause

        
        (text as NSString).drawAtPoint(CGPointMake(lastPosition, (rect.height-textsize.height)*0.5), withAttributes:[NSForegroundColorAttributeName:selected ? selColor:textColor,
            NSFontAttributeName:selected ? selFont:font])
        
        
        lastPosition -= speed
        
    }
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor=UIColor.whiteColor()
        lastPosition=0
        iNotiCenter.addObserver(self, selector: #selector(self.reset), name: UIDeviceOrientationDidChangeNotification, object: nil)

    }
 
    deinit{
//        print("deinit--------------------")
        iNotiCenter.removeObserver(self)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
