# for 循环

* OC 风格的循环

```swift
var sum = 0
for var i = 0; i < 10; i++ {
    sum += i
}
print(sum)
```

* `for-in`，0..<10 表示从0到9

```swift
sum = 0
for i in 0..<10 {
    sum += i
}
print(sum)
```

* 范围 0...10 表示从0到10

```swift
sum = 0
for i in 0...10 {
    sum += i
}
print(sum)
```

* 省略下标
    * `_` 能够匹配任意类型
    * `_` 表示忽略对应位置的值

```swift
for _ in 0...10 {
    print("hello")
}
```
