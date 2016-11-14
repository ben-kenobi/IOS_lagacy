# Swift 网络框架

## Podfile

```
use_frameworks!
platform :ios, '8.0'
pod 'ReactiveCocoa'
pod 'AFNetworking'
```

## NetworkTools

* 单例

```swift
static let sharedTools: NetworkTools = {
    let instance = NetworkTools(baseURL: nil)

    // 设置反序列化数据类型
    instance.responseSerializer.acceptableContentTypes!.insert("text/html")

    return instance
}()
```

* 定义枚举类型

```swift

enum RequestMethod: String {
    case GET = "GET"
    case POST = "POST"
}
```

* 封装网络请求

```swift
/// 网络请求信号
///
/// - parameter method:    网络访问方法
/// - parameter urlString: urlString
/// - parameter params:    参数字典
///
/// - returns: RAC 信号
func request(method: RequestMethod, urlString: String, params: [String: AnyObject]?) -> RACSignal {

    return RACSignal.createSignal() {(subscriber) -> RACDisposable! in

        let successCallBack = { (task: NSURLSessionTask, result: AnyObject) -> Void in
            subscriber.sendNext(result)
            subscriber.sendCompleted()
        }
        let failureCallBack = { (task: NSURLSessionDataTask, error: NSError) -> Void in
            print(error)
            subscriber.sendError(error)
        }

        switch method {
        case .GET:
            self.GET(urlString, parameters: params, success: successCallBack, failure: failureCallBack)
        case .POST:
            self.POST(urlString, parameters: params, success: successCallBack, failure: failureCallBack)
        }

        return nil
    }
}
```
