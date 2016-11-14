# 发布微博

## 发布文本处理

> 在发送微博时，只发送表情符号对应的文本，而不是表情图片

- 目标：界面上显示图片，但要能够拿到完整的文本字符串

- 打印属性文本

```swift
@objc private func send(){
    printLog(textView.attributedText)
}
```

- 遍历属性文本

```swift
let attributedString = textView.attributedText
// 遍历
attributedString.enumerateAttributesInRange(NSMakeRange(0, attributedString.length), options: []) { (dict, range, _) -> Void in
    printLog(dict)
    printLog(range)
    printLog("-----------")
}
```

- 根据输出判定如果字典中包含 `NSAttachment` 择是图片，否则是文本

```swift
// 遍历
attributedString.enumerateAttributesInRange(NSMakeRange(0, attributedString.length), options: []) { (dict, range, _) -> Void in
    if let attachment = dict["NSAttachment"] as? NSTextAttachment {
        printLog("图片 \(attachment)")
    }else{
        let str = (attributedString.string as NSString).substringWithRange(range)
        printLog("文字： \(str)")
    }
    printLog("-----------")
}
```
> 问题：如何从 `NSAttachment` 中获取到该表情对应的字符串？

- 自定义 `NSAttachment` 子类，增加 `chs` 属性

```swift
class HMEmoticonAttachment: NSTextAttachment {

    /// 表情字符串
    var chs: String

    init(chs: String){
        self.chs = chs
        // 调用父类的指定构造函数
        super.init(data: nil, ofType: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
```

- 创建属性图片时设置 chs

```swift
let attachment = EmoticonAttachment(chs: emoticon.chs!)
```

### 将表情转化成字符串

- 在 `HMEmoticonTextView` 中提供计算型属性 `emoticonText`

```swift

/// 包括表情字符串的 文字内容
var emoticonText: String {

    var result = String()

    let attributedString = self.attributedText
    attributedString.enumerateAttributesInRange(NSMakeRange(0, attributedString.length), options: []) { (dict, range, _) -> Void in
        // 如果有文字附件，代表当前遍历到的是表情
        if let attachment = dict["NSAttachment"] as? HMEmoticonAttachment {
            result += attachment.chs
        }else{
            // 否则是文字
            let str = (attributedString.string as NSString).substringWithRange(range)
            result += str
        }
    }
    return result
}
```

## 发布文字微博

### 接口定义

- 文档地址

    - http://open.weibo.com/wiki/2/statuses/update

- 接口地址

    - https://api.weibo.com/2/statuses/update.json

- HTTP 请求方式

    - POST

- 请求参数

| 参数 | 说明 |
| -- | -- |
| access_token | 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得 |
| status | 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字 |

> 连续两次发布的微博不可以重复


- 在 `HMNetworkTools` 中添加 `update` 方法

```swift
/// 发布文字微博
func update(accessToken: String, text: String, finished: HMRequestCallBack){
    // 请求地址
    let urlString = "https://api.weibo.com/2/statuses/update.json"
    // 请求参数
    let params = [
        "access_token": accessToken,
        "status": text
    ]
    request(.POST, url: urlString, params: params, finished: finished)
}
```

- 在 `HMComposeViewController` 中调用

```swift
/// 发送文字微博
private func update(){
    HMNetworkTools.shareTools.update(HMUserAccountViewModel.sharedUserAccount.accessToken!, text: textView.emoticonText) { (result, error) -> () in
        if error != nil {
            print(error)
            SVProgressHUD.showErrorWithStatus("发表失败")
            return
        }
        print(result)
        SVProgressHUD.showSuccessWithStatus("发表成功")
    }
}
```

## 发布图片微博

### 接口定义

#### 文档地址

http://open.weibo.com/wiki/2/statuses/upload

#### 接口地址

https://upload.api.weibo.com/2/statuses/upload.json

#### HTTP 请求方式

- POST

#### 请求参数

| 参数 | 说明 |
| -- | -- |
| access_token | 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得 |
| status | 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字 |
| pic | 要上传的图片，仅支持JPEG、GIF、PNG格式，图片大小小于5M |

> 请求必须用POST方式提交，并且注意采用multipart/form-data编码方式

### 代码实现

- 在 `HMNetworkTools` 中添加上传图片的方法

```swift
func upload(accessToken: String, text: String, image: UIImage, finished: HMRequestCallBack){
    // url
    let url = "https://upload.api.weibo.com/2/statuses/upload.json"

    let params = [
        "access_token": accessToken,
        "status": text
    ]

    POST(url, parameters: params, constructingBodyWithBlock: { (formData) -> Void in
        let data = UIImagePNGRepresentation(image)!
        /**
            1. data: 二进制数据
            2. name: 服务器定义的字段名称
            3. fileName: 保存在服务器的文件名，通常可以乱写，服务器自己会做处理
            4. mimeType: 告诉服务器文件类型
                - 大类型 / 小类型
                    image/jepg, image/png
                    text/plain, text/html
                - 如果不想告诉服务器准确类型:
                    application/octet-stream

        */
        formData.appendPartWithFileData(data, name: "pic", fileName: "xxaaa", mimeType: "image/jpeg")
        }, success: { (_, response) -> Void in
            guard let dict = response as? [String: AnyObject] else {
                // 如果不是字典，返回错误
                let error = NSError(domain: "com.itheima.error", code: -1001, userInfo: ["message": "The response data type isn't a [String: AnyObject]"])
                finished(result: nil, error: error)
                return
            }
            finished(result: dict, error: nil)
        }) { (_, error) -> Void in
            finished(result: nil, error: error)
    }
}
```


