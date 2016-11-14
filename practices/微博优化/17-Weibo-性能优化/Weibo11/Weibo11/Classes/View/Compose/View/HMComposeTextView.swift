//
//  HMComposeTextView.swift
//  Weibo11
//
//  Created by itheima on 15/12/14.
//  Copyright © 2015年 itheima. All rights reserved.
//  提供占位文件的 textView

import UIKit

@IBDesignable class HMComposeTextView: UITextView {
    
    @IBInspectable var placeholder: String? {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    /// 重写text属性,为了在 didSet 里面更显示或者隐藏 text
    override var text: String? {
        didSet{
            placeholderLabel.hidden = hasText()
        }
    }
    
    override var font: UIFont? {
        didSet{
            //   指定占位文字控件的字体大小
            placeholderLabel.font = font
        }
    }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI(){
        // 添加控件
        addSubview(placeholderLabel)
        
        // 添加约束
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: placeholderLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.LessThanOrEqual, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 1, constant:  -10))
        
        // 监听文字改变的通知,去显示或者隐藏占位文字
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textChanged", name: UITextViewTextDidChangeNotification, object: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        placeholderLabel.x = 5
        placeholderLabel.y = 8
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: - 监听方法
    @objc private func textChanged(){
        // 根据当前输入框里面是否有文字去隐藏占位文字控件
        placeholderLabel.hidden = hasText()
    }
    
    // MARK: - 懒加载控件
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "我是占位文字"
        label.font = UIFont.systemFontOfSize(12)
        label.textColor = UIColor.lightGrayColor()
        return label
    }()
}
