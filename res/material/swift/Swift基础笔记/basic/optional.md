# Optional 可选值

* `Optional` 是 Swift 的一大特色，也是 Swift 初学者最容易困惑的问题
* 定义变量时，如果指定是`可选的`，表示该变量`可以有一个指定类型的值，也可以是 nil`
* 定义变量时，在类型后面添加一个 `?`，表示该变量是可选的
* 变量可选项的默认值是 `nil`
* 常量可选项没有默认值，主要用于在构造函数中给常量设置初始数值

```swift
//: num 可以是一个整数，也可以是 nil，注意如果为 nil，不能参与计算
let num: Int? = 10
```

* 如果 Optional 值是 `nil`，不允许参与计算
* 只有`解包(unwrap)`后才能参与计算
* 在变量后添加一个 `!`，可以强行解包

> 注意：必须要确保解包后的值不是 nil，否则会报错

```swift
//: num 可以是一个整数，也可以是 nil，注意如果为 nil，不能参与计算
let num: Int? = 10

//: 如果 num 为 nil，使用 `!` 强行解包会报错
let r1 = num! + 100

//: 使用以下判断，当 num 为 nil 时，if 分支中的代码不会执行
if let n = num {
    let r = n + 10
}
```

## 常见错误

`unexpectedly found nil while unwrapping an Optional value`

翻译

`在[解包]一个可选值时发现 nil`


## `??` 运算符

* `??` 运算符可以用于判断 `变量/常量` 的数值是否是 `nil`，如果是则使用后面的值替代
* 在使用 Swift 开发时，`??` 能够简化代码的编写

```swift
let num: Int? = nil

let r1 = (num ?? 0) + 10
print(r1)
```

