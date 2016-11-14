#原创微博内容的 View
* `HMStatusOriginalView`

```swift
class HMStatusOriginalView: UIView {

    /// 微博视图模型
    var statusViewModel: HMStatusViewModel?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = UIColor.redColor()
    }
}
```


* 定义懒加载控件

```swift
// MARK: - 懒加载控件
private lazy var originalView: HMStatusOriginalView = HMStatusOriginalView()
```

* 添加顶部视图

```swift
private func setupUI() {
    // 1. 添加控件
    contentView.addSubview(originalView)

    // 2. 添加约束
    // 添加原创微博内容的约束
    originalView.snp_makeConstraints { (make) -> Void in
        make.top.equalTo(contentView.snp_top)
        make.width.equalTo(self.snp_width)
        make.height.equalTo(47)
    }
}
```

## 原创微博内容布局

* 设置数据

```swift
/// 微博视图模型
var statusViewModel: HMStatusViewModel? {
    didSet {
        originalView.statusViewModel = statusViewModel
    }
}
```

* 懒加载控件

```swift
// MARK: - 懒加载控件
/// 头像
private lazy var iconView = UIImageView()
/// 姓名
private lazy var nameLabel = UILabel(color: UIColor.darkGrayColor(), fontSize: 14)
/// 微博认证
private lazy var verifiedIconView: UIImageView = UIImageView(image: UIImage(named: "avatar_vip"))
/// VIP图标
private lazy var memberIconView: UIImageView = UIImageView(image: UIImage(named: "common_icon_membership_level1"))
/// 时间
private lazy var timeLabel = UILabel(color: UIColor.orangeColor(), fontSize: 10)
/// 来源
private lazy var sourceLabel = UILabel(color: UIColor.darkGrayColor(), fontSize: 10)
```

* 抽取部分常量到 `HMStatusCell` 中

```swift
// 头像的大小与宽度
let HMStatusHeadImageWH: CGFloat = 35
// 昵称字体大小
let HMStatusNameFontSize: CGFloat = 14
// 来源与时间的字体大小
let HMStatusSourceFontSize: CGFloat = 10
// 微博正文字体大小
let HMStatusContentFontSize: CGFloat = 15
```

* 定义间距常量 (定义到 `HMStatusCell` 里)

```swift
/// 控件间距
let HMStatusCellMargin: CGFloat = 10
```

* 添加控件 & 自动布局

```swift
private func setupUI() {
    // 1. 添加控件
    addSubview(iconView)
    addSubview(nameLabel)
    addSubview(verifiedIconView)
    addSubview(memberIconView)
    addSubview(timeLabel)
    addSubview(sourceLabel)

    // 2. 添加约束
    // 头像
    iconView.snp_makeConstraints { (make) -> Void in
        make.leading.equalTo(HMStatusCellMargin)
        make.top.equalTo(HMStatusCellMargin)
        make.size.equalTo(CGSizeMake(35, 35))
    }
    // 名称
    nameLabel.snp_makeConstraints { (make) -> Void in
        make.leading.equalTo(self.iconView.snp_trailing).offset(HMStatusCellMargin)
        make.top.equalTo(self.iconView.snp_top)
    }
    // 认证图标
    verifiedIconView.snp_makeConstraints { (make) -> Void in
        make.centerX.equalTo(self.iconView.snp_trailing)
        make.centerY.equalTo(self.iconView.snp_bottom)
    }
    // 会员图标
    memberIconView.snp_makeConstraints { (make) -> Void in
        make.centerY.equalTo(self.nameLabel.snp_centerY)
        make.leading.equalTo(self.nameLabel.snp_trailing).offset(HMStatusCellMargin)
    }

    // 时间
    timeLabel.snp_makeConstraints { (make) -> Void in
        make.leading.equalTo(self.nameLabel.snp_leading)
        make.bottom.equalTo(self.iconView.snp_bottom)
    }
    // 来源
    sourceLabel.snp_makeConstraints { (make) -> Void in
        make.leading.equalTo(self.timeLabel.snp_trailing).offset(HMStatusCellMargin)
        make.centerY.equalTo(self.timeLabel.snp_centerY)
    }

}
```

* 设置原创微博数据

```swift
/// 微博视图模型
var statusViewModel: HMStatusViewModel? {
    didSet{
        // 昵称
        nameLabel.text = statusViewModel?.status?.user?.name

        // TODO: 需要处理细节
        timeLabel.text = "刚刚"
        sourceLabel.text = "来自 weibo.com"
    }
}
```

