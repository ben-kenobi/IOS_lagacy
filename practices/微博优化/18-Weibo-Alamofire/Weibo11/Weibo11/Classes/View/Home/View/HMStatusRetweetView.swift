//
//  HMStatusRetweetView.swift
//  Weibo11
//
//  Created by itheima on 15/12/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit
import SnapKit

class HMStatusRetweetView: UIView {
    
    
    // 当前视图的底部约束
    var bottomConstraint: Constraint?
    
    var statusViewModel: HMStatusViewModel? {
        didSet {
            // contentLabel.text = statusViewModel?.retweetText
            contentLabel.attributedText = statusViewModel?.retweetedStatusAttr
            contentLabel.linkResults = statusViewModel?.retweetedLinkResults
            // 判断是否有图,如果有图
            // --> 1. 让其显示出来;2.更新约束;3.设置数据
            self.bottomConstraint?.uninstall()
            if let pic_urls = statusViewModel?.status?.retweeted_status?.pic_urls where pic_urls.count > 0 {
                // 设置数据
                pictureView.setPicInfo(pic_urls, viewSize: statusViewModel!.pictureViewSize)
                
                // 显示
                pictureView.hidden = false
                // 更新约束
                snp_updateConstraints(closure: { (make) -> Void in
                    self.bottomConstraint = make.bottom.equalTo(pictureView).offset(HMStatusCellMargin).constraint
                })
            }else{
                // 1. 让其隐藏;2.更新约束
                pictureView.hidden = true
                // 2. 更新约束
                snp_updateConstraints(closure: { (make) -> Void in
                    self.bottomConstraint = make.bottom.equalTo(contentLabel).offset(HMStatusCellMargin).constraint
                })
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 设置视图
    private func setupUI(){
        backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        // 添加控件
        addSubview(contentLabel)
        addSubview(pictureView)
        
        // 添加约束
        contentLabel.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(self).offset(HMStatusCellMargin)
            make.top.equalTo(self).offset(HMStatusCellMargin)
            make.trailing.equalTo(self).offset(-HMStatusCellMargin)
        }
        // 配图的约束
        pictureView.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(contentLabel)
            make.top.equalTo(contentLabel.snp_bottom).offset(HMStatusCellMargin)
        }
        
        // 当前控件的高与内容的高度一样的
        self.snp_makeConstraints { (make) -> Void in
            self.bottomConstraint = make.bottom.equalTo(pictureView).offset(HMStatusCellMargin).constraint
        }
    }
    
    
    // MARK: - 懒加载
    private lazy var contentLabel: HMStatusLabel = HMStatusLabel(textColor: UIColor.darkGrayColor(), fontSize: HMStatusContentFontSize, maxWidth: SCREENW - 2 * HMStatusCellMargin)
    
    // 配图View
    private lazy var pictureView: HMStatusPictureView = {
        let view = HMStatusPictureView()
        view.backgroundColor = self.backgroundColor
        return view
    }()
    
}
