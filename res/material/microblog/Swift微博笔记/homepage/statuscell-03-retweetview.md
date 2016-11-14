# 转发微博内容

## 数据模型准备

* 添加转发微博属性

```swift
/// 转发微博
var retweeted_status: HMStatus?
```

* 在 `setValue(value: AnyObject?, forKey key: String)` 函数中增加一下代码

```swift
// 2. 转发微博
if key == "retweeted_status" {
    retweeted_status = Status(dict: value as! [String: AnyObject])
    return
}
```

## 新建 `HMStatusRetweetView`

```swift
class HMStatusRetweetView: UIView {

    /// 微博视图模型
    var statusViewModel: HMStatusViewModel?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(){
        backgroundColor = UIColor(white: 0.95, alpha: 1)
    }
}
```
* 懒加载控件

```swift
// MARK: - 懒加载控件
/// 转发微博正文内容
private lazy var contentLabel = UILabel(color: UIColor.darkGrayColor(), fontSize: 15, layoutWidth: UIScreen.mainScreen().bounds.width - 2 * HMStatusCellMargin)
```
* 添加控件设置约束

```swift
private func setupUI(){
    backgroundColor = UIColor(white: 0.9, alpha: 1)

    // 添加子控件
    addSubview(contentLabel)

    // 设置约束
    contentLabel.snp_makeConstraints { (make) -> Void in
        make.top.equalTo(self.snp_top).offset(HMStatusCellMargin)
        make.leading.equalTo(self.snp_leading).offset(HMStatusCellMargin)
    }
    // 设置当前View的底部为内容的底部加上间距
    snp_makeConstraints { (make) -> Void in
        make.bottom.equalTo(contentLabel.snp_bottom).offset(HMStatusCellMargin)
    }
}
```

* 在 `HMStatusViewModel` 添加 `retweetText` 属性

```swift
// 转发微博内容
var retweetText: String? {
    if let retStatus = self.status?.retweeted_status where retStatus.text != nil  {
        return "@\(retStatus.user!.name!):\(retStatus.text!)"
    }
}
```


* 设置数据

```swift
/// 微博视图模型
var statusViewModel: HMStatusViewModel?{
    didSet{
        contentLabel.text = statusViewModel!.retweetText
    }
}
```

## 更新 `HMStatusCell`

* 添加转发微博控件

```swift
// 转发微博
private lazy var retweetView: HMStatusRetweetView = HMStatusRetweetView()
...
private func setupUI(){
    // 添加控件
    contentView.addSubview(originalView)
    contentView.addSubview(retweetView)
    contentView.addSubview(statusToolBar)


    // 添加原创微博内容的约束
    originalView.snp_makeConstraints { (make) -> Void in
        // 关键：约束原创微博整体 View 的顶部
        make.top.equalTo(contentView.snp_top)
        make.width.equalTo(contentView.snp_width)
    }
    // 添加转发微博内容的约束
    retweetView.snp_makeConstraints { (make) -> Void in
        make.top.equalTo(originalView.snp_bottom)
        make.leading.equalTo(originalView.snp_leading)
        make.width.equalTo(originalView.snp_width)
    }
    // 底部toolBar的约束
    statusToolBar.snp_makeConstraints { (make) -> Void in
        make.top.equalTo(retweetView.snp_bottom).constraint
        make.width.equalTo(originalView.snp_width)
        make.height.equalTo(35)
        make.bottom.equalTo(contentView.snp_bottom)
    }
}
```

* 设置数据（需要判断是否有转发微博）

```swift
/// 微博视图模型
var statusViewModel: HMStatusViewModel? {
    didSet{
        // 设置视图模型
        originalView.statusViewModel = statusViewModel
        statusToolBar.statusViewModel = statusViewModel

        // 如果有转发微博
        if statusViewModel?.status?.retweeted_status != nil {
            retweetView.hidden = false
            // 设置转发微博的视图模型
            retweetView.statusViewModel = statusViewModel
            // TODO：需要更新约束，statusToolBar的顶部要与转发微博底部对齐
        }else{
            // 没有转发微博，隐藏转发微博的View
            retweetView.hidden = true
            // TODO：需要更新约束，statusToolBar的顶部要与原创微博底部对齐

        }
    }
}
```

* 定义变量记住 `statusToolBar` 的顶部约束

```swift
// toolBar 顶部约束
var toolBarTopConstraints: Constraint?

...
// 在约束toolBar顶部约束的时候记录
// 底部toolBar
statusToolBar.snp_makeConstraints { (make) -> Void in
    self.toolBarTopConstraints = make.top.equalTo(retweetView.snp_bottom).constraint
    make.width.equalTo(originalView.snp_width)
    make.height.equalTo(35)
    make.bottom.equalTo(contentView.snp_bottom)
}
```

* 根据是否有转发微博更新约束

```swift
// 先让之前记录的约束失效 -> 约束的时候重新记录
toolBarTopConstraints?.uninstall()
// 如果有转发微博
if statusViewModel?.status?.retweeted_status != nil {
    retweetView.hidden = false
    // 设置转发微博的视图模型
    retweetView.statusViewModel = statusViewModel
    statusToolBar.snp_updateConstraints(closure: { (make) -> Void in
        toolBarTopConstraints = make.top.equalTo(retweetView.snp_bottom).constraint
    })
}else{
    // 没有转发微博，隐藏转发微博的View
    retweetView.hidden = true
    // 更新约束
    statusToolBar.snp_updateConstraints(closure: { (make) -> Void in
        toolBarTopConstraints = make.top.equalTo(originalView.snp_bottom).constraint
    })
}
```

> 运行测试






