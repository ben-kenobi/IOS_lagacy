//
//  CommonListItemCell.swift
//  am
//
//  Created by apple on 16/5/24.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class CommonListItemCell: UITableViewCell {
    static let celliden="contenttviden"

    var mod:[String:AnyObject]?{
        didSet{
            updateUI()
        }
    }
    lazy var textLab: UILabel={
        let textLab = UILabel(align: NSTextAlignment.Left, line: 0)
        
        return textLab
    }()
    
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.selectionStyle = .None
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension CommonListItemCell{
   class func cellWith(tv:UITableView,mod:[String:AnyObject],idx:NSIndexPath)->CommonListItemCell{
       let cell =  tv.dequeueReusableCellWithIdentifier(celliden, forIndexPath: idx) as! CommonListItemCell
        cell.mod=mod
        return cell
    }
    
    func updateUI(){
       
    }
    func initUI(){
        backgroundColor=UIColor.clearColor()
        let bg  = UIView()
        bg.backgroundColor=iConst.khakiBg
        contentView.addSubview(bg)
        bg.snp_makeConstraints { (make) in
            make.top.equalTo(4)
            make.bottom.equalTo(-1)
            make.left.equalTo(5)
            make.right.equalTo(-5)
        }
        bg.layer.cornerRadius=5
        bg.layer.borderColor=iColor(0xff888888).CGColor
        bg.layer.borderWidth=1
        
        
        bg.addSubview(textLab)
        
        textLab.lineBreakMode = .ByCharWrapping
        textLab.snp_makeConstraints { (make) in
            make.top.equalTo(5)
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.bottom.equalTo(-9)
        }
        
        let selv = UIView()
        self.selectedBackgroundView=selv
        let selbg  = UIView()
        selbg.backgroundColor=iColor(130,205,248)
        selv.addSubview(selbg)
        selbg.snp_makeConstraints { (make) in
            make.top.equalTo(4)
            make.bottom.equalTo(-1)
            make.left.equalTo(5)
            make.right.equalTo(-5)
        }
        selbg.layer.cornerRadius=5
        selbg.layer.borderColor=iColor(0xff888888).CGColor
        selbg.layer.borderWidth=1
        
    }
}
