# KVC 字典转模型构造函数

```swift
/// `重写`构造函数
///
/// - parameter dict: 字典
///
/// - returns: Person 对象
init(dict: [String: AnyObject]) {
    setValuesForKeysWithDictionary(dict)
}
```

* 以上代码编译就会报错！
* 原因：
    * KVC 是 OC 特有的，KVC 本质上是在`运行时`，动态向对象发送 `setValue:ForKey:` 方法，为对象的属性设置数值
    * 因此，在使用 KVC 方法之前，需要确保对象已经被正确`实例化`

* 添加 `super.init()` 同样会报错
* 原因：
    * `必选属性`必须在调用父类构造函数之前完成初始化分配工作

* 将必选参数修改为可选参数，调整后的代码如下：

```swift
/// 个人模型
class Person: NSObject {

    /// 姓名
    var name: String?
    /// 年龄
    var age: Int?

    /// `重写`构造函数
    ///
    /// - parameter dict: 字典
    ///
    /// - returns: Person 对象
    init(dict: [String: AnyObject]) {
        super.init()

        setValuesForKeysWithDictionary(dict)
    }
}
```

> 运行测试，仍然会报错

错误信息：`this class is not key value coding-compliant for the key age.` -> `这个类的键值 age 与 键值编码不兼容`

* 原因：
    * 在 Swift 中，如果属性是可选的，在初始化时，不会为该属性分配空间
    * 而 OC 中基本数据类型就是保存一个数值，不存在`可选`的概念
* 解决办法：给基本数据类型设置初始值
* 修改后的代码如下：

```swift
/// 姓名
var name: String?
/// 年龄
var age: Int = 0

/// `重写`构造函数
///
/// - parameter dict: 字典
///
/// - returns: Person 对象
init(dict: [String: AnyObject]) {
    super.init()

    setValuesForKeysWithDictionary(dict)
}
```

> 提示：在定义类时，基本数据类型属性一定要设置初始值，否则无法正常使用 KVC 设置数值

## KVC 函数调用顺序

```swift
init(dict: [String: AnyObject]) {
    super.init()

    setValuesForKeysWithDictionary(dict)
}

override func setValue(value: AnyObject?, forKey key: String) {
    print("Key \(key) \(value)")

    super.setValue(value, forKey: key)
}

// `NSObject` 默认在发现没有定义的键值时，会抛出 `NSUndefinedKeyException` 异常
override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    print("UndefinedKey \(key) \(value)")
}
```

* `setValuesForKeysWithDictionary` 会按照字典中的 `key` 重复调用 `setValue:forKey` 函数
* 如果没有实现 `forUndefinedKey` 函数，程序会直接崩溃
    * NSObject 默认在发现没有定义的键值时，会抛出 `NSUndefinedKeyException` 异常
* 如果实现了 `forUndefinedKey`，会保证 `setValuesForKeysWithDictionary` 继续遍历后续的 `key`
* 如果父类实现了 `forUndefinedKey`，子类可以不必再实现此函数

## 子类的 KVC 函数

```swift
/// 学生类
class Student: Person {

    /// 学号
    var no: String?
}
```

* 如果父类中已经实现了父类的相关方法，子类中不用再实现相关方法
