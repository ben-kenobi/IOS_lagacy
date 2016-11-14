# 重载构造函数

* Swift 中支持函数重载，同样的函数名，不一样的参数类型

```swift
/// `重载`构造函数
///
/// - parameter name: 姓名
/// - parameter age:  年龄
///
/// - returns: Person 对象
init(name: String, age: Int) {
    self.name = name
    self.age = age

    super.init()
}
```

## 注意事项

* 如果重载了构造函数，但是没有实现默认的构造函数 `init()`，则系统不再提供默认的构造函数
* 原因，在实例化对象时，必须通过构造函数为对象属性分配空间和设置初始值，对于存在必选参数的类而言，默认的 `init()` 无法完成分配空间和设置初始值的工作

## 调整子类的构造函数

* `重写`父类的构造函数

```swift
/// `重写`父类构造函数
///
/// - parameter name: 姓名
/// - parameter age:  年龄
///
/// - returns: Student 对象
override init(name: String, age: Int) {
    no = "002"

    super.init(name: name, age: age)
}
```

* `重载`构造函数

```swift
/// `重载`构造函数
///
/// - parameter name: 姓名
/// - parameter age:  年龄
/// - parameter no:   学号
///
/// - returns: Student 对象
init(name: String, age: Int, no: String) {
    self.no = no

    super.init(name: name, age: age)
}
```

> 注意：如果是重载的构造函数，必须 `super` 以完成父类属性的初始化工作

## `重载`和`重写`

* `重载`，函数名相同，参数名／参数类型／参数个数不同
    * 重载函数并不仅仅局限于`构造函数`
    * 函数重载是面相对象程序设计语言的重要标志
    * 函数重载能够简化程序员的记忆
    * OC 不支持函数重载，OC 的替代方式是 `withXXX...`
* `重写`，子类需要在父类拥有方法的基础上进行扩展，需要 `override` 关键字
