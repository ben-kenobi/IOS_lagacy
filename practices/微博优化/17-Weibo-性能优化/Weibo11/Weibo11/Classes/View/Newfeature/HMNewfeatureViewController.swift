//
//  HMNewfeatureViewController.swift
//  Weibo11
//
//  Created by itheima on 15/12/8.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

class HMNewfeatureViewController: UIViewController, UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupUI()

    }
    
    /// 视图初始化
    private func setupUI(){
        // 添加 ScrollView
        scrollView.frame = view.bounds
        view.addSubview(scrollView)
        pageControl.frame = CGRect(x: scrollView.frame.width * 0.5  , y: scrollView.frame.height - 100, width: 0, height: 0)
        view.addSubview(pageControl)
        
        // 往 scrollView 里面添加4个张图片
        
        let count = 4
        
        for i in 0..<count {
            // 初始化 imageView
            let imageView = UIImageView(image: UIImage(named: "new_feature_\(i + 1)"))
            // 设置大小
            imageView.frame = CGRect(x: CGFloat(i) * scrollView.frame.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
            scrollView.addSubview(imageView)
            
            // 判断如果是最后一页,设置最后一页的内容
            if i == count-1 {
                setupLastPage(imageView)
            }
        }
        // 设置内容大小(滚动范围)
        scrollView.contentSize = CGSize(width: CGFloat(count) * scrollView.frame.width, height: 0)
        
        // 页数
        pageControl.numberOfPages = count
        
    }
    
    
    /// 设置最后一页的内容
    ///
    /// - parameter lastPage: 最后一页的view
    private func setupLastPage(lastPage: UIView){
        // lastPage 开启用户交互
        lastPage.userInteractionEnabled = true
        enterButton.center = CGPoint(x: lastPage.frame.width * 0.5, y: lastPage.frame.height - 150)
        sharedButton.center = CGPoint(x: enterButton.center.x, y: CGRectGetMinY(enterButton.frame) - 30)
        
        // 添加子控件
        lastPage.addSubview(enterButton)
        lastPage.addSubview(sharedButton)
        
    }
    
    // MARK: - 按钮点击事件
    
    
    @objc private func sharedButtonClick(button: UIButton){
        button.selected = !button.selected
    }
    
    @objc private func enterButtonClick(){
        // 执行进入微博(切换界面)
        printLog("enterButtonClick")
        NSNotificationCenter.defaultCenter().postNotificationName(HMSwitchRootVCNotification, object: nil)
    }
    
    // MARK: - scrollView delegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        // 计算当前滑动到第 x 页 (四舍五入)
        let page = scrollView.contentOffset.x / scrollView.frame.width + 0.5
        printLog(page)
        pageControl.currentPage = Int(page)
//        printLog(scrollView.contentOffset)
    }

    // MARK: - 懒加载控件
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        // 设置代理
        scrollView.delegate = self
        // 开启分页
        scrollView.pagingEnabled = true
        // 关闭边缘的弹簧效果
        scrollView.bounces = false
        // 隐藏滚动条
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    // 分页控件
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        // 默认情况下,子控件如果超出父控件的范围,是可以看得到.
        // 指定 clipsToBounds 代表把超出部分干掉
        // pageControl.clipsToBounds = true
        // 指定选中颜色
        pageControl.currentPageIndicatorTintColor = UIColor.orangeColor()
        // 指定默认颜色
        pageControl.pageIndicatorTintColor = UIColor.purpleColor()
        return pageControl
    }()
    
    // 进入按钮
    private lazy var enterButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: "enterButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        // 设置不同状态的图片
        button.setBackgroundImage(UIImage(named: "new_feature_finish_button_highlighted"), forState: UIControlState.Highlighted)
        button.setBackgroundImage(UIImage(named: "new_feature_finish_button"), forState: UIControlState.Normal)
        button.setTitle("进入微博", forState: UIControlState.Normal)
        // 内容多大,按钮多大
        button.sizeToFit()
        return button
    }()
    
    
    // 进入按钮
    private lazy var sharedButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: "sharedButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        // 设置不同状态的图片
        button.setImage(UIImage(named: "new_feature_share_true"), forState: UIControlState.Selected)
        button.setImage(UIImage(named: "new_feature_share_false"), forState: UIControlState.Normal)
        button.setTitle(" 分享到微博", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
//        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: -5)
        // 内容多大,按钮多大
        button.sizeToFit()
        return button
    }()

}
