# Alamofire

* `Alamofire` 是 AFN 作者 `MATTT` 的又一力作，用 Swift 编写一套轻量级网络框架
* 官方地址：https://github.com/Alamofire/Alamofire

## 演练

* 示例代码

```swift
UIApplication.sharedApplication().networkActivityIndicatorVisible = true
Alamofire.request(.GET,
    "http://www.httpbin.org/get",
    parameters: ["name": "zhangsan", "age": 18],
    headers: ["User-Agent": "iPhone"]).responseJSON { (response) -> Void in

        print(response.result.value)
        print(response.result.error)
        print(response.result.isSuccess)
        print(response.result.isFailure)

        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }.responseString { (response) -> Void in
        print(response.result.value)
        print(response.result.error)
        print(response.result.isSuccess)
        print(response.result.isFailure)
}
```

### 与 AFN 使用的对比

* 支持链式响应
* 本身就是单例，可以直接使用
* 如果使用 `responseJSON`，不需要指定响应数据格式
* 如果服务器返回的数据类型不正确，可以使用 `responseString` 直接查阅服务器返回的 JSON 字符串
* 不再提供网络指示器，需要自己添加
* 上传文件的方法没有 AFN 方便

## 新浪微博

### 更新 Pod

* 修改 Podfile

```
# Uncomment this line to define a global platform for your project
platform :ios, '8.0'
# Uncomment this line if you're using Swift
use_frameworks!

pod 'Alamofire'
pod 'SDWebImage'
pod 'SVProgressHUD'
pod 'SnapKit'
```

* 在终端输入以下命令，更新 Pod

```bash
$ pod update

# 或者

$ pod update --no-repo-update
```

### 网络框架

* import

```swift
import Alamofire
```

* 单例

```swift
/// 单例
static let sharedTools = NetworkTools()
```

* 删除请求方法枚举 `HMRequestMethod`

```swift
/// HTTP 请求方法枚举
enum HMRequestMethod: String {
    case GET = "GET"
    case POST = "POST"
}
```

* 修改 `tokenRequest` 函数 `method` 的参数类型

```swift
private func tokenRequest(method: Alamofire.Method, URLString: String, var parameters: [String: AnyObject]?, finished: HMRequestCallBack) {
```

* 修改 `request` 函数

```swift
/// 网络请求
///
/// - parameter method:     GET / POST
/// - parameter URLString:  URLString
/// - parameter parameters: 参数字典
/// - parameter finished:   完成回调
private func request(method: Alamofire.Method, URLString: String, parameters: [String: AnyObject]?, finished: HMRequestCallBack) {

    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    Alamofire.request(method, URLString, parameters: parameters).responseJSON { (response) in

        UIApplication.sharedApplication().networkActivityIndicatorVisible = false

        if response.result.isFailure {
            print("网络响应错误 \(response.result.error)")
        }
        finished(result: response.result.value, error: response.result.error)
    }
}
```

* 注释 `upload` 函数，运行测试

#### upload

* 官方示例

```swift
Alamofire.upload(
    .POST,
    "http://httpbin.org/post",
    multipartFormData: { multipartFormData in
        multipartFormData.appendBodyPart(fileURL: unicornImageURL, name: "unicorn")
        multipartFormData.appendBodyPart(fileURL: rainbowImageURL, name: "rainbow")
    },
    encodingCompletion: { encodingResult in
        switch encodingResult {
        case .Success(let upload, _, _):
            upload.responseJSON { response in
                debugPrint(response)
            }
        case .Failure(let encodingError):
            print(encodingError)
        }
    }
)
```

* 修改 `upload` 函数

```swift
/// 上传文件
private func upload(URLString: String, data: NSData, name: String, var parameters: [String: AnyObject]?, finished: HMRequestCallBack) {

    // 2> 上传文件
    Alamofire.upload(.POST, URLString, multipartFormData: { (formData) -> Void in

        // 1. 追加文件
        formData.appendBodyPart(data: data, name: name, fileName: "xxx", mimeType: "application/octet-stream")

        // 2. 追加字典
        guard let parameters = parameters else {
            return
        }
        for (k, v) in parameters {
            // 将内容转换成字符串
            if let str = v as? String {
                let data = str.dataUsingEncoding(NSUTF8StringEncoding)!
                formData.appendBodyPart(data: data, name: k)
            }
        }

        }) { (encodingResult) -> Void in
            switch encodingResult {
            case .Success(let upload, _, _):
                upload.responseJSON { (response) -> Void in
                    if response.result.isFailure {
                        print("网络响应错误 \(response.result.error)")
                    }
                    finished(result: response.result.value, error: response.result.error)
                }
                break
            case .Failure(let encodingError):
                print("编码错误 \(encodingError)")
            }
    }
}
```
