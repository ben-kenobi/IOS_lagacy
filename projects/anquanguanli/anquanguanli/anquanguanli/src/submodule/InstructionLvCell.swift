//
//  InstructionLvCell.swift
//  anquanguanli
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 apple. All rights reserved.
//



class InstructionLvCell: UITableViewCell {
    lazy var title:UILabel=UILabel(color: iColor(50, g: 50, b: 50), font: iFont(20), align:NSTextAlignment.Left, line: 0)
    
    lazy var sub:UILabel=UILabel(color: iColor(150, g: 150, b: 150), font: iFont(17), align:NSTextAlignment.Left, line: 1)
    
    var mod:[String:String]?{
        didSet{
            if let mod=mod{
                sub.text=mod["sendDate"]
                title.text=mod["content"]
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
        v.addSubview(title)
        v.addSubview(sub)
        v.layer.cornerRadius=5
        v.layer.borderWidth=0.7
        v.layer.borderColor=UIColor.grayColor().CGColor
        v.layer.backgroundColor=UIColor.whiteColor().CGColor
        v.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(0)
        }
        
        title.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(5)
            make.right.equalTo(-10)
            make.left.equalTo(10)
        }
        sub.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(title.snp_bottom).offset(0)
            make.bottom.equalTo(-5)
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
