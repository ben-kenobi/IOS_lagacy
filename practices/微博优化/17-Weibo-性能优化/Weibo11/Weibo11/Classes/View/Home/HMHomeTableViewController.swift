//
//  HMHomeTableViewController.swift
//  Weibo11
//
//  Created by itheima on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit
import SVProgressHUD

/// cell 的可重用标识符
private let HMStatusCellIdentifier = "CELL"

class HMHomeTableViewController: HMVisitorTableViewController {

    // 首页微博数据的视图模型
    var statusListViewModel: HMStatusListViewModel = HMStatusListViewModel()
    
    // MARK: - 设置视图
    override func viewDidLoad() {
        super.viewDidLoad()

        if !userLogin {
            visitorView?.setVisitorInfo(nil, message: nil)
            return
        }
        
        printLog(pullDownTipLabel)
        // 设置视图
        setupUI()
        // 加载数据
        loadData()
        
    }
    
    /**
    设置界面
    */
    private func setupUI(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(imgName: "navigationbar_friendsearch", target: self, action: "friendsearch")
        navigationItem.rightBarButtonItem = UIBarButtonItem(imgName: "navigationbar_pop", target: self, action: "friendsearch")
        
        // 设置tableView
        setupTableView()
    }
    
    /// 与 tableview 相关设置
    private func setupTableView(){
        // 注册 cell
        tableView.registerClass(HMStatusCell.self, forCellReuseIdentifier: HMStatusCellIdentifier)
        
        // 设置 cell 高度
        // 设置自动计算行高
        // 会根据 contentView 的底部的最大y值去设置成 行高
        // UITableViewAutomaticDimension 的默认值就是 UITableViewAutomaticDimension
//        tableView.rowHeight = UITableViewAutomaticDimension
        // 设置预估高度,以让tableView能滚动
        // 越接近真实行高越好
        tableView.estimatedRowHeight = 200
        // 隐藏分割线
        tableView.separatorStyle = .None
        // 设置上拉加载的控件
        tableView.tableFooterView = pullUpView
        
        hmRefreshControl.addTarget(self, action: "loadData", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(hmRefreshControl)
    }
    
    /// 演示系统的 UIRefreshControl 使用
    ///
    /// - parameter refreshControl: <#refreshControl description#>
    func test(refreshControl: HMRefreshControl){
        printLog("刷新方法执行了")
        // 过5秒之后再回调
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), { () -> Void in
            printLog("结束加载")
            refreshControl.endRefreshing()
        })
    }
    
    @objc private func friendsearch(){
        let vc = HMTempViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - 懒加载控件
    private lazy var pullUpView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        view.color = UIColor.redColor()
        view.sizeToFit()
        // 自已下去写的时候,可能会碰见,startAnimating 能看见,但是,底部空间没有
        // view.startAnimating()
        return view
    }()
    // 刷新控件
    private var hmRefreshControl: HMRefreshControl = HMRefreshControl()
    
    // 下拉刷新的提示控件搞定了
    private lazy var pullDownTipLabel: UILabel = {
        let label = UILabel()
        // 设置背景
        label.backgroundColor = UIColor.orangeColor()
        // 文字颜色以及大小以及居中
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.systemFontOfSize(12)
        label.textAlignment = .Center
        // 默认隐藏
        label.hidden = true
        
        var frame = label.frame
        frame.size = CGSizeMake(SCREENW, 35)
        frame.origin.y = 64 - 35
        label.frame = frame
        
        // 添加控件
        
        return label
    }()
}

// MARK: - tableView delegate & dataSource
extension HMHomeTableViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusListViewModel.statusList?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 会去缓存中取,如果没有取到,返回 nil
        // 这一句,会去缓存中取,如果没有取到,直接帮我创建,以后开发中,尽量使用这种方式(前提:得注册cell)
        let cell = tableView.dequeueReusableCellWithIdentifier(HMStatusCellIdentifier, forIndexPath: indexPath) as! HMStatusCell
        // 设置数据
        cell.statusViewModel = statusListViewModel.statusList![indexPath.row]
        return cell
    }
    
    /// 将要显示某一个cell的时候会回调这个方法
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        // 判断如果当前加载的是最后一个cell.就去加载更多
        // 如果当前正在加载更多,就不需要再次进入
        if !pullUpView.isAnimating() && indexPath.row == statusListViewModel.statusList!.count - 1 {
            printLog("加载到最后一条了")
            pullUpView.startAnimating()
            // 加载更多的数据
            loadData()
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        // 返回缓存的行高
        return statusListViewModel.statusList![indexPath.row].rowHeight
    }
}

// MARK: - 加载数据
extension HMHomeTableViewController {
    
    /// 加载微博数据
    @objc private func loadData(){
        // isPullUp --> 就是代表是否是上拉加载的数据,如果是(pullUpView.isAnimating())
        statusListViewModel.loadData(pullUpView.isAnimating()) { (isSuccess, count) -> () in
            // 只要执行在这个地方,就代表数据已经请求完成(不管是否请求成功)
            // 停止 pullUpView 的动画
            if isSuccess {
                self.tableView.reloadData()
                // 根据 count 显示不同的文字
                
                // 如果判断到是上拉加载的话,不做显示ti的操作
                if !self.pullUpView.isAnimating() {
                    self.showPullDownTips(count)
                }
            }else {
                SVProgressHUD.showErrorWithStatus("请求失败")
            }
            self.endLoad()
        }
    }
    // 结束刷新
    private func endLoad(){
        pullUpView.stopAnimating()
        hmRefreshControl.endRefreshing()
    }
    // 显示下拉刷新的提示
    private func showPullDownTips(count: Int){
        
        // 如果当前控件正在执行动画,直接返回
        if self.pullDownTipLabel.hidden == false {
            return
        }
        
        // 判断当前控件是否被添加到指定位置
        if self.pullDownTipLabel.superview == nil {
            if let navCtrl = self.navigationController {
                navCtrl.view.insertSubview(self.pullDownTipLabel, belowSubview: navCtrl.navigationBar)
            }
        }
        
        if count == 0 {
            self.pullDownTipLabel.text = "没有微博数据"
        }else{
            self.pullDownTipLabel.text = "加载了\(count)条数据"
        }
        
        // 执行动画
        pullDownTipLabel.hidden = false
        
        UIView.animateWithDuration(1, animations: { () -> Void in
            self.pullDownTipLabel.transform = CGAffineTransformMakeTranslation(0, self.pullDownTipLabel.frame.height)
        }) { (_) -> Void in
            
            // 停留一秒再执行另外 的一个动画
            
            UIView.animateKeyframesWithDuration(1, delay: 1, options: [], animations: { () -> Void in
                self.pullDownTipLabel.transform = CGAffineTransformIdentity
            }, completion: { (_) -> Void in
                 self.pullDownTipLabel.hidden = true
            })
        }
    }
}







