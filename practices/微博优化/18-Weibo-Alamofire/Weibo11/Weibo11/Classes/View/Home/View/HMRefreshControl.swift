//
//  HMRefreshControl.swift
//  Weibo11
//
//  Created by itheima on 15/12/11.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit
// 当前控件的高度
private let RefreshControlH: CGFloat = 50

// 定义当前控件的不同的状态

/// <#Description#>
///
/// - Normal:     默认状态或者松开手就回到默认状态
/// - Pulling:    (将要刷新)松开手就进入刷新的这么一个状态
/// - Refreshing: 正在刷新
enum HMRefreshControlState: Int {
    case Normal = 0
    case Pulling = 1
    case Refreshing = 2
}

class HMRefreshControl: UIControl {
    
    // 之前的状态,用于在设置成 normal 的时候,判断上一次是否刷新状态
    var oldHmState: HMRefreshControlState = .Normal;
    
    // 当前控件所处于的状态
    var hmState: HMRefreshControlState = .Normal {
        didSet{
            
            switch hmState {
            case .Pulling:
                printLog("显示`松开刷新`,箭头调转方向")
                messageLabel.text = "放开起飞"
                
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.arrowIcon.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
                })
            case .Refreshing:
                
                printLog("隐藏箭头,显示菊花转,设置文字为`加载中...`")
                messageLabel.text = "正在起飞"
                arrowIcon.hidden = true
                indicator.startAnimating()
                
                // 增加顶部的滑动距离
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    var contentInset = self.scrollView!.contentInset
                    contentInset.top += RefreshControlH
                    self.scrollView?.contentInset = contentInset
                })
                // 发送一个指定操作的这么一个事件
                sendActionsForControlEvents(.ValueChanged)
                
            case .Normal:
                printLog("显示箭头并重置,隐藏菊花转,设置文字为`下拉刷新`")
                messageLabel.text = "下拉起飞"
                arrowIcon.hidden = false
                indicator.stopAnimating()
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.arrowIcon.transform = CGAffineTransformIdentity
                })
                
                // 从刷新状态切换到默认状态才会执行下面的代码
                if oldHmState == .Refreshing {
                    // 增加顶部的滑动距离
                    UIView.animateWithDuration(0.25, animations: { () -> Void in
                        var contentInset = self.scrollView!.contentInset
                        contentInset.top -= RefreshControlH
                        self.scrollView?.contentInset = contentInset
                    })
                }
            }
            oldHmState = hmState
        }
    }
    // 其被添加到的父控件(可以滚动)
    var scrollView: UIScrollView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 结束刷新
    func endRefreshing(){
        hmState = .Normal
    }

    private func setupUI(){
        backgroundColor = UIColor.redColor()
        // 暂时先写到
        var frame = self.frame
        frame.size = CGSizeMake(SCREENW, RefreshControlH)
        frame.origin.y = -RefreshControlH
        self.frame = frame
        
        
        // 添加控件
        addSubview(arrowIcon)
        addSubview(messageLabel)
        addSubview(indicator)
        
        // 添加约束
        arrowIcon.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(self)
            make.centerX.equalTo(self).offset(-35)
        }
        messageLabel.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(arrowIcon)
            make.leading.equalTo(arrowIcon.snp_trailing).offset(5)
        }
        indicator.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(arrowIcon)
        }
        
    }
    
    /// 当前控件将要加到某一个控件上的时候会调用此方法
    ///
    /// - parameter newSuperview: <#newSuperview description#>
    override func willMoveToSuperview(newSuperview: UIView?) {
        printLog(newSuperview)
        // 判断到底能不能滚动
        if let scrollView = newSuperview as? UIScrollView {
            // 利用 KVO 监听 newSuperview 的滚动..contentOffset
            scrollView.addObserver(self, forKeyPath: "contentOffset", options: [NSKeyValueObservingOptions.New], context: nil)
            self.scrollView = scrollView
            
            var frame = self.frame
            frame.size.width = scrollView.frame.width
            self.frame = frame
        }
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
//        printLog(change)
        
        let contentOffsetY = scrollView?.contentOffset.y
        
//        printLog(contentOffsetY)
        let contentInsetTop = scrollView?.contentInset.top ?? 0
//        printLog()
        // 临界值(当前控件是否完否显示的临界值)
        let conditionValue = -contentInsetTop-RefreshControlH
        
        if scrollView!.dragging {
            if hmState == .Normal && contentOffsetY < conditionValue {
                //printLog("进入松手就刷新状态")
                hmState = .Pulling
                //
                // 进入松手就刷的新状态
            }else if hmState == .Pulling && contentOffsetY >= conditionValue{
                // 进入默认状态
                //printLog("进入默认状态")
                hmState = .Normal
            }
        }else{
            // 改成 刷新中 的状态有两个条件 : 首先松手,当前状态是 .Pulling 状态
            // 用户松手的时候会执行
            if hmState == .Pulling {
                hmState = .Refreshing
            }
        }
    }
    
    deinit {
        scrollView?.removeObserver(self, forKeyPath: "contentOffset")
    }
    
    
    // MARK: - 懒加载控件
    // 简单
    private lazy var arrowIcon: UIImageView = UIImageView(image: UIImage(named: "tableview_pull_refresh"))
    // 显示文字的label
    private lazy var messageLabel: UILabel = {
        let label = UILabel(textColor: UIColor.grayColor(), fontSize: 12)
        label.text = "下拉刷新"
        return label
    }()
    // 菊花转
    private lazy var indicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
}
