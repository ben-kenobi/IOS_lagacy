# 准备工作

* 修改 `ViewController` 的类为 `UITableViewController`
* 删除 `Main.storyboard` 中的默认控制器，新增为 `UITableViewController`
* 设置为初始控制器
* 设置 Cell 的可重用标识符 `Cell`
* 指定 UITableViewController 的指定类为 `ViewController`

```swift
class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
```
