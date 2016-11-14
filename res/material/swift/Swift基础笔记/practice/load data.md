# 创建模型加载数据

## 知识点

* `extension` 可以让代码结构更加清晰
* 闭包（block）
    * 应用场景：异步执行完成后，通过参数传递异步执行的结果
    * 定义技巧
    * 引用当前对象必须使用 `self.`
* 重写 `description` 属性可以方便开发调试

## 加载数据 —— `extension`

* 新建 Person.swift

```swift
/// 个人信息
class Person: NSObject {
    var name: String?
    var age: Int = 0
    
    init(dict: [String: AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
}
```

* 编写 `loadData` 函数实现数据异步加载

```swift
// MARK: - 数据处理
extension ViewController {
    /// 加载数据
    private func loadData() {
        
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            print("后台加载数据...")
            
            var array = [Person]()
            
            // 填充数据
            for i in 0..<50 {
                let name = "张三 \(i)"
                let age = random() % 20 + 10
                
                array.append(Person(dict: ["name": name, "age": age]))
            }
            
            print(array)
        }
    }
}
```

#### 小结

* `extension` 类似于 `OC` 的 `Category`，不过可以按照函数类型区分代码
* 能够让代码结构具有更好的可读性

* 重写 `description` 属性，便于调试

### 对象描述信息

```swift
override var description: String {
    let keys = ["name", "age"]
    return dictionaryWithValuesForKeys(keys).description
}
```

### 加载数据 —— 完成回调

```swift
/// 加载数据
private func loadData(finished: (array: [Person])->()) {
    
    dispatch_async(dispatch_get_global_queue(0, 0)) {
        
        print("后台加载数据...")
        
        var array = [Person]()
        
        // 填充数据
        for i in 0..<50 {
            let name = "张三 \(i)"
            let age = random() % 20 + 10
            
            array.append(Person(dict: ["name": name, "age": age]))
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            finished(array: array)
        }
    }
}
```

* 闭包参数的定义技巧

    * 定义参数 `finished: ()->()`
    * 根据需要添加闭包的参数 `finished: (array: [Person])->()`
    * 调用闭包，需要附带 `外部参数`

> 在 iOS 开发中，闭包(block)最常用的应用场景就是异步执行完成后，通过参数传递异步执行的结果

* 定义个人数据数组

```swift
/// 个人数据数组
private var persons: [Person]?
```

* 调整调用 `loadData` 函数

```swift
loadData { (array) -> () in
    print(array)
}
```

### 绑定表格

* 实现数据源方法

```swift
// MARK: - 表格数据源方法
extension ViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = persons![indexPath.row].name
        
        return cell
    }
}
```

* 调整 `loadData` 函数

```swift
loadData { (array) -> () in
    // 1. 记录异步结果
    self.persons = array
    
    // 2. 刷新表格
    self.tableView.reloadData()
}
```

* 提示
    * `array` 没有智能提示
    * 闭包由于是提前准备好的代码，因此在使用到当前对象属性时，一定要指明当前对象 `self.`