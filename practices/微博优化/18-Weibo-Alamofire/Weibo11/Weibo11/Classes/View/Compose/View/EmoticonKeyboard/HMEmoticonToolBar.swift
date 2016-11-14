//
//  HMEmoticonToolBar.swift
//  Weibo11
//
//  Created by itheima on 15/12/15.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

/// 按钮点击的协议
protocol HMEmoticonToolBarDelegate: NSObjectProtocol {
    func didselectedButtonWithType(type: HMEmoticonType)
}

/// 表情类型
///
/// - Recent:  最近
/// - Default: 默认
/// - Emoji:   Emoji
/// - Lxh:     浪小花
enum HMEmoticonType: Int {
    case Recent = 1000
    case Default = 1001
    case Emoji = 1002
    case Lxh = 1003
}

class HMEmoticonToolBar: UIStackView {
    
    weak var delegate: HMEmoticonToolBarDelegate?
    
    /// 当前选中的按钮
    var currentSelectedButton: UIButton?
    
    var currentSection: Int? {
        didSet{
            
            guard let section = currentSection else {
                return
            }
            
            
            // 判断如果当前选中的 button 的 tag 与 传入的 section(加上基数) 一样,直接返回
            // 不做任何
            if currentSelectedButton?.tag == section + 1000 {
                return
            }
            // 1. 取到 section 对应的按钮
            // 通过一个 tag 取到 tag 对应的子控件
            let button = viewWithTag(section + 1000)! as! UIButton
//            // 2. 让之前选中的按钮取消选中
//            currentSelectedButton?.selected = false
//            // 3. 让第 1 步取到的按钮选中
//            button.selected = true
//            // 4. 将当前选中的按钮赋值给 currentSelectedButton
//            currentSelectedButton = button
            selectedButton(button)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 子控件的排列方向
        axis = .Horizontal
        // 子控件大小相等并且占满父控件
        distribution = .FillEqually
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        // 添加4个按钮
        addChildButton("最近", bgImg: "compose_emotion_table_left", type: .Recent)
        addChildButton("默认", bgImg: "compose_emotion_table_mid", type: .Default)
        addChildButton("Emoji", bgImg: "compose_emotion_table_mid", type: .Emoji)
        addChildButton("浪小花", bgImg: "compose_emotion_table_right", type: .Lxh)
    }
    
    private func addChildButton(title: String, bgImg: String, type: HMEmoticonType){
        // 初始化按钮
        let button = UIButton()
        // 添加点击事件
        button.addTarget(self, action: "childButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        // 设置 tag,以区分是哪一种类型的表情按钮
        button.tag = type.rawValue
        // 设置文字
        button.setTitle(title, forState: UIControlState.Normal)
        // 设置字体大小
        button.titleLabel?.font = UIFont.systemFontOfSize(14)
        // 设置不同状态的文字颜色
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Selected)
        
        // 设置不同状态的背景图片
        button.setBackgroundImage(UIImage(named: "\(bgImg)_normal"), forState: UIControlState.Normal)
        button.setBackgroundImage(UIImage(named: "\(bgImg)_selected"), forState: UIControlState.Selected)
        
        // 添加到当前控件内部
        addArrangedSubview(button)
        
        // 选中默认按钮
        if type == .Default {
            button.selected = true
            currentSelectedButton = button
        }
    }
    
    // MARK: - 监听方法
    func childButtonClick(button: UIButton){
        
        // 如果当前选中的按钮是与当前点击的按钮一样,不做任何操作
        if currentSelectedButton == button {
            return
        }
        
        
        selectedButton(button)
//        // 把之前的按钮取消选中
//        currentSelectedButton?.selected = false
//        // 选中当前的
//        button.selected = true
//        // 记录当前的按钮
//        currentSelectedButton = button
        // button.tag --> HMEmoticonType
        delegate?.didselectedButtonWithType(HMEmoticonType(rawValue: button.tag)!)
    }
    
    /// 选中传入的 button --> 取消之前选中的
    ///
    /// - parameter button: <#button description#>
    private func selectedButton(button: UIButton) {
        // 把之前的按钮取消选中
        currentSelectedButton?.selected = false
        // 选中当前的
        button.selected = true
        // 记录当前的按钮
        currentSelectedButton = button
    }
}
