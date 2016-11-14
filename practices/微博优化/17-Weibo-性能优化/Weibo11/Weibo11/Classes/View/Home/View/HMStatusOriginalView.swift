//
//  HMStatusOriginalView.swift
//  Weibo11
//
//  Created by itheima on 15/12/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit
import SnapKit

/// 原创微博内容的 view
class HMStatusOriginalView: UIView {
    
    // 当前视图的底部约束
    var bottomConstraint: Constraint?

    var statusViewModel: HMStatusViewModel? {
        didSet{
            // 设置头像
            iconView.sd_setImageWithURL(NSURL(string: (statusViewModel?.status?.user?.profile_image_url)!), placeholderImage: UIImage(named: "avatar_default_big"))
            // 设置昵称
            nameLabel.text = statusViewModel?.status?.user?.name
            
            // TODO: 设置创建时间,先写死, 后面会做特殊处理
            
            sourceLabel.text = statusViewModel?.sourceText
            timeLabel.text = statusViewModel?.createAtText
            // 设置会员图标以及认证
            vipImageView.image = statusViewModel?.vipImage
            verifiedImageView.image = statusViewModel?.verifiedImage
            
            // 设置原创微博内容
            // contentLabel.text = statusViewModel?.status?.text
            contentLabel.attributedText = statusViewModel?.originalStatusAttr
            contentLabel.linkResults = statusViewModel?.originalLinkResults
            
            // 设置原创微博的配图
            bottomConstraint?.uninstall()
            // 如果有配图:1.设置数据,2.显示控件,3.更新约束
            if let pic_urls = statusViewModel?.status?.pic_urls where pic_urls.count > 0 {
                // 设置数据
                pictureView.setPicInfo(pic_urls, viewSize: statusViewModel!.pictureViewSize)
                
                // 显示控件
                pictureView.hidden = false
                // 更新约束
                self.snp_updateConstraints(closure: { (make) -> Void in
                    self.bottomConstraint = make.bottom.equalTo(pictureView).offset(HMStatusCellMargin).constraint
                })
            }else{
                pictureView.hidden = true
                // 更新约束
                self.snp_updateConstraints(closure: { (make) -> Void in
                    self.bottomConstraint = make.bottom.equalTo(contentLabel).offset(HMStatusCellMargin).constraint
                })
            }
            
            
            // 没有:1.隐藏控件,2.更新约束
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI(){
        // 1. 添加控件
        addSubview(iconView)
        addSubview(nameLabel)
        addSubview(vipImageView)
        addSubview(timeLabel)
        addSubview(sourceLabel)
        addSubview(verifiedImageView)
        addSubview(contentLabel)
        addSubview(pictureView)
        
        // 2. 添加约束
        iconView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(HMStatusCellMargin)
            make.leading.equalTo(self).offset(HMStatusCellMargin)
            make.size.equalTo(CGSizeMake(HMStatusIconWH, HMStatusIconWH))
        }
        // 昵称的label
        nameLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(iconView)
            make.leading.equalTo(iconView.snp_trailing).offset(HMStatusCellMargin)
        }
        // 会员图标
        vipImageView.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(nameLabel)
            make.leading.equalTo(nameLabel.snp_trailing).offset(HMStatusCellMargin)
        }
        // 时间
        timeLabel.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(iconView)
            make.leading.equalTo(nameLabel)
        }
        // 来源
        sourceLabel.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(timeLabel)
            make.leading.equalTo(timeLabel.snp_trailing).offset(HMStatusCellMargin)
        }
        // 认证
        verifiedImageView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(iconView.snp_trailing)
            make.centerY.equalTo(iconView.snp_bottom)
        }
        
        // 原创微博内容
        contentLabel.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(iconView)
            make.trailing.equalTo(self).offset(-HMStatusCellMargin)
            make.top.equalTo(iconView.snp_bottom).offset(HMStatusCellMargin)
        }
        // 配图
        pictureView.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(contentLabel)
            make.top.equalTo(contentLabel.snp_bottom).offset(HMStatusCellMargin)
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        
        // 关键
        snp_makeConstraints { (make) -> Void in
            self.bottomConstraint = make.bottom.equalTo(pictureView).offset(HMStatusCellMargin).constraint
        }
    }
    
    
    // MARK: - 懒加载控件
    // 头像控件
    private lazy var iconView: UIImageView = UIImageView(image: UIImage(named: "avatar_default_big"))
    
    // 昵称label
    private lazy var nameLabel: UILabel = UILabel(textColor: UIColor.darkGrayColor(), fontSize: HMStatusNameFontSize)
    // 时间
    private lazy var timeLabel: UILabel = UILabel(textColor: UIColor.orangeColor(), fontSize: HMStatusTimeFontSize)
    // 来源
    private lazy var sourceLabel: UILabel = UILabel(textColor: UIColor.lightGrayColor(), fontSize: HMStatusTimeFontSize)
    // 会员图标
    private lazy var vipImageView: UIImageView = UIImageView(image: UIImage(named: "common_icon_membership"))
    // 认证
    private lazy var verifiedImageView: UIImageView = UIImageView(image: UIImage(named: "avatar_vip"))
    
    // 微博内容
    private lazy var contentLabel: HMStatusLabel = HMStatusLabel(textColor: UIColor.darkGrayColor(), fontSize: HMStatusContentFontSize, maxWidth: SCREENW - 2 * HMStatusCellMargin)
    
    // 初始化一个原创微博的配图控件
    private lazy var pictureView: HMStatusPictureView = {
        let view = HMStatusPictureView()
        view.backgroundColor = self.backgroundColor
        return view
    }()
}
