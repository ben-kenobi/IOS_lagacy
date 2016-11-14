//
//  MenuCell.swift
//  anquanguanli
//
//  Created by apple on 16/3/22.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    
    lazy var icon:UIImageView=UIImageView()
    lazy var title:UILabel=UILabel()
    
    var mod:[String:String]?{
        didSet{
            if let mod=mod{
                icon.image=iimg(mod["icon"])
                title.text=mod["title"]
            }
        }
    }
    
    func initUI(){
        selectedBackgroundView=UIView()

//        selectionStyle = .None
        
        let v=UIView()
        contentView.addSubview(v)
//        contentView.backgroundColor=UIColor.clearColor()
        backgroundColor=UIColor.clearColor()
        v.addSubview(icon)
        v.addSubview(title)
        v.layer.cornerRadius=5
        v.layer.borderWidth=0.7
        v.layer.borderColor=UIColor.grayColor().CGColor
        v.layer.backgroundColor=UIColor.whiteColor().CGColor
        v.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(contentView).offset(-10)
        }

        
        icon.snp_makeConstraints { (make) -> Void in
            make.width.height.equalTo(55)
            make.centerY.equalTo(0)
            make.left.equalTo(20)
        }
        title.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(0)
            make.left.equalTo(icon.snp_right).offset(20)
        }
        
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
