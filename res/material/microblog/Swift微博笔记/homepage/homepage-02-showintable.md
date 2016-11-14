# 显示表格数据

* 定义可重用标识符

```swift
/// 表格标识符
private let HMStatusCellId = "HMStatusCellId"
```

* 在 `viewDidLoad` 中调用方法注册可重用 `Cell`

```swift
/// 设置tableView相关
private func setupTableView(){
    // 注册系统的cell
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: HMStatusCellId)
}
```

* 实现数据源函数

```swift
// MARK: - Table view data source
override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return statusListViewModel.statuses?.count ?? 0
}

override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(HMStatusCellId, forIndexPath: indexPath)
    cell.textLabel?.text = statusListViewModel.statuses![indexPath.row].text
    return cell
}
```

