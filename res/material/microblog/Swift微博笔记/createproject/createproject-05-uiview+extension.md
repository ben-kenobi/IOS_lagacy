# UIView的Frame抽取

## 抽取原因
在我们设置(获取) view 的x值或者y值的时候，需要先将 view 的 Frame 取出来，用一个变量记住，然后设置完 frame 内的值之后设置回去，流程烦索麻烦：
```swift
//设置按钮的宽
var frame = childView.frame
frame.size.width = childW
//设置按钮的x
frame.origin.x = CGFloat(index) * childW
childView.frame = frame
```
抽取之后的代码：
```swift
//设置按钮的宽
childView.width = childW
//设置按钮的x
childView.x = CGFloat(index) * childW
```

## 代码实现
利用Swift中的 `extension` 来实现，与oc中的 category 类似，给 UIView 的 extension 添加各个`计算性属性`代码如下：
```swift
import UIKit

extension UIView {

    // 宽度
    var width: CGFloat {
        get{
            return self.frame.width
        }
        set{
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }

    // 高度
    var height: CGFloat {
        get{
            return self.frame.height
        }
        set{
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }

    // X值
    var x: CGFloat {
        get{
            return self.frame.origin.x
        }
        set{
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }

    // Y值
    var y: CGFloat {
        get{
            return self.frame.origin.y
        }
        set{
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }

    // 中心X值
    var centerX: CGFloat {
        get{
            return self.center.x
        }
        set{
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }

    // 中心Y值
    var centerY: CGFloat {
        get{
            return self.center.y
        }
        set{
            var center = self.center
            center.y = newValue
            self.center = center
        }
    }

    // 大小
    var size: CGSize {
        get{
            return self.frame.size
        }
        set{
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
}
```