* 设置 tableView 的行高为200

```swift
// TODO: 测试行高
tableView.rowHeight = 200
```
> 运行测试

## 设置顶部数据

* 在 `HMStatusViewModel` 模型中添加 `userProfileUrl` 属性

```swift
/// 用户头像URL
var userProfileUrl: NSURL? {
    return NSURL(string: status?.user?.profile_image_url ?? "")
}
```

* 在 `HMStatusOriginalView` 中设置头像

```swift
iconView.sd_setImageWithURL(statusViewModel?.userProfileUrl, placeholderImage: UIImage(named: "avatar_default_small"))
```

* 在 `HMStatusViewModel` 模型中添加 `userVerifiedImage` 属性

```swift
/// 用户认证图像
/// 认证类型 -1：没有认证，1，认证用户，2,3,5: 企业认证，220: 达人
var userVerifiedImage: UIImage? {
    switch status?.user?.verified ?? 0 {
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
```

* 在 `HMStatusViewModel` 模型中添加 `userMemberImage`

```swift
/// 会员图像
var userMemberImage: UIImage? {
    if status?.user?.mbtype > 2 && status?.user?.mbrank > 0 && status?.user?.mbrank < 7 {
        return UIImage(named: "common_icon_membership_level\(status!.user!.mbrank)")
    }
    return nil
}
```

* 调整后的设置数据方法

```swift
/// 微博视图模型
var statusViewModel: StatusViewModel? {
    didSet {
        iconView.sd_setImageWithURL(statusViewModel?.userProfileUrl)
        nameLabel.text = statusViewModel?.status?.user?.name
        vipIconView.image = statusViewModel?.userVipImage
        memberIconView.image = statusViewModel?.userMemberImage

        // TODO: - 设置文字细节
        timeLabel.text = "刚刚"
        sourceLabel.text = "来自 皮皮时光机"
    }
}
```

## 正文文字

添加正文文字 label 到 `HMStatusOriginalView`

* 扩展 便利构造函数

```swift
/// 遍历构造函数
///
/// - parameter color:    颜色
/// - parameter fontSize: 字体大小
///
/// - returns: UILabel
convenience init(color: UIColor, fontSize: CGFloat, layoutWidth: CGFloat = 0) {
    self.init()

    textColor = color
    font = UIFont.systemFontOfSize(fontSize)

    if layoutWidth > 0 {
        numberOfLines = 0
        preferredMaxLayoutWidth = layoutWidth
    }
}
```

* 懒加载方法

```swift
/// 微博正文
private lazy var contentLabel: UILabel = UILabel(color: UIColor.darkGrayColor(), fontSize: 15, layoutWidth: UIScreen.mainScreen().bounds.width - 2 * HMStatusCellMargin)
```

* 自动布局

```swift
addSubview(contentLabel)

//  微博文字
contentLabel.snp_makeConstraints { (make) -> Void in
    make.leading.equalTo(self.iconView.snp_leading)
    make.top.equalTo(self.iconView.snp_bottom).offset(HMStatusCellMargin)
}
```

* 关键：添加底部约束

```swift
// 约束当前 View 的底部与正文内容的底部一样
snp_makeConstraints { (make) -> Void in
    make.bottom.equalTo(contentLabel.snp_bottom)
}
```

* 更改 `HMStatusCell` 中 原创微博View 的约束

```swift
// 添加原创微博内容的约束
originalView.snp_makeConstraints { (make) -> Void in
    // 关键：约束原创微博整体 View 的顶部
    make.top.equalTo(contentView.snp_top)
    make.width.equalTo(contentView.snp_width)
}

// 约束当前 contenView 关键：底部等于 originalView的底部
contentView.snp_makeConstraints { (make) -> Void in
    make.width.equalTo(self.snp_width)
    make.top.equalTo(self.snp_top)
    make.bottom.equalTo(originalView.snp_bottom)
}
```

* 更改 `HMHomeTableViewController` 中 tableView 的行高计算方式

```swift
// 跟据 AutoLayout 约束的高度自动计算
tableView.rowHeight = UITableViewAutomaticDimension
// 预估行高
tableView.estimatedRowHeight = 200
```

> 运行测试 --> 添加原创微博 View 的底部约束，可以让cell的高度以原创微博 View 最大的Y值来计算
