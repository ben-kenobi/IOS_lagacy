# 设置未登录信息

* 设置访客视图信息

```swift
/**
设置各个页签信息

- parameter imageName: 图片名字
- parameter message:   信息内容
*/
func setupInfo(imageName: String?, message: String?) {
    messageLabel.text = message

    if imageName != nil {
        circleView.hidden = true
        iconView.image = UIImage(named: imageName!)
        messageLabel.text = message
    }
}
```

* 在 `HMVisitorViewController` 中添加登录视图属性

```swift
private lazy var visitorView: HMVisitorView = {
    let visitorView = HMVisitorView()
    return visitorView
}()
```

* 在 `setupVisitorView` 中记录登录视图

```swift
view = visitorView
```

## 修改功能视图控制器中的代码

* HMHomeTableViewController

```swift
if !userLogon {
    visitorView.setupInfo(nil, message: nil)
    return
}
```

* HMMessageTableViewController

```swift
if !userLogon {
    visitorView.setupInfo("visitordiscover_image_message", message: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知")
    return
}
```

* HMDiscoverTableViewController

```swift
if !userLogon {
    visitorView.setupInfo("visitordiscover_image_message", message: "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过")
    return
}
```

* HMProfileTableViewController

```swift
if !userLogon {
    visitorView.setupInfo("visitordiscover_image_profile", message: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人")
    return
}
```

* 提示信息
    * 关注一些人，回这里看看有什么惊喜
    * 登录后，别人评论你的微博，发给你的消息，都会在这里收到通知
    * 登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过
    * 登录后，你的微博、相册、个人资料会显示在这里，展示给别人
