# 首页完善

## 实现功能

- 首页表情显示
- 特殊字符高亮显示
- 特殊字符点击处理


## 首页表情显示

### 步骤
1. 将微博内容字符串生成一个 `NSMutableAttributedString`
- 需要匹配到表情字符串
- 通过表情字符找到对应表情模型
- 通过表情模型生成富文本(`NSAttributedString`)
- 将第 1 步里面的表情字符串替换成表情的富文本
- 将以上结果设置微博内容的 `UILabel`的 `attributedString`


### 代码实现

- RegexKitLite
    - 拖入 `RegexKitLite` 正则匹配第三方库
    - 导入 `libicucure` 框架
    - 设置 `RegexKitLite.m` 的 `Compiler Flags` 为 `-fno-objc-arc` （指定以 MRC 模式编译文件）

- 在 `HMStatusViewModel` 添加 `dealStatusText` 方法，处理微博内容字符串

```swift
private func dealStatusText(statusText: String?) -> NSMutableAttributedString? {
    return nil
}
```

- 匹配表情字符串
    - 表达式：`"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]"`

```swift
private func dealStatusText(statusText: String?) -> NSMutableAttributedString? {
    // 匹配表情字符串
    guard let text = statusText as NSString? else {
        return nil
    }

    /**
        第一个参数：正则表达式
        第二个参数：闭包，其参数：
            captureCount: 捕获个数
            captureString: 捕获的 String，指针
            captureRange: 捕获的 范围，指针
            stop: 是否停止捕获，指针
    */
    text.enumerateStringsMatchedByRegex("\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]") { (captureCount, captureString, captureRange, stop) -> Void in
        printLog(captureString.memory)
    }
    return nil
}
```

- 在 `HMStatusViewModel` 的 `setStatus` 方法中测试以上方法

```swift
/// 一些计算的逻辑
private func setStatus(){
    ...
    dealStatusText(status?.text)
}
```

- 定义 `HMMatchResult`

```swift
class HMMatchResult: NSObject {

    var captureString: String?
    var captureRange: NSRange?

    init(captureString: String, captureRange: NSRange) {
        self.captureRange = captureRange
        self.captureString = captureString
        super.init()
    }

}
```

- 使用数组保存匹配结果

```swift
// 利用数组保存匹配结果
var matchResults = [HMMatchResult]()

text.enumerateStringsMatchedByRegex("\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]") { (captureCount, captureString, captureRange, stop) -> Void in
    printLog(captureString.memory)

    let matchResult = HMMatchResult(captureString: captureString.memory! as String, captureRange: captureRange.memory)
    matchResults.append(matchResult)
}
```

- 通过表情字符串获取到表情模型
    - 在 `HMEmoticonTools` 中添加方法 `emoticonWithChs:`

```swift
/// 通过表情描述文字查找到对应有表情
///
/// - parameter chs: 表情描述文字
///
/// - returns: 表情模型
func emoticonWithChs(chs: String) -> HMEmoticon? {

    for emoticon in defaultEmoticons {
        if emoticon.chs == chs {
            return emoticon
        }
    }
    for emoticon in lxhEmoticons {
        if emoticon.chs == chs {
            return emoticon
        }
    }
    return nil
}
```

- 反转遍历数组，替换表情字符串

```swift
private func dealStatusText(statusText: String?) -> NSMutableAttributedString? {
    // 匹配表情字符串
    guard let text = statusText as NSString? else {
        return nil
    }
    // 将内容转成富文本
    let result = NSMutableAttributedString(string: text as String)

    // 利用数组保存匹配结果
    var matchResults = [HMMatchResult]()

    text.enumerateStringsMatchedByRegex("\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]") { (captureCount, captureString, captureRange, stop) -> Void in
        printLog(captureString.memory)

        let matchResult = HMMatchResult(captureString: captureString.memory! as String, captureRange: captureRange.memory)
        matchResults.append(matchResult)
    }


    // 反转遍历匹配结果
    // 为什么要返转遍历替换：原因就是如果从前往后替换的话会出现越界异常
    for matchResult in matchResults.reverse() {

        let emoticon = HMEmoticonTools.emoticonWithChs(matchResult.captureString! as String)

        if let emo = emoticon {
            // 通过表情模型生成 `NSAttributedString`
            // 通过表情模型初始化一个图片
            let image = UIImage(named: "\(emo.path!)/\(emo.png!)")
            // 初始化文字附件，设置图片
            let attatchment = HMEmoticonAttachment(chs: emo.chs!)
            attatchment.image = image
            // 图片宽高与文字的高度一样
            let imageWH = HMStatusContentFontSize
            // 调整图片大小 --> 解决图片大小以及偏移问题
            attatchment.bounds = CGRectMake(0, -4, imageWH, imageWH)

            // 通过文字附件初始化一个富文本
            let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(attachment: attatchment))

            result.replaceCharactersInRange(matchResult.captureRange!, withAttributedString: attributedString)
        }
    }

    // 设置整个富文本的字体大小
    result.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(HMStatusContentFontSize), range: NSMakeRange(0, result.length))

    return result
}
```

