//
//  HMEmoticonPageView.swift
//  Weibo11
//
//  Created by itheima on 15/12/15.
//  Copyright © 2015年 itheima. All rights reserved.
//  表情键盘 cell ,里面最多放 20 个表情数据

import UIKit

class HMEmoticonPageView: UICollectionViewCell {
    
    // 当前 cell 显示的数据
    var emoticons: [HMEmoticon]? {
        didSet{
            
            // 先隐藏所有按钮
            for value in emoticonButtons {
                value.hidden = true
            }
            
            // 遍历表情数据的数组--> 设置一个表情数据显示一个表情按钮
            for (i,emoticon) in emoticons!.enumerate() {
                // 设置显示数据
                let button = emoticonButtons[i]
                button.hidden = false
                button.emoticon = emoticon
            }
        }
    }
    
    // 装有20个表情按钮的数组
    private lazy var emoticonButtons: [HMEmoticonButton] = [HMEmoticonButton]()
    
    var indexPath: NSIndexPath? {
        didSet{
            recentInfoLabel.hidden = indexPath?.section != 0
        }
    }
    
    // MARK: - 控件初始化界面调整
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        addEmoticonButtons()
        contentView.addSubview(deleteButton)
        contentView.addSubview(recentInfoLabel)
        
        recentInfoLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-10)
        }
        
        // 添加手势 
        let ges = UILongPressGestureRecognizer(target: self, action: "longPressGes:")
        // 将手势 添加到 contentView 上
        contentView.addGestureRecognizer(ges)
        
    }
    
    /// 添加表情按钮
    private func addEmoticonButtons(){
        for _ in 0..<HMEmoticonsNumOfPage {
            let button = HMEmoticonButton()
            button.addTarget(self, action: "emoticonButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
            button.titleLabel?.font = UIFont.systemFontOfSize(34)
            contentView.addSubview(button)
            emoticonButtons.append(button)
        }
    }
    
    // 调整20个按钮的大小与位置
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 拿到20个按钮,遍历设置 frame
        
        let leftMargin: CGFloat = 5
        let bottomMargin: CGFloat = 25
        
        // 计算表情按钮的宽度与高度
        let itemW = (width - leftMargin * 2) / CGFloat(HMEmoticonsColOfPage)
        let itemH = (height - 25) / CGFloat(HMEmoticonsRowOfPage)
        
        for (i, value) in emoticonButtons.enumerate() {
            
            // 设置宽高
            value.size = CGSize(width: itemW, height: itemH)
            // 设置位置
            
            // 求出当前按钮的行数与列数
            let col = i % HMEmoticonsColOfPage
            let row = i / HMEmoticonsColOfPage
            value.x = CGFloat(col) * itemW + leftMargin
            value.y = CGFloat(row) * itemH
        }
        
        // 调整删除按钮的位置.大小
        deleteButton.size = CGSize(width: itemW, height: itemH)
        deleteButton.x = width - itemW - leftMargin
        deleteButton.y = height - itemH - bottomMargin
        
    }
    
    // MARK: - 监听方法
    
    
    @objc private func longPressGes(ges: UILongPressGestureRecognizer) {
        
        /// 通过一个 location 查找其对应的表情按钮
        func buttonWithLocation(location: CGPoint) -> HMEmoticonButton? {
            for button in emoticonButtons {
                // 判断点是否在当前 button 的范围内
                if CGRectContainsPoint(button.frame, location) {
                    // 查找到了
                    return button
                    // 跳出循环
                }
            }
            return nil
        }
        
        switch ges.state {
        case .Began,.Changed:
            // 找到手势按下的点
            let location = ges.locationInView(contentView)
            // 查找这个点在哪一个 button 的范围内
            if let targetButton = buttonWithLocation(location) {
                popView.hidden = false
                targetButton.showPopView(popView)
            }
        case .Ended:
            let location = ges.locationInView(contentView)
            // 查找这个点在哪一个 button 的范围内
            if let targetButton = buttonWithLocation(location) {
                emoticonButtonClick(targetButton)
            }
            popView.hidden = true
        default:
            popView.hidden = true
        }
    }
    
    // 表情按钮点击
    @objc private func emoticonButtonClick(button: HMEmoticonButton){
        // 取到这个按钮对应的表情数据
        // 发送通知
        NSNotificationCenter.defaultCenter().postNotificationName(HMEmoticonButtonDidSelectedNotification, object: nil, userInfo: ["emoticon": button.emoticon!])
        
        // 将当前表情按钮对应的模型保存到最近表情的数组里面去
        HMEmoticonTools.shareTools.saveRecent(button.emoticon!)
        
        // 弹出 popView 
        let popView = HMEmoticonPopView.popView()
        
        button.showPopView(popView)
//
//        let window = UIApplication.sharedApplication().windows.last!
//        window.addSubview(popView)
//        // 取到 button 在屏幕上的位置
//        // 坐标转换 : _.converRect(_, toView: _)
//        let rect = button.convertRect(button.bounds, toView: window)
//        // 设置 PopView 的位置
//        popView.center.x = CGRectGetMidX(rect)
//        popView.y = CGRectGetMaxY(rect) - popView.height
//        // 将当前用户点击的按钮里面的数据赋值给 popView
//        popView.emoticonButton.emoticon = button.emoticon
        
        // 0.1 秒之后消失
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(0.1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
            popView.removeFromSuperview()
        })
    }
    
    /// 删除按钮点击
    @objc private func deleteButtonClick(){
        // 想要通知到控制器里面的 textView --> 通过通知
        NSNotificationCenter.defaultCenter().postNotificationName(HMDeleteButtonDidSelectedNotification, object: nil)
    }
    
    // MARK: - 懒加载
//    private lazy var label: UILabel = {
//        let label = UILabel(textColor: UIColor.blackColor(), fontSize: 35)
//        label.numberOfLines = 0
//        label.textAlignment = .Center
//        return label
//    }()
    
    // 删除按钮
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        // 添加点击事件
        button.addTarget(self, action: "deleteButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        button.setImage(UIImage(named: "compose_emotion_delete"), forState: UIControlState.Normal)
        button.setImage(UIImage(named: "compose_emotion_delete_highlighted"), forState: UIControlState.Highlighted)
        return button
    }()
    
    /// 最近使用表情的 label
    private lazy var recentInfoLabel: UILabel = {
        let label = UILabel(textColor: UIColor.grayColor(), fontSize: 12)
        label.text = "最近使用的表情"
        return label
    }()
    
    // 初始化 popView
    private lazy var popView: HMEmoticonPopView = HMEmoticonPopView.popView()
    
}
