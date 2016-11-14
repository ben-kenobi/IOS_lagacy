//
//  HMTabBar.swift
//  Weibo11
//
//  Created by itheima on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit
// 如果想要代理用 weak 修饰的话,必须要继承基协议 NSObjectProtocol
//protocol HMTabBarDeletate: NSObjectProtocol{
//    
//    func composeButtonClick()
//}

class HMTabBar: UITabBar {
    
    // weak var delegatess: HMTabBarDeletate?
    
    // 定义闭包的变量
    var composeButtonClosure: (()->())?
    
    // MARK: - 设置 UI

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    // 如果重写 init:frame 这个方法,必须要实现 init:coder
    // 如果当前 View 从 xib / sb 里面加载出来的话,就会调用这个方法
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // 设置UI内容
    func setupUI(){
        backgroundImage = UIImage(named: "tabbar_background")
        // 添加撰写按钮
        addSubview(composeButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 调整撰写按钮位置
        // 在开发过程中,如果子控件要居中,不要使用父控件的center
        composeButton.center = CGPoint(x: frame.width * 0.5, y: frame.height * 0.5)
        
        // UITabBarButton 的宽度
        let childW = frame.width / 5
        
        var index = 0
        
        for childView in subviews {
            // UITabBarButton 是一个私有的控件,不能直接获取 class
            if childView.isKindOfClass(NSClassFromString("UITabBarButton")!) {
                // 设置宽度
                
                // 计算 x 值
                let x = CGFloat(index) * childW
                childView.frame = CGRect(x: x, y: 0, width: childW, height: frame.height)
                
                // 递增
                index++
                
                // 如果当前是第2个按钮(从0开始),加加
                if index == 2 {
                    index++
                }
            }
        }
    }
    
    // MARK: - 监听事件
    @objc private func composeButtonClick(){
        printLog("撰写按钮点击")
        // 执行闭包
        composeButtonClosure?()
    }
    
    
    // MARK: - 懒加载控件
    
    // 撰写按钮
    lazy var composeButton: UIButton = {
        
        let button = UIButton()
        // 添加点击事件
        button.addTarget(self, action: "composeButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        // 设置按钮的背景图片
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: .Normal)
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: .Highlighted)
        
        // 设置不同状态的图片
        button.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        button.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        
        // 设置button大小
        button.sizeToFit()
        
        return button
    }()
    
    
}
