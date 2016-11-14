# 只读属性

## getter & setter

* 在 Swift 中 `getter & setter` 很少用，以下代码仅供了解

```swift
private var _name: String?
var name: String? {
    get {
        return _name
    }
    set {
        _name = newValue
    }
}
```

## 存储型属性 & 计算型属性

* 存储型属性 - 需要开辟空间，以存储数据
* 计算型属性 - 执行函数返回其他内存地址

```swift
var title: String {
    get {
        return "Mr " + (name ?? "")
    }
}
```

* 只实现 getter 方法的属性被称为计算型属性，等同于 OC 中的 ReadOnly 属性
* 计算型属性本身不占用内存空间
* 不可以给计算型属性设置数值
* 计算型属性可以使用以下代码简写

```swift
var title: String {
    return "Mr " + (name ?? "")
}
```

### 计算型属性与懒加载的对比

* 计算型属性
    * 不分配独立的存储空间保存计算结果
    * 每次调用时都会被执行
    * 更像一个函数，不过不能接收参数，同时必须有返回值

```swift
var title2: String {
    return "Mr" + (name ?? "")
}
```

* 懒加载属性
    * 在第一次调用时，执行闭包并且分配空间存储闭包返回的数值
    * 会分配独立的存储空间
    * 与 OC 不同的是，lazy 属性即使被设置为 nil 也不会被再次调用

```swift
lazy var title: String = {
    return "Mr " + (self.name ?? "")
}()
```

