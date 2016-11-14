# 首页动画

* 添加动画代码

```swift
/// 启动动画
/**
首页的动画
*/
private func startAnim(){
    let anim = CABasicAnimation(keyPath: "transform.rotation")
    // 旋转
    anim.toValue = 2 * M_PI
    // 执行时间
    anim.duration = 20
    // 执行次数
    anim.repeatCount = MAXFLOAT
    // 切换界面的时候动画会被释放，指定为false之后切换界面动画就不会被释放
    anim.removedOnCompletion = false
    // 添加动画
    circleView.layer.addAnimation(anim, forKey: nil)
}
```

* 调整 `setupInfo` 函数

```swift
/// 设置访客视图信息
///
/// - parameter imageName: 图片名称
/// - parameter message:   消息文字
func setupInfo(imageName: String?, message: String?){
    if imageName == nil {
        circleView.hidden = false
        startAnim()
    }else{
        circleView.hidden = true
        iconView.image = UIImage(named: imageName!)
        messageLabel.text = message
    }
}
```

> 运行测试，发现切换控制器后动画会被释放，另外在首页退出到桌面再次进入，动画同样会被释放

* 设置动画属性

```swift
anim.removedOnCompletion = false
```
