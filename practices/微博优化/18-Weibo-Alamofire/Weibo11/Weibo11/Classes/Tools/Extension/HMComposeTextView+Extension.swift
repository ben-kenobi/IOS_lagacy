//
//  HMTextView+Extension.swift
//  Weibo11
//
//  Created by itheima on 15/12/17.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

extension HMComposeTextView {
    
    
    
    /// 拼接当前输入框里面表情对应该的文字字符串
    var emoticonText: String {
        var result = String()
        attributedText.enumerateAttributesInRange(NSMakeRange(0, attributedText.length), options: []) { (infoDict, range, _) -> Void in
            // infoDict : 里面装有当前文字的属性 (字体大小,风格)
            // range    : 代表当前遍历到的文字或者文字附件的范围
            // *stop    : 给其赋值值,让遍历停止
            printLog(infoDict)
            if let attachment = infoDict["NSAttachment"] as? HMTextAttachment {
                printLog(attachment.emoticon?.chs)
                // 取到 attachment 身上对应图片对应的表情字符串
                result += attachment.emoticon!.chs!
            }else {
                // 通过 range 取到对应的文字
                result += (self.attributedText.string as NSString).substringWithRange(range)
            }
        }
        return result
    }
    
    
    /// 添加表情
    ///
    /// - parameter emoticon: 表情模型
    func insertEmoticon(emoticon: HMEmoticon) {
        
        if emoticon.isEmoji {
            // 往 textView 里面添加 emoji
            insertText((emoticon.code! as NSString).emoji())
        }else {
            // 往 textView 里面添加 文字
            
            // 把之前的 attributeString 保存下来
            let originalAttr = NSMutableAttributedString(attributedString: attributedText)
            
//            // 通过图片路径生成图片
//            let image = UIImage(named: emoticon.fullPath!)
//            
//            // 生成 NSTextAttachment
//            let attachment = HMTextAttachment()
//            // 在此保存表情模型到文字附件里面,以便在发送微博的时候遍历 NSAttachment 取到其身上的表情模型的表情字符串
//            attachment.emoticon = emoticon
//            attachment.image = image
//            // 取到文字的高度
//            let fontHeight = font!.lineHeight
//            // 设置图片的大小与位置
//            attachment.bounds = CGRect(x: 0, y: -3.5, width: fontHeight, height: fontHeight)'
            
            let attchment = HMTextAttachment()
            // 设置文字附件上面的内容并且返回一个 NSAttributedString
            let attr = attchment.attributeStringWithEmoticon(emoticon, font: font!)
            
            // 把 attr 添加到 原有的富文本身上
            //            originalAttr.appendAttributedString(attr)
            // 怎么取? 取到当前 textView 的选中范围
            var range = selectedRange
            originalAttr.replaceCharactersInRange(range, withAttributedString: attr)
            // 指定字体大小
            originalAttr.addAttribute(NSFontAttributeName, value: font!, range: NSMakeRange(0, originalAttr.length))
            
            // 设置添加完毕的富文本设置到 textView 身上
            self.attributedText = originalAttr
            // 因为输入一个表情, location 加1  --> 调整光标位置
            range.location += 1; range.length = 0
            selectedRange = range
            
            // 发送文字改变的通知
            NSNotificationCenter.defaultCenter().postNotificationName(UITextViewTextDidChangeNotification, object: self)
            // 调用代理方法
            // textViewDidChange 是一个可选的代理方法
            delegate?.textViewDidChange?(self)
        }
        
        
    }
    
    
    
}
