//
//  HMComposeToolBar.swift
//  Weibo11
//
//  Created by itheima on 15/12/14.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

enum HMComposeToolBarButtonType: Int {
    case Picture = 0   // 图片
    case Mention = 1   // @
    case Trend = 2     // 话题
    case Emotion = 3   // 表情
    case Add = 4       // 加
}

class HMComposeToolBar: UIStackView {
    
    var childButtonClickClosure: ((type: HMComposeToolBarButtonType)->())?
    
    private var emoticonButton: UIButton?
    
    // 提供给外界设置当前是否是表情键盘的属性
    // 以便内部切换 emoticonButton 的图标
    var isEmoticonKeyboard: Bool = false {
        didSet{
            var defaultName = "compose_emoticonbutton_background"
            if isEmoticonKeyboard {
                defaultName = "compose_keyboardbutton_background"
            }
            // 显示表情图标(笑脸)
            emoticonButton?.setImage(UIImage(named: defaultName), forState: UIControlState.Normal)
            emoticonButton?.setImage(UIImage(named: "\(defaultName)_highlighted"), forState: UIControlState.Highlighted)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 指定排列方向
        axis = .Horizontal
        // 指定子控件大小相等填充父控件
        distribution = .FillEqually
        
        // 添加子控件
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 设置视图
    private func setupUI(){
        addChildButton("compose_toolbar_picture", type: .Picture)
        addChildButton("compose_mentionbutton_background", type: .Mention)
        addChildButton("compose_trendbutton_background", type: .Trend)
        // 拿到这一步添加的按钮
        emoticonButton = addChildButton("compose_emoticonbutton_background", type: .Emotion)
        addChildButton("compose_add_background", type: .Add)
    }

    
    /// 添加按钮的方法
    private func addChildButton(imgName: String, type: HMComposeToolBarButtonType) -> UIButton {
        let button = UIButton()
        // 取到枚举的原始值
        button.tag = type.rawValue
        button.addTarget(self, action: "childButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        // 设置不同状态的图片
        button.setImage(UIImage(named: imgName), forState: UIControlState.Normal)
        button.setImage(UIImage(named: "\(imgName)_highlighted"), forState: UIControlState.Highlighted)
        
        // 设置背景
        button.backgroundColor = UIColor(patternImage: UIImage(named: "compose_toolbar_background")!)
        addArrangedSubview(button)
        return button
    }
    
    
    // MARK: - 监听方法
    @objc private func childButtonClick(button: UIButton){
        // 执行闭包
        // 通过原始值初始化一个枚举:　枚举名(rawValue: 值)
        childButtonClickClosure?(type: HMComposeToolBarButtonType(rawValue: button.tag)!)
    }
}
