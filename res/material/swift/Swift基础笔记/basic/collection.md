# 集合

## 数组

* 数组使用 `[]` 定义，这一点与 OC 相同

```swift
//: [Int]
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
```

* 遍历

```swift
for num in numbers {
    print(num)
}
```

* 通过下标获取指定项内容

```swift
let num1 = numbers[0]
let num2 = numbers[1]
```

* 可变&不可变
    * `let` 定义不可变数组
    * `var` 定义可变数组

```swift
let array = ["zhangsan", "lisi"]
//: 不能向不可变数组中追加内容
//array.append("wangwu")
var array1 = ["zhangsan", "lisi"]

//: 向可变数组中追加内容
array1.append("wangwu")
```

* 数组的类型
    * 如果初始化时，所有内容类型一致，择数组中保存的是该类型的内容
    * 如果初始化时，所有内容类型不一致，择数组中保存的是 `NSObject`

```swift
//: array1 仅允许追加 String 类型的值
//array1.append(18)

var array2 = ["zhangsan", 18]
//: 在 Swift 中，数字可以直接添加到集合，不需要再转换成 `NSNumber`
array2.append(100)
//: 在 Swift 中，如果将结构体对象添加到集合，仍然需要转换成 `NSValue`
array2.append(NSValue(CGPoint: CGPoint(x: 10, y: 10)))
```

* 数组的定义和实例化
    * 使用 `:` 可以只定义数组的类型
    * 实例化之前不允许添加值
    * 使用 `[类型]()` 可以实例化一个空的数组

```swift
var array3: [String]
//: 实例化之前不允许添加值
//array3.append("laowang")
//: 实例化一个空的数组
array3 = [String]()
array3.append("laowang")
```

* 数组的合并
    * 必须是相同类型的数组才能够合并
    * 开发中，通常数组中保存的对象类型都是一样的！

```swift
array3 += array1

//: 必须是相同类型的数组才能够合并，以下两句代码都是不允许的
//array3 += array2
//array2 += array3
```

* 数组的删除

```swift
//: 删除指定位置的元素
array3.removeAtIndex(3)
//: 清空数组
array3.removeAll()
```

* 内存分配
    * 如果向数组中追加元素，超过了容量，会直接在现有容量基础上 * 2

```swift
var list = [Int]()

for i in 0...16 {
    list.append(i)
    print("添加 \(i) 容量 \(list.capacity)")
}
```

## 字典

* 定义
    * 同样使用 `[]` 定义字典
    * `let` 不可变字典
    * `var` 可变字典
    * `[String : NSObject]` 是最常用的字典类型

```swift
//: [String : NSObject] 是最常用的字典类型
var dict = ["name": "zhangsan", "age": 18]
```

* 赋值
    * 赋值直接使用 `dict[key] = value` 格式
    * 如果 key 不存在，会设置新值
    * 如果 key 存在，会覆盖现有值

```swift
//: * 如果 key 不存在，会设置新值
dict["title"] = "boss"
//: * 如果 key 存在，会覆盖现有值
dict["name"] = "lisi"
dict
```

* 遍历
    * `k`，`v` 可以随便写
    * 前面的是 `key`
    * 后面的是 `value`

```swift
//: 遍历
for (k, v) in dict {
    print("\(k) ~~~ \(v)")
}
```

* 合并字典
    * 如果 key 不存在，会建立新值，否则会覆盖现有值

```swift
//: 合并字典
var dict1 = [String: NSObject]()
dict1["nickname"] = "大老虎"
dict1["age"] = 100

//: 如果 key 不存在，会建立新值，否则会覆盖现有值
for (k, v) in dict1 {
    dict[k] = v
}
print(dict)
```
