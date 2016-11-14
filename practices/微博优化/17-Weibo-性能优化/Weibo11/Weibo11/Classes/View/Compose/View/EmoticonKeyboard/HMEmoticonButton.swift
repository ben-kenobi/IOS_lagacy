
//
//  HMEmoticonButton.swift
//  Weibo11
//
//  Created by itheima on 15/12/17.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

class HMEmoticonButton: UIButton {

    var emoticon: HMEmoticon? {
        didSet {
            
            guard let emo = emoticon else {
                return
            }
            // 先判断是否是 emoji 表情
            if !emo.isEmoji {
                // 如果是图片表情,直接加载图片
                // printLog(emo.fullPath!)
                // let image = UIImage(named: emo.fullPath!)
                // emo.fullPath! -> "default/d_haha.png"
                let image = UIImage(named: emo.fullPath!, inBundle: HMEmoticonTools.shareTools.emoticonBundle, compatibleWithTraitCollection: nil)
                setImage(image, forState: .Normal)
                setTitle(nil, forState: .Normal)
            }else{
                // 设置 emoji 表情
                // 字符串 -->
                setTitle((emo.code! as NSString).emoji(), forState: UIControlState.Normal)
                setImage(nil, forState: .Normal)
            }
        }
    }
    
    
    /// 将传入的 PopView 显示在当前 button 的位置上
    ///
    /// - parameter popView: <#popView description#>
    func showPopView(popView: HMEmoticonPopView) {
        // 求出按钮在屏幕上的位置
        let rect = self.convertRect(bounds, toView: nil)
        // 设置位置
        popView.center.x = CGRectGetMidX(rect)
        popView.y = CGRectGetMaxY(rect) - popView.height

        // 设置数据
        popView.emoticonButton.emoticon = emoticon
        let window = UIApplication.sharedApplication().windows.last!
        window.addSubview(popView)
    }
}
