//
//  HMStatusLabel.swift
//  Weibo11
//
//  Created by itheima on 15/12/18.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

class HMStatusLabel: UILabel {
    
    
    var linkResults: [HMMatchResult]?
    
    private lazy var linkViews: [UIView] = [UIView]()
    
    override var attributedText: NSAttributedString? {
        didSet {
            textView.attributedText = attributedText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        userInteractionEnabled = true
        addSubview(textView)
        
        textView.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
        }
    }
    

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let location = touches.first!.locationInView(self)
        
        // 获取到手指点击位置的字符 range
        let textRange = textView.characterRangeAtPoint(location)
        textView.selectedTextRange = textRange
        // 用户手指点击的文字范围
        let range = textView.selectedRange
        
        if linkResults == nil {
            return
        }
        
        // 遍历特殊字符的范围
        for value in linkResults! {
            // 判断手指点击字符是否在当前的特殊字符的范围内
            if  NSLocationInRange(range.location, value.range) {
                textView.selectedRange = value.range
                let rects = textView.selectionRectsForRange(textView.selectedTextRange!)
                
                for value in rects {
                    let rect = value as! UITextSelectionRect
                    let v = UIView(frame: rect.rect)
                    v.layer.cornerRadius = 3
                    v.layer.masksToBounds = true
                    v.backgroundColor = RGB(red: 177, green: 215, blue: 255)
                    insertSubview(v, atIndex: 0)
                    linkViews.append(v)
                }

                
                // 作点击的处理
                
            }
        }
    }
    
    // 在用户手指离开的时候移除高亮
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        for v in linkViews {
            v.removeFromSuperview()
        }
        linkViews.removeAll()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touchesCancelled(touches, withEvent: event)
    }
    
    /// 用于监听手指点击位置的 text
    private lazy var textView: UITextView = {
        let textView = UITextView()
        // 不允许编辑
        textView.editable = false
        // 不允许交互
        textView.userInteractionEnabled = false
        // 不允许滚动
        textView.scrollEnabled = false
        // 设置透明度为 0
        textView.alpha = 0
        textView.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5)
        return textView
    }()
}

/*

override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let location = touches.first!.locationInView(self)
    
    // 获取到手指点击位置的字符 range
    let textRange = textView.characterRangeAtPoint(location)
    textView.selectedTextRange = textRange
    // 用户手指点击的文字范围
    let range = textView.selectedRange
    
    if linkResults == nil {
        return
    }
    
    // 遍历特殊字符的范围
    for value in linkResults! {
        // 判断手指点击字符是否在当前的特殊字符的范围内
        if  NSLocationInRange(range.location, value.range) {
            printLog(value.string)
            currentRange = value.range
            // 给指定范围添加属性
            let attr = NSMutableAttributedString(attributedString: attributedText!)
            attr.addAttribute(NSBackgroundColorAttributeName, value: UIColor.purpleColor(), range: value.range)
            self.attributedText = attr
        }
    }
}

override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    if currentRange != nil {
        let attr = NSMutableAttributedString(attributedString: attributedText!)
        attr.removeAttribute(NSBackgroundColorAttributeName, range: currentRange!)
        self.attributedText = attr
        
        currentRange = nil
    }
}

*/
