//
//  TVLoopV.swift
//  day50-pageController-ThirdParty
//
//  Created by apple on 15/12/22.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit


class TVLoopV:UIView,UIScrollViewDelegate{
    
    var onSelAt:((lv:TVLoopV,idx:Int)->())?
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
            ivs[0].image=imgs[0]
            if imgs.count>1{
                
                sv.contentSize=CGSizeMake(sv.w * CGFloat(imgs.count) * 4, 0)
                sv.contentOffset=CGPointMake( sv.w * CGFloat(imgs.count) * 2,0)
            }
            timer(autoPlay)
        }
    }
    
    
    lazy var ivs:[UIImageView]={
        var ivs=[UIImageView]()
        for _ in 0...1{
            ivs.append(UIImageView(frame:self.sv.bounds))
            self.sv.addSubview(ivs.last!)
        }
        return ivs
    }()
    
    
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
    
    var curidx:Int = 0
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let idx=Int(scrollView.contentOffset.x/scrollView.w)
        if curidx != idx{
            let inuse=ivs[idx%2]
            let unuse=ivs[(idx+1)%2]
            
            inuse.x=scrollView.w * CGFloat(idx)
            unuse.x=scrollView.w * CGFloat(idx+1)
            
            let i = idx%imgs!.count
            inuse.image = imgs![i]
            unuse.image = imgs![(idx+1)%imgs!.count]
            pc.currentPage = i
            curidx=idx
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
        if pc.numberOfPages<2{
            return
        }
        
        let page=pc.currentPage+1
        pc.currentPage=page%pc.numberOfPages
        var offx=CGFloat(Int(sv.contentOffset.x/sv.w)+1) * sv.w
        if offx > sv.contentSize.width-sv.w{
            offx = sv.contentSize.width * 0.5
        }
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.sv.contentOffset = CGPointMake(offx - 1, 0)
            }) { (b) -> Void in
                self.sv.contentOffset = CGPointMake(offx, 0)
        }
    }
    
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        timer(false)
    }
    
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        timer(autoPlay)
    }
    
    func onTap(gest:UITapGestureRecognizer){
        onSelAt?(lv: self,idx: pc.currentPage)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


