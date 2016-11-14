# 循环引用

* 建立 `NetworkTools` 对象

```swift
class NetworkTools: NSObject {
    
    /// 加载数据
    ///
    /// - parameter finished: 完成回调
    func loadData(finished: () -> ()) {
        print("开始加载数据...")
        
        // ...
        finished()
    }
    
    deinit {
        print("网络工具 88")
    }
}
```

* 实例化 `NetworkTools` 并且加载数据

```swift
class ViewController: UIViewController {

    var tools: NetworkTools?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tools = NetworkTools()
        tools?.loadData() {
            print("come here \(self.view)")
        }
    }
    
    /// 与 OC 中的 dealloc 类似，注意此函数没有()
    deinit {
        print("控制器 88")
    }
}
```

> 运行不会形成循环引用，因为 loadData 执行完毕后，就会释放对 self 的引用

* 修改 `NetworkTools`，定义回调闭包属性

```swift
/// 完成回调属性
var finishedCallBack: (()->())?

/// 加载数据
///
/// - parameter finished: 完成回调
func loadData(finished: () -> ()) {
    
    self.finishedCallBack = finished
    
    print("开始加载数据...")
    
    // ...
    working()
}

func working() {
    finishedCallBack?()
}

deinit {
    print("网络工具 88")
}
```

> 运行测试，会出现循环引用


### 解除循环引用

* 与 OC 类似的方法

```swift
/// 类似于 OC 的解除引用
func demo() {
    weak var weakSelf = self
    tools?.loadData() {
        print("\(weakSelf?.view)")
    }
}
```

* Swift 推荐的方法

```swift
loadData { [weak self] in
    print("\(self?.view)")
}
```

* 还可以

```swift
loadData { [unowned self] in
    print("\(self.view)")
}
```

#### 闭包(Block) 的循环引用小结

* Swift
    * `[weak self]`
        * `self`是可选项，如果self已经被释放，则为`nil`
    * `[unowned self]`
        * `self`不是可选项，如果self已经被释放，则出现`野指针访问`

* Objc
    * `__weak typeof(self) weakSelf;`
        * 如果`self`已经被释放，则为`nil`
    * `__unsafe_unretained typeof(self) weakSelf;`
        * 如果`self`已经被释放，则出现野指针访问
