# 底部ToolBar

* 数据格式

| 属性名 | 类型 | 说明 |
| -- | -- | -- |
| reposts_count | int | 转发数 |
| comments_count | int | 评论数 |
| attitudes_count | int | 表态数 |

##  定义 `HMStatusToolBar`

```swift
class HMStatusToolBar: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.redColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
```

* 在 `HMStatusCell` 添加懒加载

```swift
// 底部工具条
private lazy var statusToolBar: HMStatusToolBar = HMStatusToolBar()
```

* 添加约束(并且更改底部约束)

```swift
// 添加原创微博内容的约束
originalView.snp_makeConstraints { (make) -> Void in
    // 关键：约束原创微博整体 View 的顶部
    make.top.equalTo(contentView.snp_top)
    make.width.equalTo(contentView.snp_width)
}

// 底部toolBar
statusToolBar.snp_makeConstraints { (make) -> Void in
    make.top.equalTo(originalView.snp_bottom).offset(HMStatusCellMargin)
    make.width.equalTo(originalView.snp_width)
    make.height.equalTo(35)
}

// 约束当前 contenView 关键：底部等于 statusToolBar 的底部
contentView.snp_makeConstraints { (make) -> Void in
    make.width.equalTo(self.snp_width)
    make.top.equalTo(self.snp_top)
    make.bottom.equalTo(statusToolBar.snp_bottom)
}

```
>  运行测试

## 添加子控件

* `UIButton` extension

```swift
extension UIButton {

    /// 便利构造一个Button
    ///
    /// - parameter title:     标题文字
    /// - parameter fontSize:  字体大小
    /// - parameter color:     文字颜色
    /// - parameter imageName: 图片名称
    ///
    convenience init(title: String, fontSize: CGFloat, color: UIColor, imageName: String? = nil){
        self.init()
        setTitle(title, forState: UIControlState.Normal)
        titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        setTitleColor(color, forState: UIControlState.Normal)
        // 如果有图片，则设置image
        if let imageN = imageName {
            imageView?.image = UIImage(named: imageN)
        }
    }
}
```

* 新增一个添加子控件的方法

```swift
/// 添加子控件
///
/// - parameter title: 显示的文字
/// - parameter image: 显示的图片
///
/// - returns: 将添加的 button 返回
private func addChildButton(title: String, image: String) -> UIButton {

    let button = UIButton(title: title, fontSize: 14, color: UIColor.darkGrayColor())

    // 设置不同状态的背景颜色
    button.setBackgroundImage(UIImage(named: "timeline_card_bottom_background_highlighted"), forState: UIControlState.Highlighted)
    button.setBackgroundImage(UIImage(named: "timeline_card_bottom_background"), forState: UIControlState.Normal)

    button.setImage(UIImage(named: image), forState: UIControlState.Normal)
    addSubview(button)
    return button
}
```

* 定义按钮属性

```swift
/// 转发按钮
var retweetButton: UIButton?
/// 评论按钮
var commentButton: UIButton?
/// 表态按钮
var attituedButton: UIButton?
```

* 添加子控件

```swift
private func setupUI(){
    // 1.添加子控件
    retweetButton = addChildButton("转发", image: "timeline_icon_retweet")
    commentButton = addChildButton("评论", image: "timeline_icon_comment")
    attituedButton = addChildButton("赞", image: "timeline_icon_unlike")
}
```

## 设置约束

* 设置思路：`转发按钮` -> A，`评论按钮` -> B，`赞按钮` -> C
    * A 按钮的左边紧贴父控件的左边，顶部和高度与父控件对齐
    * B 按钮的左边紧贴 A 按钮的右边，右边紧贴 C 按钮的左边， 顶部和高度与父控件对齐
    * C 按钮的右边紧贴父控件的右边，顶部和高度与父控件对齐
    * A 按钮的宽度 等于 B按钮的宽度，C 按钮的宽度等于 B 按钮的宽度

```swift
// 2.添加约束
retweetButton!.snp_makeConstraints { (make) -> Void in
    make.top.equalTo(self.snp_top)
    make.leading.equalTo(self.snp_leading)
    make.height.equalTo(self.snp_height)
    make.width.equalTo(commentButton!.snp_width)
}
commentButton!.snp_makeConstraints { (make) -> Void in
    make.leading.equalTo(retweetButton!.snp_trailing)
    make.trailing.equalTo(attituedButton!.snp_leading)
    make.top.equalTo(retweetButton!.snp_top)
    make.height.equalTo(self.snp_height)
}
attituedButton!.snp_makeConstraints { (make) -> Void in
    make.trailing.equalTo(self.snp_trailing)
    make.height.equalTo(self.snp_height)
    make.top.equalTo(retweetButton!.snp_top)
    make.width.equalTo(commentButton!.snp_width)
}
```
> 运行测试

