# 阶段性小结
* 整体开发思路与使用 OC 几乎一致
* Swift 语法更加简洁
* Swift 对类型校验更加严格，不同类型的变量不允许直接计算

```swift
let w = tabBar.bounds.width / CGFloat(childViewControllers.count)
//设置按钮的宽
var frame = childView.frame
frame.size.width = childW
//设置按钮的x，此处index为Int类似的值
frame.origin.x = CGFloat(index) * childW
childView.frame = frame
```

* Swift 中的懒加载本质上是一个闭包，因此引用当前控制器的对象时需要使用 self.
* 不希望暴露的方法，应该使用 `private` 修饰符
    * 按钮点击事件的调用是由 `运行循环` 监听并且以`消息机制`传递的
    * 而Swift为了追求性能的这个特性决定了其在`编译时期`就已经决定好了某个事件该如何去调用
    * 而使用 `private` 修饰的方法在运行的时候对于`运行循环`是不可见的，所以会提示 `找不到xxx方法`
    * 可以使用 `@objc` 修饰此私有方法，其在于告诉系统此方法使用 Objective-C 的基于运行时的机制（KVC以及动态派发）
* `viewDidLoad` 函数中添加子控制器只会完成控制器的添加，而不会为 `tabBar` 创建 `tabBarButton`

