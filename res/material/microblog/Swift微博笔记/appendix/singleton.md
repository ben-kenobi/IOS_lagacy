# Swift 单例

* OC 的单例写法

```objc
+ (instancetype)sharedTools {
    static id instance;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });

    return instance;
}
```

* Swift 仿 OC 的写法

```swift
class SoundTools: NSObject {

    static var instance: SoundTools?
    static var onceToken: dispatch_once_t = 0

    class func sharedSoundTools() -> SoundTools {
        dispatch_once(&onceToken) { () -> Void in
            instance = SoundTools()
        }
        return instance!
    }
}
```

> 在 Swift 中默认使用`项目名称`作为类的命名空间，但是在做混合开发时，不允许使用特殊符号，可以参照下图修改

![](修改命名空间.png)

* 导入头文件

```objc
#import "单例测试-Swift.h"
```

> 导入头文件的格式是 `命名空间-Swift.h`

* Swift 中的单例写法

```swift
// Swift 单例写法
static let sharedSoundTools = SoundTools()

override init() {
    print("创建单例！")
}
```

