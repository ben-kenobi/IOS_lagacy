# 懒加载

> 在 iOS 开发中，懒加载是无处不在的

* 懒加载的格式如下：

```swift
lazy var person: Person = {
    print("懒加载")
    return Person()
}()
```

* 懒加载本质上是一个闭包
* 以上代码可以改写为以下格式

```swift
let personFunc = { () -> Person in
    print("懒加载")
    return Person()
}
lazy var demoPerson: Person = self.personFunc()
```

* 懒加载的简单写法

```swift
lazy var demoPerson: Person = Person()
```
