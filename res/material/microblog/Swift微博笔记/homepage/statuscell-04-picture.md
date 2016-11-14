# 微博配图

## 数据

配图数据对应的字段 `pic_urls`，格式为：

```json
pic_urls: [
    {
        thumbnail_pic: "http://ww2.sinaimg.cn/thumbnail/005Ko17Djw1exjar89996j30b40b440s.jpg"
    },
    {
        thumbnail_pic: "http://ww2.sinaimg.cn/thumbnail/005Ko17Djw1exjar89996j30b40b440s.jpg"
    }
]
```

* 定义 `pic_urls` 内部的数据模型 `HMStatusPhotoInfo`

```swift
class HMStatusPhotoInfo: NSObject {

    /// 约略图地址
    var thumbnail_pic: String?

    init(dictionary: [String: AnyObject]){
        super.init()
        setValuesForKeysWithDictionary(dictionary)
    }

    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
}
```

* 在 `HMStatus` 模型中增加配图数组模型

```swift
/// 配图模型数组
var pic_urls: [HMStatusPhotoInfo]?
```

* 在 `setValue(value: AnyObject?, forKey key: String)` 函数中增加一下代码

```swift
if key == "pic_urls" {
    var tempArray = [HMStatusPhotoInfo]()
    // 遍历字典转模型
    for value in value as! [[String: AnyObject]] {
        tempArray.append(HMStatusPhotoInfo(dictionary: value))
    }
    pic_urls = tempArray
}
```

## 思路
* 图片可以有多张可以使用 UICollectionView 实现
* 根据原创微博(转发微博)是否有配图去显示或者隐藏控件

## 控件显示实现


* 定义 `HMStatusPictureView`

```swift
class HMStatusPictureView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        // 为了测试，设置背景颜色为随机色
        backgroundColor = RandomColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
```

### 原创微博
* 在 `HMStatusOriginalView` 中懒加载控件

```swift
/// 配图视图
private lazy var pictureView: HMStatusPictureView = HMStatusPictureView()
```

* 添加控件并设置约束

```swift
// 配图视图
pictureView.snp_makeConstraints { (make) -> Void in
    // 先写死一个宽高
    make.size.equalTo(CGSizeMake(100, 100))
    make.leading.equalTo(contentLabel.snp_leading)
    make.top.equalTo(contentLabel.snp_bottom).offset(HMStatusCellMargin)
}
```

> 下一步就需要根据原创微博是否有配图去动态更新当前原创微博View的高度
* 如果有：原创微博 View 的底部是相对于配图控件来说的
* 如果没有：原创微博 View 的底部是相对于微博内容控件来说的
* 所以需要在初始化控件的时候记录当前 View 底部的约束

* 记录底部的约束

```swift
/// 当前 View 的底部约束
private var bottomConstraint: Constraint?
...
// 约束当前 View 的底部与正文内容的底部一样 并 记录该约束
snp_makeConstraints { (make) -> Void in
    self.bottomConstraint = make.bottom.equalTo(contentLabel.snp_bottom).offset(HMStatusCellMargin).constraint
}
```
* 在设置视图模型的时候判断是否有配图去更新约束

```swift
// 先移除之前的约束
bottomConstraint?.uninstall()
// 配图视图
if let picUrls = statusViewModel?.status?.pic_urls where picUrls.count > 0 {
    pictureView.hidden = false
    // 有配图，更新约束 -> 更新当前 View 底部的约束
    self.snp_updateConstraints(closure: { (make) -> Void in
        self.bottomConstraint = make.bottom.equalTo(pictureView.snp_bottom).offset(HMStatusCellMargin).constraint
    })
}else{
    // 没有配图，隐藏配图控件
    pictureView.hidden = true
    self.snp_updateConstraints(closure: { (make) -> Void in
        self.bottomConstraint = make.bottom.equalTo(contentLabel.snp_bottom).offset(HMStatusCellMargin).constraint
    })
}
```
> 运行测试：原创微博有配图，就会显示配图控件

* 根据配图的张数计算控件大小
    * 添加方法 `calcViewSize()` 到 `HMStatusPictureView` 中

```swift
/// 根据图片个数计算当前View的大小
private func calcViewSize() -> CGSize {

    // 获取到配图张数
    let count = pic_urls?.count ?? 0
    // 计算出每一个条目的宽高

    // 每一个条目之间的间距
    let HMStatusPictureItemMargin: CGFloat = 5
    // 每一个Item的宽高
    let HMStatusPictureItemWH = (SCREENW - 2 * HMStatusCellMargin - 2 * HMStatusPictureItemMargin) / 3

    // 计算出多少列
    let col = count == 4 ? 2 : (count > 3 ? 3 : count)
    let row = count == 4 ? 2 : ((count - 1) / 3 + 1)

    // 计算出当前控件的宽度
    let width = HMStatusPictureItemWH * CGFloat(col) + CGFloat(col - 1) * HMStatusPictureItemMargin;
    let height = HMStatusPictureItemWH * CGFloat(row) + CGFloat(row - 1) * HMStatusPictureItemMargin;

    return CGSizeMake(width, height)
}
```
* 定义配图数据的属性

```swift
/// 配图
var pic_urls: [HMStatusPhotoInfo]?
```

* `HMStatusOriginalView` 设置数据的时候给配图 View 设置数据

