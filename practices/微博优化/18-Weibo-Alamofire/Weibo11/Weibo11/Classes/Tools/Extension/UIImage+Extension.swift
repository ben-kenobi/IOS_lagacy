//
//  UIImage+Extension.swift
//  Weibo11
//
//  Created by itheima on 15/12/8.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// 获取启动图
    ///
    /// - returns: <#return value description#>
    class func getLaunchImage() -> UIImage? {
        
        let dict = NSBundle.mainBundle().infoDictionary
        
        guard let images = dict?["UILaunchImages"] as? [[String: AnyObject]] else {
            return nil
        }
        
        let screenSize = UIScreen.mainScreen().bounds.size
        // 取到当前屏幕对应的启动图
        for imageDict in images {
            
            guard let sizeString = imageDict["UILaunchImageSize"] as? String else {
                break
            }
            let size = CGSizeFromString(sizeString)
            
            // 对比图片的大小与屏幕的大小,如果一样,加载 image 返回
            if CGSizeEqualToSize(screenSize, size) {
                let image = UIImage(named: (imageDict["UILaunchImageName"] as! String))
                return image
            }
        }
        return nil
    }
    
    /// 获取当前屏幕内容图像
    ///
    /// - returns:
    class func screentShot() -> UIImage {
        
        let window = UIApplication.sharedApplication().keyWindow!
        // 1. 开启上下文
        UIGraphicsBeginImageContext(window.size)
        // 参数1: 开启上下文内容范围大小;参数2: 是否是透明; 参数3: 缩放. 0-1 如果为0(实际分辨率大小),  如果为1(点坐标的大小)
        // UIGraphicsBeginImageContextWithOptions(window.size, false, 0)
        
        // 2. 将 window 上的内容渲染到当前下文中
        window.drawViewHierarchyInRect(window.bounds, afterScreenUpdates: false)
        
        // 3. 取到当前上下文里面的内容
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        // 关闭上下文
        UIGraphicsEndImageContext()
        
        return image
    }
    
    
    // 把图片等比例缩放指定的宽度
    func scaleToWidth(width: CGFloat) -> UIImage {
        
        if size.width < width {
            return self
        }
        
        // 比如传入的图片大小 : width: 1200 ,高度是 400
        // 知道缩放之后的宽度 --> 求出其对应的高度
        
        // width : 缩放之后的宽度 比如是600
        let height = width / size.width * size.height
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        
        // 1. 开启上下文
        UIGraphicsBeginImageContext(rect.size)
        
        // 2. 将图片绘制到上下文中
        drawInRect(rect)
        // 3. 从上下文中获取到图片
        let result = UIGraphicsGetImageFromCurrentImageContext()
        // 4. 关闭上下文
        UIGraphicsEndImageContext()
        
        return result
    }
    
    
/**
// 取到屏幕的图片加载成一个 imageView

let imageView = UIImageView(image: UIImage.getLaunchImage()!)

view.addSubview(imageView)

UIView.animateWithDuration(3, animations: { () -> Void in

// 执行放大并透明
imageView.transform = CGAffineTransformMakeScale(3, 3)
imageView.alpha = 0

}) { (_) -> Void in
imageView.removeFromSuperview()
}
*/
    
}
