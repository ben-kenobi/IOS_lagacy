
//
//  YFTvCell.swift
//  day42-swiftbeginning
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class YFTvCell: UITableViewCell {
    var namel:UILabel?
    var agel:UILabel?
    var m:Person?{
        didSet{
            namel?.text=m?.name
            agel?.text="\(m?.age ?? 0)"
        }
    }
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        let pad:CGFloat=10
        namel=UILabel(frame: CGRect(x: pad, y: pad, width: 100, height: 20))
        agel=UILabel(frame:CGRect(x: pad, y: pad+20+pad, width: 100, height: 10))
        namel?.font=UIFont.systemFontOfSize(17)
        agel?.font=UIFont.systemFontOfSize(13)
        agel?.textColor=UIColor.grayColor()
       
        super.init(style: style,reuseIdentifier: reuseIdentifier)
        addSubview(namel!)
        addSubview(agel!)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
