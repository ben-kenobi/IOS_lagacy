# 其他细节

* 取消分隔线

```swift
tableView.separatorStyle = UITableViewCellSeparatorStyle.None
```

* 增加 cell 分隔视图

```swift
// 设置 cell 的contentView的背景颜色
// 设置背景颜色
contentView.backgroundColor = UIColor(white: 240 / 255, alpha: 1)

// 设置原创微博背景色为白色 在 `HMStatusOriginalView`
backgroundColor = UIColor.whiteColor()

// 更改原创微博距离顶部的间距 在 `HMStatusCell`
originalView.snp_makeConstraints { (make) -> Void in
    // 距离顶部有间距
    make.top.equalTo(contentView.snp_top).offset(HMStatusCellMargin)
    ...
}
```

* 设置 tableView 的背景色

```swift
tableView.backgroundColor = UIColor(white: 240 / 255, alpha: 1)
```

* 抽取颜色的方法 -> `CommonTools.swift`
    * RGBColor & 随机颜色

```swift
/// RGB颜色
func RGB(r r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
    return UIColor(red: r / 256, green: g / 256, blue: b / 256, alpha: 1)
}

/// 随机颜色
func RandomColor() -> UIColor {
    return RGB(r: CGFloat(random()) % 256, g: CGFloat(random()) % 256, b: CGFloat(random()) % 256)
}
```

* 抽取屏幕宽度/高度 -> `CommonTools.swift`

```swift
/// 屏幕宽高
let SCREENW = UIScreen.mainScreen().bounds.size.width
let SCREENH = UIScreen.mainScreen().bounds.size.height
```

