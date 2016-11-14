//
//  HMEmoticonTools.swift
//  Weibo11
//
//  Created by itheima on 15/12/15.
//  Copyright © 2015年 itheima. All rights reserved.
//  类似 viewmodel --> 提供数据处理的方法 --> 其对应的View为表情键盘上的 collectionView

import UIKit


// 一页表情有多少行
let HMEmoticonsRowOfPage = 3
// 一页表情有多少列
let HMEmoticonsColOfPage = 7
/// 一页显示多少个表情数据
let HMEmoticonsNumOfPage = HMEmoticonsRowOfPage * HMEmoticonsColOfPage - 1

class HMEmoticonTools: NSObject {
    
    // 提供全局访问点
    static let shareTools: HMEmoticonTools =  HMEmoticonTools()

    // 表情数据的 bundle 文件
    lazy var emoticonBundle: NSBundle = {
        let path = NSBundle.mainBundle().pathForResource("Emoticons.bundle", ofType: nil)!
        return NSBundle(path: path)!
    }()
    
    // 最近表情
    private lazy var recentEmoticons: [HMEmoticon] = {
        // 解档
        var result = NSKeyedUnarchiver.unarchiveObjectWithFile(self.recentArchivePath) as? [HMEmoticon]
        if result == nil {
            result = [HMEmoticon]()
        }
        return result!
    }()
    
    // 读取默认表情数据
    private lazy var defaultEmoticons: [HMEmoticon] = {
        // default/info.plist
        return self.emoticonsWithPath("default/info.plist")
    }()
    
    /// emoji表情
    private lazy var emojiEmoticons: [HMEmoticon] = {
        return self.emoticonsWithPath("emoji/info.plist")
    }()
    
    /// 浪小花表情
    private lazy var lxhEmoticons: [HMEmoticon] = {
        return self.emoticonsWithPath("lxh/info.plist")
    }()
    
    /// 最近表情归档的路径
    private lazy var recentArchivePath: String = {
        let path = (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! as NSString).stringByAppendingPathComponent("recent.archive")
        return path
    }()
    
    /// 供表情键盘的 collectionView 使用的数据
    lazy var allEmoticons: [[[HMEmoticon]]] = {
        return [
            self.sectionWithEmoticons(self.recentEmoticons),
            self.sectionWithEmoticons(self.defaultEmoticons),
            self.sectionWithEmoticons(self.emojiEmoticons),
            self.sectionWithEmoticons(self.lxhEmoticons)
        ]
    }()
    
    // MARK: - 供外界调用的方法
    
    
    /// 通过表情字符串,找表情模型
    ///
    /// - parameter chs: <#chs description#>
    ///
    /// - returns: <#return value description#>
    func emoticonWithChs(chs: String) -> HMEmoticon? {
        
        // 谓词搜索
        // 相当给条件,系统会帮把符合我们条件的子条目放在数组里面返回
        let p = NSPredicate(format: "chs == %@", chs)
        var result = (defaultEmoticons as NSArray).filteredArrayUsingPredicate(p)
        
        if let first = result.first as? HMEmoticon{
            return first
        }
    
        result =  (lxhEmoticons as NSArray).filteredArrayUsingPredicate(p)
        if let first = result.first as? HMEmoticon{
            return first
        }
        
        
        // 从默认里面找
        
//        for value in defaultEmoticons {
//            if (value.chs! as NSString).isEqualToString(chs) {
//                return value
//            }
//        }
//        // 从浪小花里面找
//        for value in lxhEmoticons {
//            if (value.chs! as NSString).isEqualToString(chs) {
//                return value
//            }
//        }
        return nil
    }
    
