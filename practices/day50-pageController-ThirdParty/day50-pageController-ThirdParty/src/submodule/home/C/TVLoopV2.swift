
//
//  TVLoopV2.swift
//  day50-pageController-ThirdParty
//
//  Created by apple on 15/12/22.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class TVLoopV2: UIView ,UIScrollViewDelegate{

    var onSelAt:((lv:TVLoopV2,idx:Int)->())?
    var autoPlay:Bool=false{
        didSet{
            timer(autoPlay)
        }
    }
    var interval:NSTimeInterval=2{
        didSet{
            timer(autoPlay)
        }
    }
    var timer:NSTimer?
    
    var imgs:[UIImage?]?{
        didSet{
            guard let imgs = imgs where imgs.count > 0 else {
                return
            }
            pc.numberOfPages=imgs.count
            for v in  self.sv.subviews{
                v.removeFromSuperview()
            }
            for i in 0...2{
                self.sv.addSubview(UIImageView(frame:CGRectMake(CGFloat(i) * self.sv.w, 0, self.sv.w, self.sv.h)))
            }
            sv.contentSize=CGSizeMake(sv.w * 3, 0)
            curidx=0
            timer(autoPlay)
        }
    }
    
  
    
    
    var curidx:Int = 0{
        didSet{
            let count = imgs!.count
            curidx = curidx<0 ? curidx + count : (curidx >= count ? curidx-count :curidx)
            pc.currentPage=curidx
            for (i,iv)  in sv.subviews.enumerate() {
                let idx = (curidx-1+i+count)%count
                (iv as! UIImageView).image=imgs![idx]
            }
            sv.contentOffset.x=sv.w
        }
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.x <= 0{
            curidx--
        }else if scrollView.contentOffset.x >= sv.w * 2{
            curidx++
        }
        
    }
    
    
    func timer(play:Bool){
        timer?.invalidate()
        timer=nil
        if play && imgs?.count>1 {
            timer = iTimer(interval,tar:self,sel:"doTimer")
        }
        
        
    }
    func doTimer(){
        guard let count = imgs?.count where count > 1 else {
            return
        }
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.sv.contentOffset.x = self.sv.w * 2 - 1
            }) { (b) -> Void in
                self.sv.contentOffset.x = self.sv.w * 2
        }
    }
    
    
    
    
    
    
    
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        timer(false)
    }
    
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        timer(autoPlay)
    }
    
    func onTap(gest:UITapGestureRecognizer){
        onSelAt?(lv: self,idx: curidx)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    
    
    lazy var pc:UIPageControl={
        let pc=UIPageControl()
        pc.userInteractionEnabled=false
        pc.currentPageIndicatorTintColor=UIColor.orangeColor()
        pc.pageIndicatorTintColor=UIColor.whiteColor()
        return pc
    }()
    lazy var sv:UIScrollView={
        let sv=UIScrollView(frame: self.bounds)
        
        let gest=UITapGestureRecognizer(target: self, action: "onTap:")
        sv.addGestureRecognizer(gest)
        sv.showsHorizontalScrollIndicator=false
        sv.showsVerticalScrollIndicator=false
        sv.pagingEnabled=true
        sv.delegate=self
        sv.bounces=false
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(sv)
        self.addSubview(pc)
        pc.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(0)
            make.centerX.equalTo(0)
        }
        sv.frame=self.bounds
    }
}
