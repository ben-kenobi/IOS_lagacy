# UIBarButtonItem抽取

- 快速构造一个 `UIBarButtonItem`

```swift
// item 上的文字颜色，高亮颜色，字体大小
// 导航栏上左右的文字一般都会统一，所以可以定义成常量
private let ItemNormalColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
private let ItemHighlightedColor = UIColor.orangeColor()
private let ItemFontSize: CGFloat = 14

extension UIBarButtonItem {

    /// 快速构造一个 UIBarButtonItem
    ///
    /// - parameter imgName: 图片名字
    /// - parameter title:   标题文字
    /// - parameter target:
    /// - parameter action:
    ///
    /// - returns: UIBarButtonItem
    convenience init(imgName: String? = nil,title: String? = nil, target: AnyObject?, action: Selector){
        self.init()

        let button = UIButton()
        button.addTarget(target, action: action, forControlEvents: .TouchUpInside)

        // 如果有图片，设置图片
        if let img = imgName {
            button.setImage(UIImage(named: img), forState: UIControlState.Normal)
            button.setImage(UIImage(named: "\(img)_highlighted"), forState: UIControlState.Highlighted)
        }

        // 如果有文字，设置文字
        if let t = title {
            button.setTitle(t, forState: UIControlState.Normal)
            button.titleLabel?.font = UIFont.systemFontOfSize(ItemFontSize)
            button.setTitleColor(UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1), forState: .Normal)
            button.setTitleColor(UIColor.orangeColor(), forState: .Highlighted)
        }
        button.sizeToFit()

        customView = button

    }
}
```