* 添加分割线

```swift
/// 添加分割线
private func addSpliteView() -> UIImageView {
    let image = UIImageView(image: UIImage(named: "timeline_card_bottom_line"))
    addSubview(image)
    return image
}
```

* 设置约束

```swift
// 3.添加分割线
let sp1 = addSpliteView()
let sp2 = addSpliteView()

// 4.设置分割线的约束

sp1.snp_makeConstraints { (make) -> Void in
    make.centerX.equalTo(self.retweetButton!.snp_trailing)
    make.centerY.equalTo(self.retweetButton!.snp_centerY)
}
sp2.snp_makeConstraints { (make) -> Void in
    make.centerX.equalTo(self.commentButton!.snp_trailing)
    make.centerY.equalTo(self.commentButton!.snp_centerY)
}
```

## 设置数据

* 在 `HMStatus` 模型中添加以下属性

```swift
/// 转发数
var reposts_count: Int = 0
/// 评论数
var comments_count: Int = 0
/// 表态数
var attitudes_count: Int = 0
```

* 添加视图模型到 `HMStatusToolBar` 中

```swift
/// 视图模型
var statusViewModel: HMStatusViewModel?
```

* `HMStatusCell` 里面设置此属性

```swift
/// 微博视图模型
var statusViewModel: HMStatusViewModel? {
    didSet{
        // 设置原创微博内容的视图模型
        originalView.statusViewModel = statusViewModel
        // 设置底部 ToolBar 的视图模型
        statusToolBar.statusViewModel = statusViewModel
    }
}
```

* 数量显示逻辑
    * 小于 10000，直接显示数字
    * 大于 10000，小于 11000，显示 `1万`
    * 大于 11000，小于 20000，显示 `1.x万`
    * 其他同理

* 在 `视图模型` 里面添加 `repostsCountString` 属性

```swift
/// 转发数量
var repostsCountString: String {
    // 默认显示 `转发`
    var result = "转发"
    let count = status?.reposts_count ?? 0

    // 如果数量为 0,直接显示 `转发`
    if count == 0 {
        return result
    }

    // 如果数量大于10000，再做处理
    if count > 10000 {
        // 先除以1000返回一个整数，再除以10，返回一个小数
        let res = Float(count / 1000) / 10
        // 拼接字符串
        result = "\(res)万"
    }else{
        result = "\(status!.reposts_count)"
    }
    return result
}
```

* 添加测试数据（在 `HMStatus` 中添加 `reposts_count` 的 didSet 方法）

```swift
/// 转发数
var reposts_count: Int = 0 {
    didSet{
        reposts_count = 10009
    }
}
```
> 测试发现显示 `1.0万`

* 添加判断小数为 0 的逻辑

```swift
// 查看是否包含 .0 万
if result.containsString(".0万") {
    result = result.stringByReplacingOccurrencesOfString(".0", withString: "")
}
```

* 在 `视图模型` 里面添加 `repostsCountString` 和 `` 属性

```swift
/// 评论数量
var commentsCountString: String {
    return "评论"
}
/// 点赞数量
var attitudesCountString: String {
    return "赞"
}
```

* 抽取处理数量逻辑的方法

```swift
/// 处理 转发\评论\赞 数量逻辑
///
/// - parameter count:          对应数量
/// - parameter defaultString:  默认显示的文字
///
private func countString(count: Int, defaultString: String) -> String {

    var result = defaultString
    if count == 0 {
        return result
    }

    // 如果数量大于10000，再做处理
    if count > 10000 {
        let res = Float(count / 1000) / 10
        result = "\(res)万"
        // 查看是否包含 .0 万
        if result.containsString(".0万") {
            result = result.stringByReplacingOccurrencesOfString(".0", withString: "")
        }
    }else{
        result = "\(count)"
    }
    return result
}
```

* 更改三个属性的 get 方法

```swift
/// 转发数量
var repostsCountString: String {
    let count = status?.reposts_count ?? 0
    return countString(count, defaultString: "转发")
}
/// 评论数量
var commentsCountString: String {
    let count = status?.comments_count ?? 0
    return countString(count, defaultString: "评论")
}
/// 点赞数量
var attitudesCountString: String {
    let count = status?.attitudes_count ?? 0
    return countString(count, defaultString: "赞")
}
```

> 运行测试（也可以将这三个属性设置成存储型属性）
