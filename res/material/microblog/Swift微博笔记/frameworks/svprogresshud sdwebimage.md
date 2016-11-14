# SDWebImage & SVProgressHUD

## SVProgressHUD

* `SVProgressHUD` 是使用 OC 开发的指示器
* 使用非常广泛

### 框架地址

https://github.com/TransitApp/SVProgressHUD

### 与 `MBProgressHUD` 对比

* `SVProgressHUD`
    * 只支持 `ARC`
    * 支持较新的苹果 API
    * 提供有素材包
    * 使用更简单
* `MBProgressHUD`
    * 支持 `ARC` & `MRC`
    * 没有素材包，程序员需要针对框架进行一定的定制才能使用

### 使用

```swift
import SVProgressHUD

SVProgressHUD.showInfoWithStatus("正在玩命加载中...", maskType: SVProgressHUDMaskType.Gradient)
```

## SDWebImage

```swift
import SDWebImage

let url = NSURL(string: "http://img0.bdstatic.com/img/image/6446027056db8afa73b23eaf953dadde1410240902.jpg")!
SDWebImageManager.sharedManager().downloadImageWithURL(url, options: SDWebImageOptions.allZeros, progress: nil) { (image, _, _, _, _) in
    let data = UIImagePNGRepresentation(image)
    data.writeToFile("/Users/apple/Desktop/123.jpg", atomically: true)
}
```

