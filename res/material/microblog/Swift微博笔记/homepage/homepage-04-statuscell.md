# 自定义 cell


* 建立 `HMStatusCell` 自定义 `Cell`

```swift
/// 微博 Cell
class HMStatusCell: UITableViewCell {

    // MARK: 搭建界面
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {

    }
}
```

* 建立微博视图模型

```swift
/// 微博视图模型
class HMStatusViewModel: NSObject {
    /// 微博模型
    var status: Status?

    /// 构造函数
    init(status: Status) {
        self.status = status
    }
}
```

* 添加视图模型属性

```swift
/// 微博视图模型
var statusViewModel: HMStatusViewModel?
```

* 修改 `HMStatusListViewModel` 中的网络代码中字典转模型部分

```swift
// 微博视图模型数组
var statuses: [HMStatusViewModel]?

...

// 字典转模型
if self.statuses == nil {
    self.statuses = [HMStatusViewModel]()
}
// 字典转模型
for dic in array {
    self.statuses?.append(HMStatusViewModel(status: HMStatus(dictionary: dic)))
}
```

* 修改 `HMHomeTableViewController` 数据源方法

```swift
tableView.registerClass(HMStatusCell.self, forCellReuseIdentifier: HMStatusCellId)

...

override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(HMStatusCellId, forIndexPath: indexPath) as! HMStatusCell
    // 获取微博的视图模型
    let statusModel = statusListViewModel.statuses![indexPath.row]
    cell.textLabel?.text = statusModel.status?.user?.name
    return cell
}
```

## 单元格分析

微博的单元格包含以下 `6` 种类型：

* 原创微博无图
* 原创微博单图
* 原创微博多图
* 转发微博无图
* 转发微博单图
* 转发微博多图

> 自定义 Cell 中需要注意的

* 单图会按照图片等比例显示
* 多图的图片大小固定
* 多图如果是4张，会按照 `2 * 2` 显示
* 多图其他数量，按照 `3 * 3` 九宫格显示
