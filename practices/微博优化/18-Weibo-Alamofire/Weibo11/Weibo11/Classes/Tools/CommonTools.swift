//
//  CommonTools.swift
//  Weibo11
//
//  Created by itheima on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//  类似于 oc 中的 pch ,可以全局访问方法

import UIKit


// 屏幕宽度与屏幕高度
let SCREENW = UIScreen.mainScreen().bounds.size.width
let SCREENH = UIScreen.mainScreen().bounds.size.height

/// 切换根控制器的通知
let HMSwitchRootVCNotification = "HMSwitchRootVCNotification"
/// 表情点击发送的通知
let HMEmoticonButtonDidSelectedNotification = "HMEmoticonButtonDidSelectedNotification"
/// 删除按钮点击的通知
let HMDeleteButtonDidSelectedNotification = "HMDeleteButtonDidSelectedNotification"


///  快速创建一个颜色
///
///  - parameter red:   红
///  - parameter green: 绿
///  - parameter blue:  蓝
///
///  - returns: 
func RGB(red red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    return UIColor(red: red / 255, green: green / 255 , blue: blue / 255, alpha: 1)
}

///  随机颜色
///
///  - returns: 随机颜色
func RandomColor() -> UIColor {
    return RGB(red: CGFloat(random() % 256), green: CGFloat(random() % 256), blue: CGFloat(random() % 256))
}


//

// 自定义的log 
// 在 BuildSettting 中 搜索 other swift flags 添加一个 `-D DEBUG`

//         __FILE__
//__LINE__
//__FUNCTION__
func printLog<T>(
    message: T,
    file: String = __FILE__,
    line: Int = __LINE__,
    mthName: String = __FUNCTION__
    ) {
    #if DEBUG
        __LINE__
        print("\((file as NSString).lastPathComponent)[\(line)], \(mthName): \(message)")
    #endif
}


