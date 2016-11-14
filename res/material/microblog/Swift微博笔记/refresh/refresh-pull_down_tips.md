# 下拉刷新提示

- 修改 `loadStatuses` ，回调加载成功数据条数

```swift
/// 加载微博数据的方法
    func loadData(isPullUp isPullUp: Bool, completion: (isSuccessed: Bool, count: Int)->()) {
}
```

- 懒加载提示控件

```swift
/// 下拉刷新提示的label
// 提示控件
private lazy var pullDownTipLabel: UILabel = {
    let label = UILabel(textColor: UIColor.whiteColor(), fontSize: 12)
    // 设置文字居中、背景颜色
    label.textAlignment = NSTextAlignment.Center
    label.backgroundColor = UIColor.orangeColor()

    // 设置大小
    label.size = CGSizeMake(SCREENW, 35)
    return label
}()
```

- 增加 `showPullDownTips` 方法，测试添加位置

```swift
/// 显示下拉刷新提示
private func showPullDownTips(count: Int){
    pullDownTipLabel.y = 35
    navigationController?.view.insertSubview(pullDownTipLabel, belowSubview: navigationController!.navigationBar)
}
```

- 更改懒加载代码

```swift
/// 下拉刷新提示的label
private lazy var pullDownTipLabel: UILabel = {
    let label = UILabel()

    // 设置文字颜色、文字大小、居中、背景颜色
    label.textColor = UIColor.whiteColor()
    label.font = UIFont.systemFontOfSize(12)
    label.textAlignment = NSTextAlignment.Center
    label.backgroundColor = UIColor.orangeColor()

    // 设置大小
    label.size = CGSizeMake(SCREENW, 35)

    // 默认是隐藏状态
    label.hidden = true
    // 添加控件
    if let navigationController = self.navigationController {
        navigationController.view.insertSubview(label, belowSubview: navigationController.navigationBar)
    }
    return label
}()
```

- 完成显示逻辑

```swift
/// 显示下拉刷新提示
private func showPullDownTips(count: Int){

    // 如果当前控件处于显示状态，直接返回
    if !pullDownTipLabel.hidden {
        return
    }
    /// 提示文字信息
    let tipStr = count==0 ? "没有微博数据": "\(count)条新微博"
    let height = pullDownTipLabel.height
    pullDownTipLabel.y = CGRectGetMaxY(self.navigationController!.navigationBar.frame) - height
    // 设置文字并将其显示
    pullDownTipLabel.text = tipStr
    pullDownTipLabel.hidden = false
    //执行动画
    UIView.animateWithDuration(1, animations: { () -> Void in
        self.pullDownTipLabel.transform = CGAffineTransformMakeTranslation(0, height)
        }) { (finish) -> Void in
            UIView.animateWithDuration(1, delay: 1, options: [], animations: { () -> Void in
                self.pullDownTipLabel.transform = CGAffineTransformIdentity

                }, completion: { (finish) -> Void in
                    //动画执行完毕，隐藏
                    self.pullDownTipLabel.hidden = true
            })
    }
}
```








