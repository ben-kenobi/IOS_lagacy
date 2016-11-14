# 新特性页
* 新特性是现在很多应用程序中包含的功能，主要用于在系统升级后，用户第一次进入系统时获知新升级的功能

## 功能实现

### 准备文件

* 将新特性图片素材拖拽到 Assets.xcassets 中
* 在 `View` 下建立 `NewFeature` 目录
* 新建 `HMNewFeatureViewController.swift` 继承自 `UIViewController`

### 代码实现

* 修改 `AppDelegate` 的根视图控制器

```swift
window?.rootViewController = HMNewFeatureViewController()
```

* 初始化 UIScrollView

```swift
/// scrollView
private lazy var scrollView: UIScrollView = {
    // 添加ScrollView
    let scrollView = UIScrollView(frame: UIScreen.mainScreen().bounds)
    // 背景颜色
    scrollView.backgroundColor = UIColor.whiteColor()

    return scrollView
}()
```

* 添加 View 内容

```swift
/// 设置View内容
private func setupView(){
    // 添加ScrollView
    view.addSubview(scrollView)

    // 遍历添加4张图片
    let count = 4
    for i in 0..<count {
        // 初始化imageView
        let imageView = UIImageView(image: UIImage(named: "new_feature_\(i + 1)"))
        // 指定imageView的Frame
        imageView.frame = CGRectMake(CGFloat(i) * scrollView.width, 0, scrollView.width, scrollView.height)
        scrollView.addSubview(imageView)
    }
}

```
* 设置 scrollView 的滚动范围

```swift
// 指定ScrollView的滚动范围
scrollView.contentSize = CGSizeMake(scrollView.width * CGFloat(count), 0)
```
* 设置 scrollView 的其他属性

```swift
// 开启分页
scrollView.pagingEnabled = true
// 隐藏水平滚动条
scrollView.showsHorizontalScrollIndicator = false
// 关闭边缘弹簧效果
scrollView.bounces = false
```
### 添加 UIPageControl

* 初始化 UIPageControl

```swift
/// pageControl
private lazy var pageControl: UIPageControl = {
    let pageControl = UIPageControl()
    // 设置pageControl的当前选中的颜色与默认的颜色
    pageControl.currentPageIndicatorTintColor = UIColor.orangeColor()
    pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
    return pageControl
}()
```

* 添加 UIPageControl

```swift
// 添加pageControl
view.addSubview(pageControl)
pageControl.numberOfPages = count
// 指定位置
pageControl.centerX = view.width * 0.5
pageControl.y = view.height - 100
```

* 设置 ScrollView 的代理，监听 ScrollView 滚动到第几页
    * 实时获取到 ScrollView 的contentOffset的x值，计算当前滚动到第几页

```swift
// MARK: - UIScrollView delegate
func scrollViewDidScroll(scrollView: UIScrollView) {
    // 当前页 等于 水平滚动距离 / scrollView的宽度 再作 四舍五入 最后转成整数
    let currentPage = Int(scrollView.contentOffset.x / scrollView.width + 0.5)
    print(currentPage)
}
```
> 运行测试

* 设置 pageControl 当前选中

```swift
// 设置pageControl当前选中页
pageControl.currentPage = currentPage
```

### 设置最后一页的内容

* 初始化两个按钮 (进入按钮 & 分享按钮)

```swift
/// 进入按钮
private lazy var enterButton: UIButton = {
    let button = UIButton()
    // 添加点击事件
    button.addTarget(self, action: "enterButtonClick", forControlEvents: .TouchUpInside)
    button.setTitle("进入微博", forState: .Normal)
    // 设置不同状态的背景图片
    button.setBackgroundImage(UIImage(named: "new_feature_finish_button"), forState: .Normal)
    button.setBackgroundImage(UIImage(named: "new_feature_finish_button_highlighted"), forState: .Highlighted)
    button.sizeToFit()
    return button
}()

/// 分享按钮
private lazy var sharedButton: UIButton = {
    let button = UIButton()
    // 添加点击事件
    button.addTarget(self, action: "sharedButtonClick:", forControlEvents: .TouchUpInside)
    button.setTitle("分享到微博", forState: .Normal)
    // 设置不同状态的image
    button.setImage(UIImage(named: "new_feature_share_false"), forState: .Normal)
    button.setImage(UIImage(named: "new_feature_share_true"), forState: .Selected)
    button.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
    // 设置字体大小
    button.titleLabel?.font = UIFont.systemFontOfSize(15)
    // 设置文字与图片之前的间距
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
    button.sizeToFit()
    // 将长度添加10个，防止上一步加上间距之后出现的问题
    button.width = button.width + 10
    return button
}()

```

* 提供一个设置最后一页内容的方法

``` swift
/// 设置最后一页的内容
///
/// - parameter imageView: 最后一页的图片
private func setupLastPage(imageView: UIImageView) {

    // 设置进入按钮的x与y
    enterButton.centerX = imageView.width * 0.5
    enterButton.y = imageView.height - 150

    //设置分享按钮的x与y
    sharedButton.centerX = enterButton.centerX
    sharedButton.y = enterButton.y - 30

    // 添加到最后一页的imageView上
    imageView.addSubview(enterButton)
    imageView.addSubview(sharedButton)

}
```
> 运行，最后一页按钮不能点击

* 开启用户交互

```swift
// 开启用户交互
imageView.userInteractionEnabled = true
```

* 实现两个按钮的点击方法

```swift
// MARK: - 按钮点击的方法
/// 分享按钮点击
@objc private func sharedButtonClick(button: UIButton){
    button.selected = !button.selected
}

/// 进入按钮点击
@objc private func enterButtonClick(){
    print("进入按钮点击")
}
```


### 隐藏状态栏

```swift
override func prefersStatusBarHidden() -> Bool {
    return true
}
```