- 定义原创微博富文本属性，记录转换之后的原创微博富文本

```swift
/// 原创微博正文内容富文本
var originalStatusAttributedString: NSMutableAttributedString?


/// 一些计算的逻辑
private func setStatus(){
    // 来源字符串
    sourceText = dealSourceText(status?.source)
    originalStatusAttributedString = dealStatusText(status?.text)
}
```

- 在 `HMStatusOriginalView` 中设置原创微博内容

```swift
/// 微博视图模型
var statusViewModel: HMStatusViewModel? {
    didSet{
        ...
        contentLabel.attributedText = statusViewModel?.originalStatusAttributedString
        ...
        }
    }
}

```

> 运行测试

- 添加转发微博富文本属性，记录转换之后的转发微博富文本

```swift
var retweetStatusAttributedString: NSMutableAttributedString?


/// 一些计算的逻辑
private func setStatus(){
    // 来源字符串
    sourceText = dealSourceText(status?.source)
    originalStatusAttributedString = dealStatusText(status?.text)
    retweetStatusAttributedString = dealStatusText(retweetText)
}
```

- 在 `HMStatusRetweetView` 中设置转发微博的内容

```swift
/// 微博视图模型
var statusViewModel: HMStatusViewModel?{
    didSet{
        contentLabel.attributedText = statusViewModel!.retweetStatusAttributedString
        ...
    }
}
```

> 运行测试


## 特殊字符高亮显示

实现步骤：
- 在获取到表情的富文本的基础之上，匹配到对应特殊字符
- 在给富文本中特殊字符添加颜色的属性


### 代码实现

- 匹配 `@xxx`
    - 匹配规则：@ 后面不能出现空格、标点之类不是字母数字下划线汉字的字符
    - 所以正则表达式为：`@[^\\W]+`

- 添加 `addHighLightAttr:` 方法

```swift
/// 给特殊字符添加颜色
///
/// - parameter attrString: 需要添加特殊字符高亮的富文本
private func addHighLightedAttr(attrString: NSMutableAttributedString) {

    // 匹配特殊字符串并高亮
}
```

- 在 `dealStatusText` 方法中返回结果之前调用此方法

```swift
private func dealStatusText(statusText: String?) -> NSMutableAttributedString? {
    ...

    // 添加特殊字符高亮
    addHighLightedAttr(result)

    // 设置整个富文本的字体大小
    result.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(HMStatusContentFontSize), range: NSMakeRange(0, result.length))

    return result
}
```

- 在 `addHighLightedAttr:` 中匹配 `@xxx`

```swift
// 匹配 `@`
(attrString.string as NSString).enumerateStringsMatchedByRegex("@[^\\s^:^，]+") { (captureCount, captureString, captureRange, stop) -> Void in
    attrString.addAttribute(NSForegroundColorAttributeName, value: RGB(r: 80, g: 125, b: 175), range: captureRange.memory)
}
```