    /// 保存最近表情
    ///
    /// - parameter emoticon: <#emoticon description#>
    func saveRecent(emoticon: HMEmoticon) {
        
//        let array = NSMutableArray()
//        array.removeObject(emoticon)
        
        let array = recentEmoticons as NSArray
        // 通过一个模型找到其在集合里面的位置
        // 最关键是,我们重写了对象身上的 isEqual 方法
        let index = array.indexOfObject(emoticon)
        if index != NSNotFound {
            recentEmoticons.removeAtIndex(index)
        }
        
        
//        //  遍历的时候移除集合里面元素是有问题
//        // 0. 判断内部是否有传入进来的表情.如果有,直接干掉
//        for (index, value) in recentEmoticons.enumerate() {
//            
//            // 拿到当前遍历到的表情模型与传入的表情模型进行对比 
//            // 怎么判断两个表情是否是一样: 图片表情 chs ,emoji code
//            
//            if value.isEmoji == emoticon.isEmoji {
//                // 代码执行到这个地方,就代表表情类型一样
//                if value.isEmoji {
//                    if (value.code! as NSString).isEqualToString(emoticon.code!) {
//                        // 移除当前遍历到的模型
//                        recentEmoticons.removeAtIndex(index)
//                    }
//                }else{
//                    if (value.chs! as NSString).isEqualToString(emoticon.chs!) {
//                        // 移除当前遍历到的模型
//                        recentEmoticons.removeAtIndex(index)
//                    }
//                }
//            }
//        }
        // 1. 将当前表情模型添加到 最近表情的数组里面去
        recentEmoticons.insert(emoticon, atIndex: 0)
        
        // 2. 把超出20个的表情数据给干掉
        while recentEmoticons.count > 20 {
            recentEmoticons.removeLast()
        }
        
        // 3. 更新数据
        allEmoticons[0][0] = recentEmoticons
        
        // 4. 归档
        NSKeyedArchiver.archiveRootObject(recentEmoticons, toFile: recentArchivePath)
    }
    
    
    /// 比如: Emoji表情为80个 --> 分成 4组,每一组20个 --> [[HMEmoticon]]
    ///
    /// - parameter emoticons: <#emoticons description#>
    ///
    /// - returns: <#return value description#>
    private func sectionWithEmoticons(emoticons: [HMEmoticon]) -> [[HMEmoticon]] {
        
        // 80 / 20 = 4
        // 1. 取到当前表情一共有多少页
        // 95
        let pageCount = (emoticons.count - 1) / HMEmoticonsNumOfPage  + 1
        // 定义一个返回的数组
        var result = [[HMEmoticon]]()
        // 2. 遍历截取每一页显示的数据
        for i in 0..<pageCount {
            
            // 计算截取范围
            let location = i * HMEmoticonsNumOfPage
            var length = HMEmoticonsNumOfPage
            // 如果开始截取位置加上截取长度大于数组的个数,那么就代表越界
            if location + length > emoticons.count {
                // 调整 length --> 数组的长度 - 开始截取的位置
                length = emoticons.count - location
            }
            
            let range = NSMakeRange(location, length)
            
            // 截取子数组
            let subArray = (emoticons as NSArray).subarrayWithRange(range) as! [HMEmoticon]
            // 添加到返回数组内
            result.append(subArray)
        }
        return result
    }
    
    
    /// 读取表情数据
    ///
    /// - parameter path: 对应表情 bundle 里面的 路径 (比如: lxh/info.plist)
    ///
    /// - returns: 对应表情数组
    private func emoticonsWithPath(path: String) -> [HMEmoticon]{
        let file = self.emoticonBundle.pathForResource(path, ofType: nil)!
        // 读取 info.plist 文件里面的内容
        let array = NSArray(contentsOfFile: file)!
        var result = [HMEmoticon]()
        for value in array {
            // 判断是否是字典
            if let dict = value as? [String: AnyObject] {
                // 读取 info.plist 文件路径是 file
                // 因为图片是与 info.plist 文件放在一起的,所以其前面路径一样
                // 所以就把 `file` 后面的文件名删掉
                let emoticon = HMEmoticon(dict: dict)
                emoticon.path = (path as NSString).stringByDeletingLastPathComponent
                result.append(emoticon)
            }
        }
        return result
    }
    
}
