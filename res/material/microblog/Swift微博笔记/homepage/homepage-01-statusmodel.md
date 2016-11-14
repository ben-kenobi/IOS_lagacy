# 微博数据模型

## 加载微博数据

* 在 `HMHomeTableViewController` 中添加加载微博数据方法

```swift
/// 加载微博数据的方法
private func loadData() {
    // 定义 url 与参数
    let urlString = "https://api.weibo.com/2/statuses/friends_timeline.json"
    let params = [
        "access_token": HMUserAccountViewModel.sharedUserAccount.accessToken!
    ]

    HMNetworkTools.shareTools.request(.GET, url: urlString, params: params) { (result, error) -> () in
        if error != nil {
            print("加载失败\(error)")
            return
        }
        print(result)
    }
}
```

* 执行方法加载微博数据

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    if !UserAccountViewModel.sharedUserAccount.userLogon {
        visitorView?.setupInfo(nil, message: "关注一些人，回这里看看有什么惊喜")
        return
    }
    loadData()
}
```

> 运行测试

## 定义微博模型

* 定义微博模型

```swift
/// 微博模型
class HMStatus: NSObject {

    // MARK: - 模型属性
    /// 创建时间
    var created_at: String?
    /// 微博ID
    var id: Int = 0
    /// 微博信息内容
    var text: String?
    /// 微博来源
    var source: String?

    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }

    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
}
```

* 将返回数据字典转模型

```swift
HMNetworkTools.shareTools.request(.GET, url: urlString, params: params) { (result, error) -> () in
    ...
    // 加载成功
    guard let statusesDict = result?["statuses"] as? [[String: AnyObject]] else {
        return
    }
    // 字典转模型

    // 定义临时数据
    var tempArray = [HMStatus]()
    for statusDict in statusesDict {
        let status = HMStatus(dict: statusDict)
        tempArray.append(status)
    }
}
```

* 定义微博列表视图模型 `HMStatusListViewModel`

```swift
/// 微博数组视图模型
class HMStatusListViewModel: NSObject {

    // 微博数组
    var statuses: [HMStatus]?
}
```

* 将加载数据的方法移动至 `HMStatusListViewModel`

```swift
/// 加载微博数据的方法
func loadData(completion: (isSuccessed: Bool)->()) {
    // 定义 url 与参数
    let urlString = "https://api.weibo.com/2/statuses/friends_timeline.json"
    let params = [
        "access_token": HMUserAccountViewModel.sharedUserAccount.accessToken!
    ]

    HMNetworkTools.shareTools.request(.GET, url: urlString, params: params) { (result, error) -> () in
        if error != nil {
            print("加载失败\(error)")
            completion(isSuccessed: false)
            return
        }
        // 加载成功
        guard let statusesDict = result?["statuses"] as? [[String: AnyObject]] else {
            return
        }
        // 字典转模型

        // 定义临时数据
        var tempArray = [HMStatus]()
        for statusDict in statusesDict {
            let status = HMStatus(dict: statusDict)
            tempArray.append(status)
        }
        self.statuses = tempArray
        completion(isSuccessed: true)
    }
}
```


* 在 `HMHomeTableViewController` 中增加微博视图模型属性

```swift
/// 微博列表视图模型
lazy var statusListViewModel = HMStatusListViewModel()
```

* 修改 `loadData` 函数

```swift
// MARK: - 加载数据
statusLiseViewModel.loadData { (isSuccessed) -> () in
    if isSuccessed {
        print("加载成功")
    }else {
        SVProgressHUD.showErrorWithStatus("网络不好")
    }
}
```

> 运行测试，印象：由视图模型负责数据处理

