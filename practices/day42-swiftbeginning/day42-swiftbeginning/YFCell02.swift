


//
//  YFCell02.swift
//  day42-swiftbeginning
//
//  Created by apple on 15/12/4.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class YFCell02: UITableViewCell {
    
    lazy var fm:NSDateFormatter={
        let f=NSDateFormatter()
        f.dateFormat="yyyy-MM-dd HH:mm:ss"
        return f
    }()
    
    var m:Modle?{
        didSet{
            name?.text=m?.name
            age?.text="\(m?.age ?? 0)"
            time?.text=fm.stringFromDate(m?.time ?? NSDate())
        }
    }
    
     var name:UILabel?
     var age:UILabel?
     var time:UILabel?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:reuseIdentifier)
        self.initUI()
        
    }
    
    func initUI(){
        let pad:CGFloat = 10
        name=UILabel(frame: CGRect(x: pad, y: pad, width: 100, height: 20))
        age=UILabel(frame: CGRect(x: pad, y: name!.b()+pad, width: 100, height: 20))
        time=UILabel(frame: CGRect(x: age!.r()+pad*3, y: age!.y(), width: 180, height: 20))
        contentView.addSubview(name!)
        contentView.addSubview(age!)
        contentView.addSubview(time!)
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
