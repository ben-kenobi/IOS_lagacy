//
//  HMStatusCell.swift
//  Weibo11
//
//  Created by itheima on 15/12/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit
import SnapKit
/**
    整个 cell 分成三大块:原创微博的内容,转发微博的内容,底部显示转发评论赞的 toolBar
*/
// cell 内部子控件共同的间距
let HMStatusCellMargin: CGFloat = 8
// 昵称的字体大小
let HMStatusNameFontSize: CGFloat = 14
// 时间与来源的字体大小
let HMStatusTimeFontSize: CGFloat = 10
// 内容字体大小
let HMStatusContentFontSize: CGFloat = 15

/// 工具栏高度
let HMStatusToolbarHeight: CGFloat = 35
/// 头像宽高
let HMStatusIconWH: CGFloat = 35

class HMStatusCell: UITableViewCell {
    
    // toolBar 顶部的约束
    var toolBarTopConstraint: Constraint?
    
    var statusViewModel: HMStatusViewModel? {
        didSet{
            // 当 `外界` 设置这个属性的时候,会调用 didSet
            // 也就是说我们可以在这个方法里面填充控件内容
            originalView.statusViewModel = statusViewModel
            statusToolBar.statusViewModel = statusViewModel
            
            // 先移除当前top的约束
            toolBarTopConstraint?.uninstall()
            // SnapKit 更新约束适用于
            if statusViewModel?.status?.retweeted_status != nil {
                // 转发微博存在.
                // 需要将其显示.因为cell是可以复用的
                retweetView.hidden = false
                retweetView.statusViewModel = statusViewModel
                // 更新约束
                
                statusToolBar.snp_updateConstraints(closure: { (make) -> Void in
                    self.toolBarTopConstraint = make.top.equalTo(retweetView.snp_bottom).constraint
                })
            }else {
                // 转发微博不存在
                retweetView.hidden = true
                // 更新约束
                statusToolBar.snp_updateConstraints(closure: { (make) -> Void in
                    self.toolBarTopConstraint = make.top.equalTo(originalView.snp_bottom).constraint
                })
            }
            
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // 设置视图
    private func setupUI(){
        contentView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        // 1. 添加 View
        contentView.addSubview(originalView)
        contentView.addSubview(retweetView)
        contentView.addSubview(statusToolBar)
        
        // 2. 添加约束
        // 原创微博的 View
        originalView.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(contentView)
            make.top.equalTo(contentView).offset(HMStatusCellMargin)
            make.trailing.equalTo(contentView)
        }
        
        // 转发微博
        retweetView.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(originalView)
            make.top.equalTo(originalView.snp_bottom)
            make.trailing.equalTo(originalView)
        }
        
        // 底部 toolBar
        statusToolBar.snp_makeConstraints { (make) -> Void in
            self.toolBarTopConstraint = make.top.equalTo(retweetView.snp_bottom).constraint
            make.leading.equalTo(contentView)
            make.width.equalTo(contentView)
            make.height.equalTo(35)
        }
        
        // 非常重要,而约束不能少
        contentView.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(statusToolBar)
            make.top.equalTo(self)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
        }
    }
 
    
    // MARK: - 懒加载
    private lazy var originalView: HMStatusOriginalView = {
        let view = HMStatusOriginalView()
        view.backgroundColor = UIColor.whiteColor()
        return view
    }()
    // 底部 toolBar
    private lazy var statusToolBar: HMStatusToolBar = HMStatusToolBar()
    // 转发微博 view
    private lazy var retweetView: HMStatusRetweetView = HMStatusRetweetView()
//    // 分割的view
//    private lazy var spliteView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
//        return view
//    }()
}
