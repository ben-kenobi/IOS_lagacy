# 用户登录视图
> 对于第三方开发者，新浪没有开放未登录访问数据的权限，因此在用户登录之前，无法 `加载微博数据` 以及 `关注用户`

## 功能需求

* 用户登录操作视图，用于在用户没有登录时替换表格控制器的根视图
* 每个功能模块的登录视图包含以下四个控件
    * 模块图标
    * 描述文字
    * 注册按钮
    * 登录按钮
* 特例
    * 首页有一个小的转轮图片会不停旋转

## 功能实现

* 拖拽相关图片素材
* 新建 `HMVisitorView.swift` 继承自 `UIView`

```swift
/// 访客登录视图
class HMVisitorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupUI()
    }

    /// 设置界面元素
    private func setupUI() {

    }
}
```

* 修改 `setupVisitorView` 函数

```swift
// 替换根视图
view = HMVisitorView()
```

* 添加界面元素

```swift
/// 设置界面元素
private func setupUI() {
    // 1. 添加控件
    addSubview(circleView)
    addSubview(iconView)
    addSubview(messageLabel)
    addSubview(registerButton)
    addSubview(loginButton)
}

// MARK: - 懒加载属性
// 小房子
private lazy var iconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))

// 转圈的 view
private lazy var circleView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))

// 提示 label
private lazy var messageLabel: UILabel = {
    let label = UILabel(text: "关注一些人，回这里看看有什么惊喜关注一些人，回这里看看有什么惊喜", textColor: UIColor.darkGrayColor(), fontSize: 14)
    label.numberOfLines = 0
    // 文本对齐方式
    label.textAlignment = .Center
    return label
}()

// 注册按钮
lazy var registerButton: UIButton = {
    let button = UIButton()
    button.setTitle("注册", forState: .Normal)
    button.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: .Normal)
    button.titleLabel?.font = UIFont.systemFontOfSize(14)
    button.setTitleColor(UIColor.orangeColor(), forState: .Normal)
    return button
}()

// 登录按钮
lazy var loginButton: UIButton = {
    let button = UIButton()
    button.setTitle("登录", forState: .Normal)
    button.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: .Normal)
    button.titleLabel?.font = UIFont.systemFontOfSize(14)
    button.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
    return button
}()

```

### 设置自动布局

* 设置图标约束 - 参照视图居中对齐

```swift
// 1> 图标
// 2.1 图标
iconView.translatesAutoresizingMaskIntoConstraints = false
addConstraint(NSLayoutConstraint(item: iconView, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
addConstraint(NSLayoutConstraint(item: iconView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
```

* 设置首页小房子 - 参照图标居中对齐

```swift
// 2> 首页的房子
circleView.translatesAutoresizingMaskIntoConstraints = false
addConstraint(NSLayoutConstraint(item: circleView, attribute: .CenterX, relatedBy: .Equal, toItem: iconView, attribute: .CenterX, multiplier: 1, constant: 0))
addConstraint(NSLayoutConstraint(item: circleView, attribute: .CenterY, relatedBy: .Equal, toItem: iconView, attribute: .CenterY, multiplier: 1, constant: 0))
```

* 设置文本 - 参照图标，水平居中，下方 16 个点

```swift
// 3> 描述文字
messageLabel.translatesAutoresizingMaskIntoConstraints = false
addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .CenterX, relatedBy: .Equal, toItem: circleView, attribute: .CenterX, multiplier: 1, constant: 0))
addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .Top, relatedBy: .Equal, toItem: circleView, attribute: .Bottom, multiplier: 1, constant: 16))

```

* 增加文本宽度约束 - 224

```swift
// 添加最大宽度约束
addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 224))
```

* 注册按钮，文本标签左下(16)对齐，宽度 100，高度 35

```swift
// 4> 注册按钮
registerButton.translatesAutoresizingMaskIntoConstraints = false
addConstraint(NSLayoutConstraint(item: registerButton, attribute: .Leading, relatedBy: .Equal, toItem: messageLabel, attribute: .Leading, multiplier: 1, constant: 0))
addConstraint(NSLayoutConstraint(item: registerButton, attribute: .Top, relatedBy: .Equal, toItem: messageLabel, attribute: .Bottom, multiplier: 1, constant: 16))

addConstraint(NSLayoutConstraint(item: registerButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 100))
addConstraint(NSLayoutConstraint(item: registerButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 35))
```

* 调整按钮背景图片切片

* 登录按钮，文本标签右下(16)对齐，宽度 100，高度 35

```swift
loginButton.translatesAutoresizingMaskIntoConstraints = false
addConstraint(NSLayoutConstraint(item: loginButton, attribute: .Trailing, relatedBy: .Equal, toItem: messageLabel, attribute: .Trailing, multiplier: 1, constant: 0))
addConstraint(NSLayoutConstraint(item: loginButton, attribute: .Top, relatedBy: .Equal, toItem: registerButton, attribute: .Top, multiplier: 1, constant: 0))

addConstraint(NSLayoutConstraint(item: loginButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 100))
addConstraint(NSLayoutConstraint(item: loginButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 35))
```

* 设置登录按钮文字颜色

```swift
btn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
```

* 调整控件整体垂直位置

```swift
addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: -60))
```

* 添加遮罩图片视图

```swift
/// 遮罩视图
private lazy var maskIconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
```

```swift
// 1. 添加控件
addSubview(iconView)
addSubview(maskIconView)
addSubview(homeIconView)
...
```

* 遮罩图片自动布局

```swift
// 6> 遮罩视图
maskIconView.translatesAutoresizingMaskIntoConstraints = false
addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[subview]-0-|", options: [], metrics: nil, views: ["subview": maskIconView]));
addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[subview]-(-35)-[regButton]", options: [], metrics: nil, views: ["subview": maskIconView, "regButton": registerButton]));
```

* 视图背景颜色

```swift
// 3. 设置视图背景颜色
backgroundColor = UIColor(white: 237.0 / 255.0, alpha: 1.0)
```

> 运行测试
