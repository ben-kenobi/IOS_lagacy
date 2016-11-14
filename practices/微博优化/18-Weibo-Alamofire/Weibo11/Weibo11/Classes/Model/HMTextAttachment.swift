//
//  HMTextAttachment.swift
//  Weibo11
//
//  Created by itheima on 15/12/17.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

class HMTextAttachment: NSTextAttachment {
    var emoticon: HMEmoticon?
    
    
    /// 通过一个表情生成一个 NSAttributedString
    ///
    /// - parameter emoticon: 表情模型
    /// - parameter font:     字体大小 -> 需要指定表情图片的大小
    ///
    /// - returns: NSAttributedString
    func attributeStringWithEmoticon(emoticon: HMEmoticon, font: UIFont) -> NSAttributedString {
        
        self.emoticon = emoticon
        // 通过图片路径生成图片
//        let image = UIImage(named: emoticon.fullPath!)
        let image = UIImage(named: emoticon.fullPath!, inBundle: HMEmoticonTools.shareTools.emoticonBundle, compatibleWithTraitCollection: nil)
        // 在此保存表情模型到文字附件里面,以便在发送微博的时候遍历 NSAttachment 取到其身上的表情模型的表情字符串
        self.image = image
        // 取到文字的高度
        let fontHeight = font.lineHeight
        // 设置图片的大小与位置
        bounds = CGRect(x: 0, y: -3.5, width: fontHeight, height: fontHeight)
        return NSAttributedString(attachment: self)
    }
    
    
    
    
    
}
