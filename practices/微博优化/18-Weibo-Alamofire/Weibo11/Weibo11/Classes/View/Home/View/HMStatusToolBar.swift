//
//  HMStatusToolBar.swift
//  Weibo11
//
//  Created by itheima on 15/12/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

class HMStatusToolBar: UIView {
    
    var retweetButton: UIButton?
    var commentButton: UIButton?
    var unlikeButton: UIButton?
    
    var statusViewModel: HMStatusViewModel? {
        didSet{
            // 设置数据
//            printLog(statusViewModel?.status?.reposts_count)
            
            // 取到三个按钮,设置按钮上的文字
            retweetButton?.setTitle(statusViewModel?.retweetCountStr, forState: .Normal)
            commentButton?.setTitle(statusViewModel?.commentCountStr, forState: .Normal)
            unlikeButton?.setTitle(statusViewModel?.attitudeCountStr, forState: .Normal)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 设置视图
    private func setupUI(){
        
        // 添加三个按钮
        retweetButton = addChildButton("转发", imgName: "timeline_icon_retweet")
        commentButton = addChildButton("评论", imgName: "timeline_icon_comment")
        unlikeButton = addChildButton("赞", imgName: "timeline_icon_unlike")
        
        // 添加两个分割线
        let sp1 = addSeparator()
        let sp2 = addSeparator()
        

        // 添加约束
        retweetButton?.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.width.equalTo(commentButton!)
        }
        
        commentButton?.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(retweetButton!.snp_trailing)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.width.equalTo(unlikeButton!)
        }
        
        unlikeButton?.snp_makeConstraints { (make) -> Void in
            make.trailing.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.leading.equalTo(commentButton!.snp_trailing)
        }
        
        // 添加分割线的约束
        sp1.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(retweetButton!.snp_trailing)
            make.centerY.equalTo(self)
        }
        sp2.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(commentButton!.snp_trailing)
            make.centerY.equalTo(self)
        }
    }
    
    /// 添加三个按钮
    ///
    /// - parameter title:   默认文字
    /// - parameter imgName: 图片名字
    ///
    /// - returns: 返回当前添加的按钮
    private func addChildButton(title: String, imgName: String) -> UIButton {
        let button = UIButton()
        // 设置文字,字体大小,不同状态的字体颜色
        button.setTitle(title, forState: .Normal)
        button.setTitleColor(UIColor.grayColor(), forState: .Normal)
        button.setTitleColor(UIColor.darkGrayColor(), forState: .Highlighted)
        button.titleLabel?.font = UIFont.systemFontOfSize(14)
        // 设置图标
        button.setImage(UIImage(named: imgName), forState: .Normal)
        // 设置不同状态下的背景图片
        button.setBackgroundImage(UIImage(named: "timeline_card_bottom_background_highlighted"), forState: UIControlState.Highlighted)
        button.setBackgroundImage(UIImage(named: "timeline_card_bottom_background"), forState: UIControlState.Normal)
        
        addSubview(button)
        return button
    }
    
    // 添加分割线
    private func addSeparator() -> UIView {
        let imageView = UIImageView(image: UIImage(named: "timeline_card_bottom_line"))
        addSubview(imageView)
        return imageView
    }
    
}
