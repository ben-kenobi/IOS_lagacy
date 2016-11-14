# 最近表情

## 最近表情保存思路

1. `HMEmoticonTools` 提供保存最近表情的方法 `saveRecentEmoticon`
- 利用归档的形式保存
- 点击表情按钮的时候调用 `saveRecentEmoticon`
- 添加最近表情的时候记得去重
- 不能超过20个


- 提供保存最近表情的方法

```swift
// MARK: - 最近消息保存

func saveRecentEmoticon(emoticon: HMEmoticon){
    printLog("最近表情重复")
}
```

- 在表情按钮点击的时候调用此方法

```swift
// MARK: - 监听事件
@objc private func emoticonButtonClick(button: HMEmoticonButton){
    printLog("表情按钮点击")
    if let emoticon = button.emoticon {

        // 保存最近消息
        HMEmoticonTools.shareTools.saveRecentEmoticon(emoticon)
        ...
    }
}
```

- 添加到最近表情数据并设置到总数据的数组里

```swift
func saveRecentEmoticon(emoticon: HMEmoticon){
    // 添加到最近表情
    recentEmoticons.append(emoticon)
    allEmoticons[0][0] = self.recentEmoticons
}
```

> 运行测试：发现最近点击的表情添加到后面了

- 将最近点击的表情添加到数据前面

```swift
func saveRecentEmoticon(emoticon: HMEmoticon){
    // 添加到最近表情
    recentEmoticons.insert(emoticon, atIndex: 0)
    allEmoticons[0][0] = self.recentEmoticons
}
```
- 将最近表情归档，以下次启动的时候显示最近表情

```swift
// 懒加载归档路径
/// 最近消息保存路径
private lazy var recentArchivePath: String = {
    let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first!
    return (path as NSString).stringByAppendingPathComponent("recent.archive")
}()
```

- 表情模型继承 `NSCoding` 协议，实现协议方法

```swift
class HMEmoticon: NSObject, NSCoding {
    ...

    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(chs, forKey: "chs")
        aCoder.encodeObject(png, forKey: "png")
        aCoder.encodeObject(path, forKey: "path")
        aCoder.encodeObject(fullPath, forKey: "fullPath")
        aCoder.encodeBool(isEmoji, forKey: "isEmoji")
        aCoder.encodeInteger(type, forKey: "type")
        aCoder.encodeObject(code, forKey: "code")
    }

    required init?(coder aDecoder: NSCoder) {
        chs = aDecoder.decodeObjectForKey("chs") as? String
        png = aDecoder.decodeObjectForKey("png") as? String
        path = aDecoder.decodeObjectForKey("path") as? String
        fullPath = aDecoder.decodeObjectForKey("fullPath") as? String
        isEmoji = aDecoder.decodeBoolForKey("isEmoji")
        type = aDecoder.decodeIntegerForKey("type")
        code = aDecoder.decodeObjectForKey("code") as? String
    }
    ...
}
```

- 在 `saveRecentEmoticon` 方法中归档最近表情

```swift
func saveRecentEmoticon(emoticon: HMEmoticon){
    // 添加到最近表情
    recentEmoticons.insert(emoticon, atIndex: 0)
    allEmoticons[0][0] = self.recentEmoticons
    // 保存最近消息
    NSKeyedArchiver.archiveRootObject(recentEmoticons, toFile: recentArchivePath)
}
```

- 更改最近表情的懒加载方式(从文件里面解档)

```swift
/// 最近表情
private lazy var recentEmoticons: [HMEmoticon] = {
    let result = NSKeyedUnarchiver.unarchiveObjectWithFile(self.recentArchivePath) as? [HMEmoticon]
    if result == nil {
        return [HMEmoticon]()
    }
    return result!
}()
```


- 多次点击相同的表情，发现表情重复,去除重复表情

```swift
func saveRecentEmoticon(emoticon: HMEmoticon){
    // 去掉重复
    for (i,value) in recentEmoticons.enumerate() {
        if value.isEmoji == emoticon.isEmoji {
            if emoticon.isEmoji {
                if (value.code! as NSString).isEqualToString(emoticon.code!) {
                    recentEmoticons.removeAtIndex(i)
                }
            }else {
                if (value.chs! as NSString).isEqualToString(emoticon.chs!) {
                    recentEmoticons.removeAtIndex(i)
                }
            }
        }
    }
    // 添加到最近表情
    recentEmoticons.insert(emoticon, atIndex: 0)
    allEmoticons[0][0] = self.recentEmoticons
    // 保存最近消息
    NSKeyedArchiver.archiveRootObject(recentEmoticons, toFile: recentArchivePath)
}
```

- 最近表情最多20个，所以在添加完成之后去掉多余的

```swift
func saveRecentEmoticon(emoticon: HMEmoticon){
    ...
    // 添加到最近表情
    recentEmoticons.insert(emoticon, atIndex: 0)
    // 如果超出20个，则移除
    while recentEmoticons.count > HMEmoticonNumOfPage {
        recentEmoticons.removeLast()
    }
    ...
}
```

> 运行测试

