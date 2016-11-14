# 闭包的定义

* 定义一个函数

```swift
//: 定义一个 sum 函数
func sum(num1 num1: Int, num2: Int) -> Int {
    return num1 + num2
}
sum(num1: 10, num2: 30)

//: 在 Swift 中函数本身就可以当作参数被定义和传递
let mySum = sum
let result = mySum(num1: 20, num2: 30)
```

* 定义一个闭包
    * 闭包 = { (行参) -> 返回值 in // 代码实现 }
    * `in` 用于区分函数定义和代码实现

```swift
//: 闭包 = { (行参) -> 返回值 in // 代码实现 }
let sumFunc = { (num1 x: Int, num2 y: Int) -> Int in
    return x + y
}
sumFunc(num1: 10, num2: 20)
```

* 最简单的闭包，如果没有参数/返回值，则 `参数/返回值/in` 统统都可以省略
    * { 代码实现 }

```swift
let demoFunc = {
    print("hello")
}
```