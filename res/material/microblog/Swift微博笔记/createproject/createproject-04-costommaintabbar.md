# 自定义 TabBar

## 功能需求

* 在 4 个控制器切换按钮中间增加一个撰写按钮
* 点击撰写按钮能够弹出发表微博的控制器

### 需求分析

* 自定义 TabBar
* 计算控制器按钮位置，在中间添加一个 `撰写` 按钮

### 思路

* 加号按钮的大小与其他 `tabBarItem` 的大小是一致的
* 添加加号按钮到TabBar中
* 遍历查找到其他4个`UITabBarButton`，设置宽度并调整位置
* 将撰写按钮放在自定义的UITabBar中间位置
* 在UITabBar内部监听撰写按钮的点击事件，通过闭包回调到控制器

### 代码实现


* 按钮的初始化

```swift
/// 撰写按钮
lazy var composeButton: UIButton = {
    let button = UIButton()

    //给按钮添加点击事件（因为button最重要的就是点击事件，所以写在前面）
    button.addTarget(self, action: "composeButtonClick", forControlEvents: UIControlEvents.TouchUpInside)

    //设置按钮不同状态的图片与背景图片
    button.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
    button.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
    button.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
    button.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)

    //设置大小
    button.sizeToFit()

    return button
}()
```

* 设置按钮位置

```swift
/// 调整子控件的位置在layoutSubviews里面调整
override func layoutSubviews() {
    super.layoutSubviews()

    //设置加号按钮位置
    //调整子控件的center,不能依靠于父控制的center,因为你知道父控件是放在什么地方的
    composeButton.center = CGPoint(x: frame.width * 0.5, y: frame.height * 0.5)

    ///每一个按钮的宽度
    let childW = frame.size.width / 5
    //定义脚标记录当前button的位置
    var index = 0

    //遍历子控件调整'UITabBarButton'的宽度与位置
    for childView in subviews {

        //如果当前遍历的View是UITabBarButton
        if childView.isKindOfClass(NSClassFromString("UITabBarButton")!) {

            //设置按钮的宽
            var frame = childView.frame
            frame.size.width = childW
            //设置按钮的x
            frame.origin.x = CGFloat(index) * childW
            childView.frame = frame

            //index递增
            index++
            //如果当前遍历到'发现'，则把发现往后移动一个位置
            if index == 2 {
                index++
            }
        }
    }
}

```

* 按钮监听

```swift
/// 定义闭包类型的属性
var composeButtonClosure: (()->())?

/// 在按钮点击的时候调用闭包
@objc private func composeButtonClick(){
    composeButtonClosure?()
}
```

* 注意：按钮的监听方法不能使用 `private`，否则运行循环是找不到这个方法的，但是在这种情况下，如果不私有化的话，外界（控制器）可以直接调用这个方法，不符合设计思想，所以可以在加了`private`的情况下，可以用 `@objc` 去修饰这个方法

## 设置tabBar
因为tabBarController上的tabBar是只读属性，不能直接设置值，所以我们可以采用KVC的方式赋值：
```swift
let tab = HMTabBar()
//设置撰写按钮点击的事件响应
// 注意：此闭包内使用 `self` 会形成循环引用
tab.composeButtonClickBlock = {
    print("撰写按钮点击")
}
setValue(tab, forKey: "tabBar")
```



