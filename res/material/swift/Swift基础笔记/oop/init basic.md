# 构造函数基础

> `构造函数`是一种特殊的函数，主要用来在创建对象时初始化对象，为对象`成员变量`设置初始值，在 OC 中的构造函数是 initWithXXX，在 Swift 中由于支持函数**重载**，所有的构造函数都是 `init`

构造函数的作用

* 分配空间 `alloc`
* 设置初始值 `init`

## 必选属性

* 自定义 `Person` 对象

```swift
class Person: NSObject {

    /// 姓名
    var name: String
    /// 年龄
    var age: Int
}
```

提示错误 `Class 'Person' has no initializers` -> `'Person' 类没有实例化器s`

原因：如果一个类中定义了必选属性，必须通过构造函数为这些必选属性分配空间并且设置初始值

* `重写` 父类的构造函数

```swift
/// `重写`父类的构造函数
override init() {

}
```

提示错误 `Property 'self.name' not initialized at implicitly generated super.init call` -> `属性 'self.name' 没有在隐式生成的 super.init 调用前被初始化`

* 手动添加 `super.init()` 调用

```swift
/// `重写`父类的构造函数
override init() {
    super.init()
}
```

提示错误 `Property 'self.name' not initialized at super.init call` -> `属性 'self.name' 没有在 super.init 调用前被初始化`

* 为必选属性设置初始值

```swift
/// `重写`父类的构造函数
override init() {
    name = "张三"
    age = 18

    super.init()
}
```

### 小结

* 非 Optional 属性，都必须在构造函数中设置初始值，从而保证对象在被实例化的时候，属性都被正确初始化
* 在调用父类构造函数之前，必须保证本类的属性都已经完成初始化
* Swift 中的构造函数不用写 `func`

## 子类的构造函数

* 自定义子类时，需要在构造函数中，首先为本类定义的属性设置初始值
* 然后再调用父类的构造函数，初始化父类中定义的属性

```swift
/// 学生类
class Student: Person {

    /// 学号
    var no: String

    override init() {
        no = "001"

        super.init()
    }
}
```

### 小结

* 先调用本类的构造函数初始化本类的属性
* 然后调用父类的构造函数初始化父类的属性
* Xcode 7 beta 5之后，父类的构造函数会被自动调用，强烈建议写 `super.init()`，保持代码执行线索的可读性
* `super.init()` 必须放在本类属性初始化的后面，保证本类属性全部初始化完成

## `Optional` 属性

* 将对象属性类型设置为 `Optional`

```swift
class Person: NSObject {
    /// 姓名
    var name: String?
    /// 年龄
    var age: Int?
}
```

* `可选属性`不需要设置初始值，默认初始值都是 nil
* `可选属性`是在设置数值的时候才分配空间的，是延迟分配空间的，更加符合移动开发中延迟创建的原则
