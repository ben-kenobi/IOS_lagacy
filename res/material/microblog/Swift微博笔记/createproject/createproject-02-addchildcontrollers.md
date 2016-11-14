# 添加子控制器

## 功能需求

* 由于采用了多视图控制器的设计方式，因此需要通过代码的方式向主控制器中添加子控制器

## 文件准备

* 将素材文件夹中的 `TabBar` 拖拽到 `Assets.xcassets` 目录下

## 代码实现

### 添加第一个视图控制器

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    addChildViewController()
}

private func addChildViewController() {
    tabBar.tintColor = UIColor.orangeColor()

    let vc = HomeTableViewController()
    vc.title = "首页"
    vc.tabBarItem.image = UIImage(named: "tabbar_home")

    let nav = UINavigationController(rootViewController: vc)

    addChildViewController(nav)
}
```

### 重构代码抽取参数

```swift
/// 添加控制器
///
/// - parameter vc       : 视图控制器
/// - parameter title    : 标题
/// - parameter imageName: 图像名称
private func addChildViewController(vc: UIViewController, title: String, imageName: String) {
    //设置标题
    vc.title = title
    //设置图片
    vc.tabBarItem.image = UIImage(named: imageName)
    vc.tabBarItem.selectedImage = UIImage(named: "\(imageName)_selected")
    //使用导航控制器包裹起来
    let nav = UINavigationController(rootViewController: vc)
    addChildViewController(nav)
}
```

* 扩充调用函数，添加其他控制器

```swift
/// 添加所有子控制器
private func addChildViewControllers() {
    addChildViewController(HMHomeTableViewController(), title: "首页", imageName: "tabbar_home")
    addChildViewController(HMMessageTableViewController(), title: "消息", imageName: "tabbar_message_center")
    addChildViewController(HMDiscoverTableViewController(), title: "发现", imageName: "tabbar_discover")
    addChildViewController(HMProfileTableViewController(), title: "我", imageName: "tabbar_profile")
}
```

