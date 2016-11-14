//
//  HMStatusViewModel.swift
//  Weibo11
//
//  Created by itheima on 15/12/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit
// HMStatus 里面需要处理逻辑的代码都放在这个地方
// 比如说,格式化来源的字符串,以及时间字符串,以及其他
class HMStatusViewModel: NSObject {
    
    var status: HMStatus? {
        didSet{
            // 外界设置此值的时候才会调用 didSet + 并且还要在 init 方法里面设置才不会回调
            printLog("测试使用")
        }
    }
    
    // 会员图标
    var vipImage: UIImage? {
        // 判断用户的等级,如果大于0小于7
        // 就返回一个对应会员的图标
        guard let mbrank = status?.user?.mbrank else {
            return nil
        }
        if mbrank > 0 && mbrank < 7 {
            return UIImage(named: "common_icon_membership_level\(mbrank)")
        }
        return nil
    }
    
    // 认证的图标
    // /// 认证类型 -1：没有认证; 1:认证用户，2,3,5: 企业认证，220: 达人
    var verifiedImage: UIImage? {
        guard let verified = status?.user?.verified else {
            return nil
        }
        
        switch verified {
        case 1:
            return UIImage(named: "avatar_vip")
        case 2,3,5:
            return UIImage(named: "avatar_enterprise_vip")
        case 220:
            return UIImage(named: "avatar_grassroot")
            
        default:
            return nil
        }
    }
    // 转发评论选的字符串
    var retweetCountStr: String = "转发"
    var commentCountStr: String = "评论"
    var attitudeCountStr: String = "赞"
    // 转发微博的内容
    var retweetText: String?
    // 来源字符串
    var sourceText: String?
    // 创建时间
    var createAtText: String {
        // 已提取到 NSDate+Extension
        
        guard let createDate = NSDate.sinaDate(status!.created_at!) else {
            return ""
        }
        return createDate.sinaDateString
        
    }
    /// 原创微博的富文本
    var originalStatusAttr: NSMutableAttributedString?
    var retweetedStatusAttr: NSMutableAttributedString?
    
    // 原创微博特殊字符的范围
    var originalLinkResults: [HMMatchResult]?
    // 发转微博
    var retweetedLinkResults: [HMMatchResult]?
    
    /// 模型对应的行高属性
    var rowHeight: CGFloat = 0
    /// 配图视图大小
    var pictureViewSize: CGSize = CGSizeZero
    
    // MARK: - 构造函数
    init(status: HMStatus){
        super.init()
        self.status = status
        
        retweetCountStr = getCountString(self.status?.reposts_count ?? 0, defaulTitle: "转发")
        commentCountStr = getCountString(self.status?.comments_count ?? 0, defaulTitle: "评论")
        attitudeCountStr = getCountString(self.status?.attitudes_count ?? 0, defaulTitle: "赞")
        
        // 计算转发微博内容的逻辑
        if let retweetStatus = status.retweeted_status {
            if let name = retweetStatus.user?.name {
//                retweetText =  @转发微博的那一条微博用户的昵称: + 转发微博的内容
                retweetText = "@\(name):\(retweetStatus.text!)"
                let result = dealStatusText(retweetText)
                retweetedStatusAttr = result.attr
                retweetedLinkResults = result.linkResult
            }
        }
        
        // 来源字符串
        // <a href="http://weibo.com" rel="nofollow">新浪微博</a>
        // 判断 source 是否存在
        if let source = status.source where source.containsString("\">") {
            // 判断是否能够找到range
            let startRange = source.rangeOfString("\">")!
            let endRange = source.rangeOfString("</")!
            sourceText = "来自 \(source.substringWithRange(startRange.endIndex..<endRange.startIndex))"
        }
        
        // 处理原创微博的内容 --> 生成一个带有表情的富文本
        let result = dealStatusText(status.text)
        originalStatusAttr = result.attr
        originalLinkResults = result.linkResult
        
        // 在 tableView 中提前计算行高并且缓存住
        rowHeight = calcRowHeight()
    }
    
