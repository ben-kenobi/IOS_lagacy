# 项目开发体验

## 目标

* 熟悉 Swift 的基本开发环境
* 与 OC 开发做一个简单的对比

## 代码实现

```swift
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // swift 中 () 代替 oc 中的 alloc / init
        let v = UIView(frame: CGRect(x: 0, y: 20, width: 100, height: 100))
        
        // [UIColor redColor];
        v.backgroundColor = UIColor.redColor()
        
        // 按钮
        let btn = UIButton(type: .ContactAdd)
        v.addSubview(btn)
        
        // 监听方法
        btn.addTarget(self, action: "click:", forControlEvents: .TouchUpInside)
        
        view.addSubview(v)
    }

    func click(btn: UIButton) {
        print("点我了 \(btn)")
    }
}
```

### 小结

* 在 Swift 中没有了 `main.m`，`@UIApplicationMain` 是程序入口
* 在 Swift 中只有 `.swift` 文件，没有 `.h/.m` 文件的区分
* 在 Swift 中，一个类就是用一对 `{}` 括起的，没有 `@implementation` 和 `@end`
* 每个语句的末尾没有分号，在其他语言中，分号是用来区分不同语句的
    * 在 Swift 中，一般都是一行一句代码，因此不用使用分号

* 与 OC 的语法快速对比
    * 在 OC 中 `alloc / init` 对应 `()`
    * 在 OC 中 `alloc / initWithXXX` 对应 `(XXX: )`
    * 在 OC 中的类函数调用，在 Swift 中，直接使用 `.`
    * 在 Swift 中，绝大多数可以省略 `self.`，建议一般不写，可以提高对语境的理解（闭包时会体会到）
    * 在 OC 中的 枚举类型使用 `UIButtonTypeContactAdd`，而 Swift 中分开了，操作热键：`回车 -> 向右 -> . `
        * Swift 中，枚举类型的前缀可以省略，如：`.ContactAdd`，但是：很多时候没有智能提示
    * 监听方法，直接使用字符串引起
    * 在 Swift 中使用 `print()` 替代 OC 中的 `NSLog`


