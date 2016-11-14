//
//  NSDate+Extension.swift
//  Weibo11
//
//  Created by itheima on 15/12/12.
//  Copyright © 2015年 itheima. All rights reserved.
//

import Foundation

extension NSDate {
    
    // 通过新浪微博创建时间字符串返回其对应的NSDate
    class func sinaDate(createStr: String) -> NSDate? {
        let dt = NSDateFormatter()
        // 指定格式
        dt.dateFormat = "EEE MMM dd HH:mm:ss z yyyy"
        // 指定本地化信息
        dt.locale = NSLocale(localeIdentifier: "en_US")
        // 微博的创建时间(NSdate)
        let createDate = dt.dateFromString(createStr)
        
        return createDate
    }
    // 返回新浪微博时间的 字符串
    var sinaDateString: String {
        let dt = NSDateFormatter()
        dt.locale = NSLocale(localeIdentifier: "en_US")
        
        let calendar = NSCalendar.currentCalendar()
        
        if isThisYear(self) {
            // 进入到此,就代表是今年
            dt.dateFormat = "是今年"
            
            if calendar.isDateInToday(self) {
                // 进入到这个地方,就代表是今天
                
                // 求出当前时间与微博创建时间的差值
                // let currentDate = NSDate()
                // 求出 currentDate 与 微博创建时间的差值
                // 在开发中,代码写完之后,记得测试
                // let tempDate = currentDate.dateByAddingTimeInterval(-1)
                
                let result = -self.timeIntervalSinceNow
                
                if result < 60 {
                    return "刚刚"
                }else if result < 60 * 60 {
                    // 代表差值小于1小时
                    return "\(Int(result) / 60)分钟前"
                }else{
                    // 代表相着不止1小时  xx小时前
                    return "\(Int(result) / (60 * 60))小时前"
                }
                //                printLog("时间秒数差值:\(result)")
                
            }else if calendar.isDateInYesterday(self) {
                // 是昨天  -> 昨天 10:10
                dt.dateFormat = "昨天 HH:mm"
            }else{
                // 其他
                // 10-11 18:18
                dt.dateFormat = "MM-dd HH:mm"
            }
        }else {
            // 不是今年 2014-10-11 19:19
            dt.dateFormat = "yyyy-MM-dd HH:mm"
        }
        return dt.stringFromDate(self)
        
    }
    
    /// 判断传入的 date 与当前时间是否是同一年 (取到两个年份的字符串,判断如果其相等,就代表是同一年)
    ///
    /// - parameter date: <#date description#>
    ///
    /// - returns: <#return value description#>
    private func isThisYear(date: NSDate) -> Bool {
        // 取到当前时间
        let currentDate = NSDate()
        
        // 要比较是否是同一年,就直接比较其年份字符串
        let dt = NSDateFormatter()
        // 指定格式
        dt.dateFormat = "yyyy"
        // 指定本地化信息
        dt.locale = NSLocale(localeIdentifier: "en_US")
        
        // 取出当前时候与目标时间的年份字符串
        let dateStr = dt.stringFromDate(date)
        let currentDateStr = dt.stringFromDate(currentDate)
        
        // 进入对比并返回结果
        return (dateStr as NSString).isEqualToString(currentDateStr)
    }
    
    
    /**
    如果今年:
        是否是今天:
            是否在1分钟之内:
                刚刚
            是否在1小时之内:
                xx分钟前
            其他:
            xx小时前
        是否是昨天:
            昨天 10:10
        其他:
            10-11 18:18
    如果不是今年:
        2014-10-11 19:19
    */
    
}