    // MARK: - 计算行高
    /// 根据指定图片的尺寸，重新计算配图视图大小以及行高
    func recalcPictureViewSize(imageSize: CGSize) {
        
        // 记录图像尺寸
        var size = imageSize
        
        // 针对过宽或者过窄的图片进行单独处理
        let minWidth: CGFloat = 30
        let maxWidth: CGFloat = 300
        
        size.width = (size.width < minWidth) ? minWidth : size.width
        size.width = (size.width > maxWidth) ? maxWidth : size.width
        
        // 等比例缩放
        size.height = size.width * imageSize.height / imageSize.width
        
        // 根据配图视图大小，修改行高
        // 行高公式：已经计算好的行高 - 原本已经计算好的配图视图的高度 + 图像的高度
        rowHeight = rowHeight - pictureViewSize.height + size.height
        
        // 设置配图视图大小
        pictureViewSize = size
    }
    
    /**
        1. 顶部间距 HMStatusCellMargin
        2. 原创微博 HMStatusCellMargin + HMStatusIconWH + HMStatusCellMargin + 文本高度 + HMStatusCellMargin 
            ＋ (配图高度 + HMStatusCellMargin)
        3. 转发微博 HMStatusCellMargin + 转发文字高度 + HMStatusCellMargin
            ＋ (配图高度 + HMStatusCellMargin)
        4. 底部工具栏高度 + HMStatusToolbarHeight
    */
    private func calcRowHeight() -> CGFloat {
        
        // 定义标签的计算尺寸
        let labelSize = CGSize(width: SCREENW - 2 * HMStatusCellMargin, height: CGFloat(MAXFLOAT))
        
        // 顶部 + 底部
        var height = HMStatusCellMargin + HMStatusToolbarHeight
        
        // 原创微博
        height += 3 * HMStatusCellMargin + HMStatusIconWH
        
        // 计算文本
        if let str = originalStatusAttr {
            height += str.boundingRectWithSize(labelSize, options: [.UsesLineFragmentOrigin], context: nil).height
        }
        
        // 转发微博
        // 判断是否有转发微博
        if status?.retweeted_status != nil {
            height += 2 * HMStatusCellMargin
            
            // 计算文本
            if let str = retweetedStatusAttr {
                height += str.boundingRectWithSize(labelSize, options: [.UsesLineFragmentOrigin], context: nil).height
            }
        }
        
        // 计算配图高度
        // 如果一条微博，有转发微博，原创微博一定没有图！
        // 1> 图片数量
        if let count = status?.retweeted_status?.pic_urls?.count ?? status?.pic_urls?.count where count > 0 {
            
            // 使用属性记录配图视图大小
            pictureViewSize = calcSize(count)
            
            // 2> 如果图片数量 > 0 计算配图高度
            height += pictureViewSize.height
            
            // 3> 增加配图视图的间距
            height += HMStatusCellMargin
        }
        
        return height
    }
    
    /// 根据图像数量计算配图视图大小 - 从配图视图移动过来的
    private func calcSize(count: Int) -> CGSize {
        // 每一个条目之前的间距
        let itemMargin: CGFloat = 5
        // 每一个条目的宽高
        let itemWH: CGFloat = CGFloat(Int(SCREENW - itemMargin * 2 - HMStatusCellMargin * 2) / 3)
        
        // 计算当前显示的行数与列数
        let col = count == 4 ? 2 : (count >= 3 ? 3 : count)
        // 如果是2张 (2 - 1)/3 + 1
        // 如果是5张 (5 - 1)/3 + 1
        let row = count == 4 ? 2 : ((count - 1) / 3 + 1)
        
        // 宽度 = 列数*每一个条目的宽度 + (列数减1)*条目之前的间距
        let width = CGFloat(col) * itemWH + CGFloat(col - 1) * itemMargin
        let height = CGFloat(row) * itemWH + CGFloat(row - 1) * itemMargin
        
        return CGSize(width: width, height: height)
    }
    
