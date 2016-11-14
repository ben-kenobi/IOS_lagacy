//
//  HMVisitorView.swift
//  Weibo11
//
//  Created by itheima on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit
import SnapKit

//protocol HMVisitorViewDelegate: NSObjectProtocol{
//    // 注册
//    func registerButtonDidSelected()
//    // 登录
//    func loginButtonDidSelected()
//}


class HMVisitorView: UIView {
    
//    weak var delegate:HMVisitorViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - 执行逻辑
    
    /// 供外界调用,设置图标以及消息文字的方法
    func setVisitorInfo(imgName: String?, message: String?){
        
        if let img = imgName, msg = message {
            // 只有 消息.发现.我 这三个页面,才会执行到这个地方
            // 隐藏 圆圈
            circleView.hidden = true
            iconView.image = UIImage(named: img)
            messageLabel.text = msg
        }else{
            startAnim()
        }
    }
    
    private func startAnim(){
        // 初始化动画
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        // 旋转360
        anim.toValue = 2 * M_PI
        // 设置执行时间
        anim.duration = 20
        // 重复次数
        anim.repeatCount = MAXFLOAT
        // 在切换 tabbar 或者 将应用切换到后台, anim 会被释放
        anim.removedOnCompletion = false
        
        circleView.layer.addAnimation(anim, forKey: nil)
    }
    
    // MARK: - 监听方法
    
//    // 登录
//    @objc private func loginButtonClick(){
//        delegate?.loginButtonDidSelected()
//    }
//    
//    // 注册
//    @objc private func registerButtonClick(){
//        delegate?.registerButtonDidSelected()
//    }
    
    // MARK: - 懒加载控件
    
    // 图标
    private lazy var iconView: UIImageView = {
        let image = UIImage(named: "visitordiscover_feed_image_house")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    // 首页的圆
    private lazy var circleView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    
    // 显示消息的 label
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        // 设置颜色以及字体大小
        label.textColor = UIColor.darkGrayColor()
        label.font = UIFont.systemFontOfSize(14)
        label.text = "关注一些人，回这里看看有什么惊喜关注一些人，回这里看看有什么惊喜"
        // 设置文字居中
        label.textAlignment = .Center
        // 多行
        label.numberOfLines = 0
        return label;
    }()
    
    // 注册按钮
    lazy var registerButton: UIButton = {
        let button = UIButton()
//        button.addTarget(self, action: "registerButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        // 设置文字以及文字颜色
        button.setTitle("注册", forState: .Normal)
        button.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        // 设置字体大小
        button.titleLabel?.font = UIFont.systemFontOfSize(14)
        // 设置背景
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: .Normal)
        return button
    }()
    
    // 注册按钮
    lazy var loginButton: UIButton = {
        let button = UIButton()
//        button.addTarget(self, action: "loginButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        // 设置文字以及文字颜色
        button.setTitle("登录", forState: .Normal)
        button.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        // 设置字体大小
        button.titleLabel?.font = UIFont.systemFontOfSize(14)
        // 设置背景
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: .Normal)
        return button
    }()
    
    // 阴影
    private lazy var maskIconView: UIImageView = {
    //visitordiscover_feed_mask_smallicon
        let image = UIImage(named: "visitordiscover_feed_mask_smallicon")
        let imageView = UIImageView(image: image)
        return imageView
    }()
}

// 添加视图和约束
extension HMVisitorView {
    /// 设置视图
    private func setupUI(){
        // 设置随机颜色
        backgroundColor = UIColor(white: 237 / 255, alpha: 1)
        
        // 1.添加视图
        addSubview(circleView)
        addSubview(maskIconView)
        addSubview(iconView)
        addSubview(messageLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        // 2.添加约束
        // 2.1 图标
        iconView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self.snp_center)
        }
        // 2.2 圆圈
        circleView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(iconView)
        }
        // 2.3
        messageLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(circleView.snp_bottom).offset(16)
            make.centerX.equalTo(circleView)
            make.width.equalTo(224)
        }
        // 2.4 注册按钮
        registerButton.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(messageLabel)
            make.top.equalTo(messageLabel.snp_bottom).offset(16)
            make.size.equalTo(CGSizeMake(100, 35))
        }
        // 2.5 登录按钮
        loginButton.snp_makeConstraints { (make) -> Void in
            make.trailing.equalTo(messageLabel)
            make.top.equalTo(registerButton)
            make.size.equalTo(CGSizeMake(100, 35))
        }
        // 2.5 透明阴影
        maskIconView.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(registerButton.snp_bottom)
        }
    }
    
    
    private func demo(){
        // 2.1 iconview
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
        
        // 2.2 圆圈 view
        // 其中心与iconView 中心一样
        circleView.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: circleView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: .CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: circleView, attribute: .CenterY, relatedBy: .Equal, toItem: iconView, attribute: .CenterY, multiplier: 1, constant: 0))
        
        // 2.3 messagelabel
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: circleView, attribute: .CenterX, multiplier: 1, constant: 0))
        // 约束宽度
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 224))
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: circleView, attribute: .Bottom, multiplier: 1, constant: 16))
        
        // 2.4 注册按钮
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: messageLabel, attribute: .Leading, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: messageLabel, attribute: .Bottom, multiplier: 1, constant: 16))
        // 约束宽度以及高度
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 100))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 35))
        
        // 2.5 登录按钮
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: messageLabel, attribute: .Trailing, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: registerButton, attribute: .Top, multiplier: 1, constant: 0))
        // 约束宽度以及高度
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 100))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 35))
        
        
        // VFL
        
        // H: 水平方向
        // |: 边缘
        // []: 里面放的是 View -> views 设置字典用
        // (): 里面放的是数值 --> metrics 设置数值字典
        
        maskIconView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[maskIconView]-0-|", options: [], metrics: nil, views: ["maskIconView": maskIconView]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[maskIconView]-(offset)-[registerButton]", options: [], metrics: ["offset" : -35], views: ["maskIconView": maskIconView,"registerButton": registerButton]))
    }
}
