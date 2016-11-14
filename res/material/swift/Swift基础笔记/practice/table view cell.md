# 自定义 Cell

## 知识点

* OC 中的重写模型 setter 方法，在 Swift 中改为属性的 `didSet` 中实现相应代码
* 由于已经完成设置，因此不再需要考虑 `_成员变量 = 变量`

## 演练

* 新建 `PersonCell`
* 拖拽控件 & 代码连线
* 定义模型属性 `person`
* 实现 `didSet`

```swift
class PersonCell: UITableViewCell {

    var person: Person? {
        didSet {
            nameLabel.text = person?.name
            ageLabel.text = String(person?.age ?? 0)
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
}
```

* 修改数据源方法

```swift
override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! PersonCell
    
    cell.person = persons![indexPath.row]
    
    return cell
}
```