    // MARK: - 属性文本
    /// 处理微博内容: 通过表情字符串生成表情对应的富文本+
    ///
    /// - parameter text: 微博内容
    private func dealStatusText(statusText: String?) -> (attr: NSMutableAttributedString?, linkResult: [HMMatchResult]?) {
        
        guard let text = statusText else {
            return (nil, nil)
        }
        
        // 1. 创建一个 NSMutableAttributedString
        let result = NSMutableAttributedString(string: text)
        
        // 2. 匹配表情字符串
        
        /**
            usingBlock:
                - 参数1: 捕获的个数
                - 参数2: 捕获的结果的指针
                - 参数3: 捕获的范围的指针
                - 参数4: stop 的指针 --> 是否停止匹配
        */
        // 定义匹配结果数组
        var matchResults = [HMMatchResult]()
        
        (text as NSString).enumerateStringsMatchedByRegex("\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]") { (captureCount, captureString, captureRange, _) -> Void in
            // 生成结果,保存到数组
            let matchRes = HMMatchResult(string: captureString.memory! as String, range: captureRange.memory)
            matchResults.append(matchRes)
        }
        
        
        // 在这个地方拿着结果,倒着遍历
        for matchResult in matchResults.reverse() {
            if let emoticon = HMEmoticonTools.shareTools.emoticonWithChs(matchResult.string) {
                //通过 emoticon 生成表情的 NSAttributeString
                let attachment = HMTextAttachment()
                // 通过表情模型生成 attr
                let attr = attachment.attributeStringWithEmoticon(emoticon, font: UIFont.systemFontOfSize(HMStatusContentFontSize))
                //　替换 result 对应位置的 attr
                result.replaceCharactersInRange(matchResult.range, withAttributedString: attr)
            }
        }
        
        
        // 添加特殊字符颜色
        
        let linkResult = addLinkColor(result)
        
        // 添加字体大小的属性
        result.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(HMStatusContentFontSize), range: NSMakeRange(0, result.length))
        
        return (result, linkResult)
    }
    //  添加特殊字符颜色
    private func addLinkColor(attr: NSMutableAttributedString) -> [HMMatchResult] {
        
        
        // 特殊字符的范围结果
        var result = [HMMatchResult]()
        
        // 匹配 @
        (attr.string as NSString).enumerateStringsMatchedByRegex("@[^\\W]+") { (_, captureString, cputureRange, _) -> Void in
            attr.addAttribute(NSForegroundColorAttributeName, value: RGB(red: 80, green: 125, blue: 175), range: cputureRange.memory)
            result.append(HMMatchResult(string: captureString.memory! as String, range: cputureRange.memory))
        }
        
        // 匹配链接 --> 短链接 http://R.f
        (attr.string as NSString).enumerateStringsMatchedByRegex("http://[^\\s^\\u4e00-\\u9fa5]+") { (_, captureString, cputureRange, _) -> Void in
            attr.addAttribute(NSForegroundColorAttributeName, value: RGB(red: 80, green: 125, blue: 175), range: cputureRange.memory)
            result.append(HMMatchResult(string: captureString.memory! as String, range: cputureRange.memory))
        }
        
        // 匹配话题
        (attr.string as NSString).enumerateStringsMatchedByRegex("#[^#]+#") { (_, captureString, cputureRange, _) -> Void in
            attr.addAttribute(NSForegroundColorAttributeName, value: RGB(red: 80, green: 125, blue: 175), range: cputureRange.memory)
            result.append(HMMatchResult(string: captureString.memory! as String, range: cputureRange.memory))
        }
        
        return result
    }
    
    
    /// 获取转发评论赞的字符串
    ///
    /// - parameter count:       数量
    /// - parameter defaulTitle: 默认文字
    ///
    /// - returns: 返回文字
    private func getCountString(count: Int, defaulTitle: String) -> String {
        // count 11010 --> "1.1万"
        // count 10900 --> "1万"
        if count > 0 {
            // 小于1万显示原数据
            if count < 10000 {
                return "\(count)"
            }else {
                let result = CGFloat(count / 1000) / 10
                
                let resultStr = "\(result)万"
                
                if resultStr.containsString(".0") {
                    return resultStr.stringByReplacingOccurrencesOfString(".0", withString: "")
                }
                return resultStr
            }
        }
        return defaulTitle
    }

    
    override var description: String {
        let keys = ["status"]
        return dictionaryWithValuesForKeys(keys).description
    }
}
