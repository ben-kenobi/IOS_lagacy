//
//  ProgressV.swift
//  EqApp
//
//  Created by apple on 16/9/16.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class ProgressV: UIView {
    var total:CGFloat=100
    var progress:CGFloat = 0{
        didSet{
            updateProgress()
        }
    }
    
    lazy var progV:UIView={
        let v = UIView(frame: nil, bg: iColor(0xff2288ee))
        return v
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(progV)
        progV.snp_makeConstraints { (make) in
            make.top.left.equalTo(1)
            make.height.equalTo(self.snp_height).offset(-2)
            make.width.equalTo(0)
        }
        updateProgress()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func updateProgress(){
        
        dispatch_async(dispatch_get_main_queue()) { 
            self.progV.w=(self.w*self.progress)/self.total
            
        }
    }
}
