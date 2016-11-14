# 欢迎界面

* 在新浪微博中，如果用户登录成功会显示一个欢迎界面
* 特例：如果用户的系统刚刚升级或者第一次登录，会显示 `新特性` 界面，而不是 `欢迎`界面

### 准备文件

* 在 `NewFeature` 目录下新建 `HMWelcomeViewController.swift` 继承自 `UIViewController`

### 代码实现

* 修改 `AppDelegate` 的根视图控制器

```swift
window?.rootViewController = WelcomeViewController()
```

* 懒加载控件

```swift
// MARK: - 懒加载控件

/// 头像图片
private lazy var iconView: UIImageView = {

    let iv = UIImageView(image: UIImage(named: "avatar_default_big"))
    // 设置圆角
    iv.layer.cornerRadius = 45
    iv.layer.masksToBounds = true
    // 设置边线
    iv.layer.borderColor = UIColor.lightGrayColor().CGColor
    iv.layer.borderWidth = 2

    return iv
}()

/// 欢迎标签
private lazy var label: UILabel = {
    let label = UILabel()
    label.text = "欢迎归来"
    label.textColor = UIColor.darkGrayColor()
    label.sizeToFit()

    return label
}()
```

* 搭建界面

```swift
/// 设置界面内容
private func setupUI(){
    view.backgroundColor = UIColor.whiteColor()
    // 添加子控件
    view.addSubview(iconView)
    view.addSubview(label)

    // 添加头像的约束
    iconView.translatesAutoresizingMaskIntoConstraints = false
    // 居中
    view.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
    // 距离顶部约束
    view.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 150))

    label.translatesAutoresizingMaskIntoConstraints = false
    // label 的中心点与 iconView 一样
    view.addConstraint(NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
    // label 的顶部与 iconView 的底部15个间距
    view.addConstraint(NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 15))
}
```

* 头像顶部约束属性

```swift
/// 头像顶部约束
private var iconViewTopConstraint: NSLayoutConstraint?
```

* 记录图像顶部约束，设置头像顶部约束的代码更改为

```swift
// 距离顶部距离约束
iconViewTopConstraint = view.constraints.last!
```

* 界面动画

```swift
override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    // 更新约束
    iconTopConstraint?.constant = 100
    // 执行约束动画
    UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: { () -> Void in
        self.view.layoutIfNeeded()
    }) { _ in
        // 先设置成0
        self.label.alpha = 0
        // 在头像动画执行完毕-->执行label显示的动画
        UIView.animateWithDuration(1, animations: { () -> Void in
            self.label.alpha = 1
        }, completion: { _ in
            print("动画执行完毕")
        })
    }
}

```

* 参数说明
    * `usingSpringWithDamping` 的范围为 `0.0f` 到 `1.0f`，数值越小 `弹簧` 的振动效果越明显
    * `initialSpringVelocity` 则表示初始的速度，数值越大一开始移动越快，初始速度取值较高而时间较短时，会出现反弹情况

### 设置用户头像

* 在 `HMUserAccountViewModel` 中增加 `avatarUrl` 头像属性

```swift
/// 用户头像 URL
/// 头像 URL
var avatarUrl: NSURL? {
    return NSURL(string: userAccount?.avatar_large ?? "")
}
```

* 在 `viewDidLoad` 中增加以下代码

```swift
iconView.sd_setImageWithURL(UserAccountViewModel.sharedUserAccount.avatarUrl)
```

* 添加图像宽高约束

```swift
// iconView 的宽高约束
view.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 90))
view.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 90))
```

### SnapKit

* 使用以下代码替换原生的自动布局

```swift
// 使用 SnapKit 添加约束
iconView.snp_makeConstraints { (make) -> Void in
    // 居中
    make.centerX.equalTo(self.view.snp_centerX)
    // 距离顶部距离
    self.iconViewTopConstraint = make.top.equalTo(150).constraint
    // 添加宽高约束
    make.size.equalTo(CGSizeMake(90, 90))
}

// 添加label 约束
label.snp_makeConstraints { (make) -> Void in
    // lable的中心x与头像的中心x一样
    make.centerX.equalTo(iconView.snp_centerX).constraint
    // label的顶部与头像的底部15个间距
    make.top.equalTo(iconView.snp_bottom).offset(15)
}
```

* 更改 iconViewTopConstraint 类型为 SnapKit 的约束类型

```swift
private var iconViewTopConstraint: Constraint?
```

* 更改 `viewDidAppear` 方法里面更新约束的代码

```Swift
iconViewTopConstraint?.updateOffset(100)
```
> 运行测试