- 匹配话题(#)
    - 匹配规则：# 与 # 中间不能出现 #
    - 正则表达式为：`#[^#]+#`

```swift
// 匹配 `#`
(attrString.string as NSString).enumerateStringsMatchedByRegex("#[^#]+#") { (captureCount, captureString, captureRange, stop) -> Void in
    attrString.addAttribute(NSForegroundColorAttributeName, value: RGB(r: 80, g: 125, b: 175), range: captureRange.memory)
}
```

- 匹配 url
    - 匹配规则：`http://` 后面不能跟空格和汉字
    - 正则表达式为：`http(s)?://[^\\s^\\u4e00-\\u9fa5]+`

```swift
// 匹配 `url`
(attrString.string as NSString).enumerateStringsMatchedByRegex("http(s)?://[^\\s^\\u4e00-\\u9fa5]+") { (captureCount, captureString, captureRange, stop) -> Void in
    attrString.addAttribute(NSForegroundColorAttributeName, value: RGB(r: 80, g: 125, b: 175), range: captureRange.memory)
}
```

## 特殊字符点击处理

### 实现思路
- 获取到手指在控件上点击的点
    - 监听 touchBegin 方法
- 获取到那个点对应的字符串范围
    - UITextView 身上有此方法
- 获取到此控件中所有的特殊字符串的范围
    - 在匹配特殊字符串的时候保存特殊字符串的范围
- 遍历查询`手指点击对应的字符串范围`是在哪一个`特殊字符串的范围内容`内
    - for 循环遍历，使用 `NSLocationInRange` 的方法判断某个位置是否在某个范围之内
- 如果查询到，将其高亮
    - 可以给对应范围添加一个`背景颜色`的属性或者直接在对应位置添加子视图

### 代码实现

- 新建 `HMStatusLabel` 继承于 `UILabel`

```swift
class HMStatusLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI(){

    }
}

```

- 将转发微博View `HMStatusRetweetView` 中显示文字的 label 设置成 `HMStatusLabel`

```swift
private lazy var contentLabel: HMStatusLabel = HMStatusLabel(textColor: UIColor.darkGrayColor(), fontSize: HMStatusContentFontSize, maxLayoutWidth: UIScreen.mainScreen().bounds.width - 2 * HMStatusCellMargin)
```

- 往 `HMStatusLabel` 内部添加一个 `UITextView` 并添加约束

```swift
class HMStatusLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        userInteractionEnabled = true;
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI(){
        addSubview(textView)
        textView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
        }
    }
    // MARK: - 懒加载控件
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.alpha = 0.0
        return textView
    }()
}
```

- 重写 `HMStatusLabel` 的 `attributedText` 属性，在赋值的时候设置 textView 的 `attributedText`

```swift
override var attributedText: NSAttributedString? {
    didSet{
        textView.attributedText = attributedText
    }
}
```

> 运行测试：发现 textView 显示的内容与 label 显示的内容没有对齐，原因是 textView 里面的内容默认有一个间距

- 设置 textView 的 `textContainerInset`

```swift
textView.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5)
```

- 重写 `touchesBegan` 方法，在方法内部取到当前用户点击的点

```swift
override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let touch = touches.first!
    let location = touch.locationInView(self)
    print(location)
}
```
- 通过点取到用户点击的字符范围

```swift
// 获取到用户点击对应的字符范围
let textRange = textView.characterRangeAtPoint(location)
textView.selectedTextRange = textRange
let range = textView.selectedRange
print(range)
```

- 问题：需要获取到当前 label 里面特殊文字的范围
    - 在 `HMStatusViewModel` 中添加原创微博以及转发微博特殊文字的匹配结果数组

```swift
// 转发微博匹配内容
var retweetMatchResults: [HMMatchResult]?
// 原创微博匹配内容
var originalMatchResults: [HMMatchResult]?
```

- 更改 `dealStatusText` 方法返回值 `元组`

```swift
private func dealStatusText(statusText: String?) -> (attr: NSMutableAttributedString?, linkMatchResults: [HMMatchResult]?) {}
```

- 给 `addHighLightedAttr` 方法添加返回值 `[HMMatchResult]`

```swift
/// 添加高亮属性
///
/// - parameter attributedString:
private func addHighLightAttr(attributedString: NSMutableAttributedString) -> [HMMatchResult] {

    // 定义匹配结果数组
    var matchResult = [HMMatchResult]()


    // 匹配话题
    (attributedString.string as NSString).enumerateStringsMatchedByRegex("#[^#]+#") { (captureCount, caputureString, captureRange, stop) -> Void in
        attributedString.addAttribute(NSForegroundColorAttributeName, value: RGB(r: 80, g: 125, b: 175), range: captureRange.memory)
        // 保存匹配结果
        let result = HMMatchResult(captureString: caputureString.memory! as String, captureRange: captureRange.memory)
        matchResult.append(result)

    }
    ...
    // 返回结果
    return matchResult
}
```

- 更改 `dealStatusText` 方法处理结果

```swift
let resultResult = dealStatusText(retweetText)
retweetStatusAttributedString = resultResult.attr
retweetMatchResults = resultResult.linkMatchResults
...
let originalResult = dealStatusText(status.text)
originalStatusAttributedString = originalResult.attr
originalMatchResults = originalResult.linkMatchResults
```

- 在 `HMStatusLabel` 添加特殊字符匹配结果的属性

```swift
var linkMatchResult: [HMMatchResult]?
```

- 在给原创微博View(转发微博)设置数据的时候给 `HMStatusLabel` 设置 `linkMatchResult` 属性

```swift
contentLabel.linkMatchResult = statusViewModel?.originalMatchResults
```

- 在 `HMStatusLabel` 的 `touchesBegan` 方法里面判断当前用户点击的点是在哪一个 result 范围内

```swift
// 查看在哪一个 result 范围之内
for value in linkMatchResult! {
    // 当前用户点击的位置是特殊字符的位置
    if NSLocationInRange(range.location, value.captureRange) {
        print(value.captureString)

    }
}
```

- 设置 textView 当前选中的范围

```swift
textView.selectedRange = value.captureRange
```

```swift
// 根据 textView 取到当前用户点击的范围并添加 View
let rects = textView.selectionRectsForRange(textView.selectedTextRange!)
for rect in rects {
    let r = rect as! UITextSelectionRect
    let view = UIView(frame: r.rect)
    view.layer.cornerRadius = 5
    view.layer.masksToBounds = true
    view.backgroundColor = RGB(r: 177, g: 215, b: 255)
    self.insertSubview(view, atIndex: 0)
}
```

> 运行测试

- 利用数组保存上一步添加的 view

```swift
lazy var linkSubView: [UIView] = [UIView]()
...
for rect in rects {
    ...
    self.insertSubview(view, atIndex: 0)
    linkSubView.append(view)
}
```
- 在 `touchesEnded` 方法里面遍历数组将控件从父控件中移除并清空集合

```swift
override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    for value in linkSubView {
        value.removeFromSuperview()
    }
    linkSubView.removeAll()
}
```

- 重写 `touchesCancelled` ，并在内部调用 `touchesEnded` 方法

```swift
override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
    touchesEnded(touches!, withEvent: event)
}
```
> 运行测试













