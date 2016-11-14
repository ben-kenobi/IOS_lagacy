//
//  HMEmoticon.swift
//  Weibo11
//
//  Created by itheima on 15/12/15.
//  Copyright © 2015年 itheima. All rights reserved.
//  表情数据的模型

import UIKit

class HMEmoticon: NSObject, NSCoding {

    // 表情描述文字
    var chs: String?
    // 图片名字
    var png: String?
    // 表情类型,如果为 `0` 代表是图片表情  为 `1` Emoji 表情
    var type: String? {
        didSet {
            if type == "1" {
                isEmoji = true
            }
        }
    }
    // Emoji 表情的字符串
    var code: String?
    // 图片表情的前半段路径
    var path: String? {
        didSet {
            if png != nil {
                fullPath = "\(path!)/\(png!)"
            }
        }
    }
    
    var isEmoji: Bool = false
    
    var fullPath: String?
    
    init(dict: [String: AnyObject]){
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    /// 归档
    ///
    /// - parameter aCoder: <#aCoder description#>
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(chs, forKey: "chs")
        aCoder.encodeObject(png, forKey: "png")
        aCoder.encodeObject(type, forKey: "type")
        aCoder.encodeObject(code, forKey: "code")
        aCoder.encodeObject(path, forKey: "path")
        aCoder.encodeObject(fullPath, forKey: "fullPath")
        aCoder.encodeBool(isEmoji, forKey: "isEmoji")
    }
    
    /// 解档
    ///
    /// - parameter aDecoder: <#aDecoder description#>
    ///
    /// - returns: <#return value description#>
    required init?(coder aDecoder: NSCoder) {
        chs = aDecoder.decodeObjectForKey("chs") as? String
        png = aDecoder.decodeObjectForKey("png") as? String
        type = aDecoder.decodeObjectForKey("type") as? String
        code = aDecoder.decodeObjectForKey("code") as? String
        path = aDecoder.decodeObjectForKey("path") as? String
        fullPath = aDecoder.decodeObjectForKey("fullPath") as? String
        isEmoji = aDecoder.decodeBoolForKey("isEmoji")
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    override func isEqual(object: AnyObject?) -> Bool {
        guard let other = object as? HMEmoticon else {
            return super.isEqual(object)
        }
        if other.isEmoji == isEmoji {
            if other.isEmoji {
                // 对比code
                // 移除当前遍历到的模型
                return (other.code! as NSString).isEqualToString(code!)
            }else {
                // 对比 chs
                // 移除当前遍历到的模型
                return (other.chs! as NSString).isEqualToString(chs!)
            }
        }
        return super.isEqual(object)
    }
}
