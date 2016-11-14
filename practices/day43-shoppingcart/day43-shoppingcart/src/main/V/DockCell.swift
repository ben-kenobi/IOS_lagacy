



//
//  DockCell.swift
//  day43-shoppingcart
//
//  Created by apple on 15/12/14.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class DockCell: UITableViewCell {

    lazy var lab:UILabel={
        let lab=UILabel( font: iFont(16), align: NSTextAlignment.Center, line: 1)
        return lab
    }()
    
    lazy var showV:UIView=UIView()
    
    var title:String?{
        didSet{
          lab.text=title
        }
    }
    
    override func drawRect(rect: CGRect) {
        let con = UIGraphicsGetCurrentContext()
        iColor(0, g: 0, b: 0,a: 0.4).setFill()
        CGContextAddRect(con, CGRectMake(0, h()-0.5, w(), 0.5))
        CGContextDrawPath(con, .Fill)
        if selected {
            CGContextAddRect(con, CGRectMake(0, 0, 2, h()))
            iColor(255, g: 127, b: 0).setFill()
            CGContextDrawPath(con, .Fill)
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle=UITableViewCellSelectionStyle.None

        contentView.addSubview(lab)
        lab.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(0)
        }

        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setNeedsDisplay()
        backgroundColor=selected ? iColor(246, g: 246, b: 246) : iColor(255, g: 255, b: 255)
        lab.textColor=selected ? iColor(255, g: 127, b: 0):iColor(50, g: 50, b: 50)
    }
    


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
