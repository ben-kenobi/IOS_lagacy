

//
//  RefreshV.swift
//  day-43-microblog
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class RefreshC: UIControl {
    let hei:CGFloat=53
    
    var curState:Int? = 1
    
    var scrollState:Int?{
        didSet{
            if(curState==scrollState){
                return
            }
            if scrollState==0{
                self.lab.text="下拉刷新"
                self.indicator.stopAnimating()
                self.icon.hidden=false
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.icon.transform=CGAffineTransformIdentity
                    }, completion: { (_) -> Void in
                       
                })
            }else if scrollState==1{
                self.lab.text="松开立即刷新"
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.icon.transform=CGAffineTransformMakeRotation(CGFloat(-M_PI))
                    }, completion: { (_) -> Void in

                })
            }else if scrollState==2{
                self.lab.text="刷新中..."
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    var inset = self.sv!.contentInset
                    inset.top+=self.hei
                    self.sv?.contentInset=inset
                    }, completion: { (_) -> Void in

                })
                
                self.sendActionsForControlEvents(.ValueChanged)
                self.indicator.startAnimating()
                self.icon.hidden=true
            }
            
             self.curState=self.scrollState
            
        }
        
    }
    
    
    weak var sv:UIScrollView?
    
    init() {
        super.init(frame: CGRectMake(0,-hei, iScrW, hei))
        addSubview(icon)
        addSubview(lab)
        addSubview(indicator)
        icon.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(0)
            make.centerX.equalTo(-35)
        }
        lab.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(icon.snp_right)
            make.centerY.equalTo(0)
        }
        indicator.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(icon)
        }
        
        
//        backgroundColor=UIColor.randColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        if let sv = newSuperview  as? UIScrollView {
            self.sv=sv
            self.w=sv.w
            sv.addObserver(self, forKeyPath: "contentOffset", options:[.New], context: nil)
            
        }
    }
    
    
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {

        if let p=change?["new"]?.CGPointValue{
            let y=p.y
            let delta=((sv?.contentInset.top ?? 0)+hei)
            if scrollState==2  {
                return
            }
            if y > -delta {
                scrollState=0
            }else if sv!.dragging {
                scrollState=1
            }else if scrollState == 1{
                scrollState=2
                
            }
        }
        
    }
    
    
    func beginRefreshing(){
        scrollState=2
    }
    func endRefreshing(){
        UIImageView.animateWithDuration(0.25, animations: { () -> Void in
            var inset = self.sv!.contentInset
            inset.top-=self.hei
            self.sv?.contentInset=inset
            }) { (b) -> Void in
               self.scrollState=0
        }
        
        
        
    }
    
    deinit{
        self.removeObs()

    }
    func removeObs(){
        sv?.removeObserver(self, forKeyPath: "contentOffset")

    }
    
    
    private lazy var icon:UIImageView=UIImageView(image: iimg("tableview_pull_refresh"))
    private lazy var lab:UILabel=UILabel( txt: "refresh", color: UIColor.grayColor(), font: iFont(13),line: 1)
    
    private lazy var indicator:UIActivityIndicatorView=UIActivityIndicatorView()
}