```swift
// 设置数据
pictureView.pic_urls = picUrls
```
* 在设置数据的时候去更新当前配图控件的大小约束

```swift
/// 配图
var pic_urls: [HMStatusPhotoInfo]? {
    didSet{

        // 在设置配图的时候计算当前 View 的大小
        snp_updateConstraints { (make) -> Void in
            make.size.equalTo(calcViewSize())
        }
    }
}
```

* 为了测试方便，添加一个测试 label 到配图控件里面，显示当前配图控件里面需要展示几张图片

```swift
/// 测试：用于显示张数的label
private lazy var label: UILabel = {
    let label = UILabel()
    label.textColor = UIColor.blackColor()
    label.font = UIFont.systemFontOfSize(30)
    return label
}()
...
// 添加控件以及添加约束
addSubview(label);
label.snp_makeConstraints { (make) -> Void in
    make.center.equalTo(self.snp_center)
}
...
// 在设置数据的时候，让 label 显示配图张数
var pic_urls: [HMStatusPhotoInfo]? {
    didSet{
        ...
        label.text = "\(pic_urls!.count)"
    }
}
```

> 运行测试

### 转发微博配图

* 添加控件思路与原创微博一样

> 注意：设置数据的时候一定要设置成转发微博的数据


## 图片显示

* 定义可重用 ID

```swift
// 可重用ID
private let HMStatusPictureCellId = "HMStatusPictureCellId"
```

* 设置数据源以及代理，设置每一个 item 的宽度

```swift
override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
    ...
    // 设置代理与数据源都是自己
    self.delegate = self
    self.dataSource = self

    // 设置layout
    let layout = collectionViewLayout as! UICollectionViewFlowLayout
    layout.itemSize = CGSizeMake(HMStatusPictureItemWH, HMStatusPictureItemWH)
    // 设置间隔
    layout.minimumInteritemSpacing = HMStatusPictureItemMargin
    layout.minimumLineSpacing = HMStatusPictureItemMargin
    // 注册cell
    self.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: HMStatusPictureCellId)
}
```

* 实现两个数据源方法

```swift
extension HMStatusPictureView {

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pic_urls?.count ?? 0
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(HMStatusPictureCellId, forIndexPath: indexPath)
        // 为了查看出效果，设置 cell 的背景颜色为随机色
        cell.backgroundColor = RandomColor()
        return cell
    }
}
```
> 运行测试

* 自定义 Cell `HMStatusPictureCell`

```swift
private class HMStatusPictureCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        // 设置背景颜色为随机颜色
        backgroundColor = RandomColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
```

* 更改注册的cell

```swift
// 注册cell
self.registerClass(HMStatusPictureCell.self, forCellWithReuseIdentifier: HMStatusPictureCellId)
```

> 运行测试

* 添加图片控件

```swift
// 懒加载控件
private lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    // 设置imageView的显示模式
    imageView.contentMode = UIViewContentMode.ScaleAspectFill
    // 切掉多余部分
    imageView.clipsToBounds = true
    return imageView;
}()
...
// 添加控件并设置约束
// 添加子控件
contentView.addSubview(imageView)
// 添加约束
imageView.snp_makeConstraints { (make) -> Void in
    make.size.equalTo(contentView.snp_size)
    make.leading.equalTo(contentView.snp_leading)
    make.top.equalTo(contentView.snp_top)
}
```

* 添加属性 `photoInfo`

```swift
/// 设置数据模型
var photoInfo: HMStatusPhotoInfo?
```

* 在数据源方法里面设置数据

```swift
func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(HMStatusPictureCellId, forIndexPath: indexPath) as! HMStatusPictureCell
    // 设置数据
    cell.photoInfo = pic_urls![indexPath.row]
    return cell
}
```

* 显示图片

```swift
var photoInfo: HMStatusPhotoInfo? {
    didSet{
        if let urlString = photoInfo?.thumbnail_pic{
            imageView.sd_setImageWithURL(NSURL(string: urlString), placeholderImage: UIImage(named: "timeline_image_placeholder"))
        }
    }
}
```

* 添加 gif 图标

```swift
/// gif 图标
private lazy var gifIcon: UIImageView = UIImageView(image: UIImage(named: "timeline_image_gif"))
...
/// 添加控件
contentView.addSubview(gifIcon)
...
/// 添加约束
gifIcon.snp_makeConstraints { (make) -> Void in
    make.trailing.equalTo(contentView.snp_trailing)
    make.bottom.equalTo(contentView.snp_bottom)
}
...
/// 显示逻辑
if let urlString = photoInfo?.thumbnail_pic{
    imageView.sd_setImageWithURL(NSURL(string: urlString), placeholderImage: UIImage(named: "timeline_image_placeholder"))
    gifIcon.hidden = !urlString.hasSuffix(".gif");
}
```


* 设置配图控件的背景颜色

```swift
/// 原创微博配图控件
private lazy var pictureView: HMStatusPictureView = {
    let pictureView = HMStatusPictureView()
    pictureView.backgroundColor = UIColor.whiteColor();
    return pictureView;
}()
...
/// 转发微博配图控件
private lazy var pictureView: HMStatusPictureView = {
    let pictureView = HMStatusPictureView()
    pictureView.backgroundColor = UIColor(white: 0.95, alpha: 1);
    return pictureView;
}()
```






