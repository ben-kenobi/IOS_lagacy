# 上拉加载

## 实现效果与思路

- 当用户滚动到底部的时候，自动去加载更多数据
- 可以在加载当前页面最后一个 cell 的时候去执行加载更多数据的方法
- 给 tableView 添加一个 `footerView`（上拉显示控件），用作拉到最底部的友好显示

## 代码实现

- 懒加载底部上拉显示控件

```swift
// 上拉加载显示的控件
private lazy var pullupView: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
    return indicator;
}()
```

- 设置成 tableView 的footerView

```swift
// 设置上拉加载控件
tableView.tableFooterView = pullupView
```
> 运行测试，看不见任何东西。看不见控件的原因就是 UIActivityIndicatorView 控件默认不执行动画是看不见的

- 开启执行动画

```swift
pullupView.startAnimating()
```
> 运行测试，已经可以看到，但是位置没有留出来，执行 `sizeToFit` 方法

- 在返回最后一个 cell 的时候去加载更多数据

```swift
override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(HMStatusCellId, forIndexPath: indexPath) as! HMStatusCell
    // 获取微博的视图模型
    let statusModel = statusListViewModel.statuses![indexPath.row]
    cell.statusViewModel = statusModel

    if indexPath.row == statusListViewModel.statuses!.count - 1 && !pullupView.isAnimating {
        // 代表加载到最后一个，执行底部 View 动画
        pullupView.startAnimating()
        // 加载数据
        loadData()
    }
    return cell
}
```
> 注意：需要在判断里面多加一个条件，就是底部控件没有执行动画的时候才去加载更多数据，防止重复加载

- 更改 `loadData()` 方法逻辑

```swift
// MARK: - 加载数据
private func loadData(){

    var maxId = 0
    var sinceId = 0
    // 如果底部控件是正在执行动画，代表是上拉加载
    if pullupView.isAnimating() {
        if let id = statusListViewModel.statuses?.last?.status?.id {
            maxId = id - 1
        }
    }else{
        // 不是上拉加载
        sinceId = statusListViewModel.statuses?.first?.status?.id ?? 0
    }

    statusListViewModel.loadStatuses(sinceId, maxId: maxId, success: { (result) -> () in
        // 请求成功
        self.tableView.reloadData()
    }) { (error) -> () in
        // 请求失败
        printLog(error)
    }
}
```

- 更改 `HMStatusListViewModel` 中 `loadStatuses` 方法 -> 上拉加载与下拉刷新数据添加的位置不一样

```swift
if let array = res["statuses"] as? [[String: AnyObject]] {
    // 如果是字典
    // 判断数组是否为 nil
    if self.statuses == nil {
        self.statuses = [HMStatusViewModel]()
    }

    // 定义一个临时数组
    var tempStatuses = [HMStatusViewModel]()

    // 字典转模型
    for dic in array {
        tempStatuses.append(HMStatusViewModel(status: HMStatus(dictionary: dic)))
    }

    if sinceId > 0 {
        // 代表是下拉刷新，拼装数据到前面
        self.statuses = tempStatuses + self.statuses!
    }else{
        // 代表是上拉加载，拼装数据到集合后面
        self.statuses! += tempStatuses
    }
}

// 代表请求成功
success(result: res)
```

> 运行测试：发现只加载一次数据，下次再拖动就不去加载了，原因是加载完毕之后 pullupView 也一直在执行动画，下次就进入不到加载更多的判断逻辑里面去了，所以加载完毕需要将 pullupView 结束动画

- 结束动画

```
/// 结束刷新
private func endRefresh(){
    pullupView.stopAnimating()
}

/// 在数据请求成功，或者数据请求失败之后调用此方法
statusListViewModel.loadStatuses(sinceId, maxId: maxId, success: { (result) -> () in
    self.endRefresh()
    // 请求成功
    self.tableView.reloadData()
}) { (error) -> () in
    // 请求失败
    printLog(error)
    self.endRefresh()
}
```

> 运行测试







