# 登录&注册代理回调

* 定义协议

```swift
/// 访客登录视图协议
protocol HMVisitorViewDelegate: NSObjectProtocol{
    /// 访客视图将要登录
    func visitorLoginViewWillLogin();
    /// 访客视图将要注册
    func visitorLoginViewWillRegister();
}
```

> 定义协议时，需要继承自 `NSObjectProtocol`，否则无法设置代理的属性为 `weak`

* 定义代理

```swift
weak var delegate: HMVisitorViewDelegate?
```

* 按钮回调

```swift
// MARK: - 监听按钮点击
@objc private func registerButtonClick(){
    delegate?.visitorLoginViewWillRegister()
}

@objc private func loginButtonClick(){
    delegate?.visitorLoginViewWillLogin()
}
```

* 遵守协议

```swift
class HMVisitorViewController: UITableViewController, VisitorLoginViewDelegate
```
* 设置代理

```swift
visitorView.delegte = self
```

* 实现方法

```swift
// MARK: - VisitorLoginViewDelegate
func visitorLoginViewWillLogin() {
    print("登录")
}

func visitorLoginViewWillRegister() {
    print("注册")
}
```

* 修改导航条按钮监听方法

```swift
navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: "visitorLoginViewWillRegister")
navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: "visitorLoginViewWillLogin")
```

> 运行测试

# 登录&注册按钮监听

* 修改 `HMVisitorViewController`
    * 删除遵守协议
    * 删除设置代理属性
* 修改 `VisitorLoginView`
    * 删除协议
    * 删除 `delegate` 属性
    * 删除按钮监听方法
    * 取消 `注册` & `登录` 按钮的 `private` 修饰符
* 在 `setupVisitorView` 方法中添加按钮监听方法

```swift
// 设置按钮监听方法
visitorView.registerButton.addTarget(self, action: "visitorLoginViewWillRegistor", forControlEvents: UIControlEvents.TouchUpInside)
visitorView.loginButton.addTarget(self, action: "visitorLoginViewWillLogin", forControlEvents: UIControlEvents.TouchUpInside)
```

* 修改按钮监听方法作用域

```swift
// MARK: - 按钮监听方法
@objc private func visitorLoginViewWillLogin() {
    print("登录")
}

@objc private func visitorLoginViewWillRegistor() {
    print("注册")
}
```
