# 加载授权页面

## 功能需求

* 通过浏览器访问新浪授权页面，获取授权码

### 接口文档

http://open.weibo.com/wiki/Oauth2/authorize

* 测试授权 URL

https://api.weibo.com/oauth2/authorize?client_id=931880914&redirect_uri=http://www.itheima.com/

> 注意：回调地址必须与注册应用程序保持一致

## 功能实现

### 准备工作

* 新建 `OAuth` 文件夹
* 新建 `HMOAuthViewController.swift` 继承自 `UIViewController`

#### 加载 OAuth 视图控制器

* 修改 `HMBaseTableViewController` 中用户登录部分代码

```swift
/// 用户登录
@objc private func visitorLoginViewWillLogin() {
    let nav = UINavigationController(rootViewController: HMOAuthViewController())

    presentViewController(nav, animated: true, completion: nil)
}
```

* 在 `OAuthViewController` 中添加以下代码

```swift
private var webView = UIWebView()

override func loadView() {
    view = webView

    title = "新浪微博"
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.Plain, target: self, action: "close")
}

/// 关闭
@objc private func close() {
    dismissViewControllerAnimated(true, completion: nil)
}
```

> 运行测试

### 加载授权页面

* 定义应用程序授权相关信息

```swift
// MARK: - 应用程序信息
private var WB_APPKEY = "931880914"
private var WB_APPSECRET = "80328e91fb58750daa48b8f12a243b4f"
private var WB_REDIRECTURI = "http://www.heima.com/"

/// OAuth授权地址
/// * see [http://open.weibo.com/wiki/Oauth2/authorize](http://open.weibo.com/wiki/Oauth2/authorize)
private var oauthUrl: NSURL {
    return NSURL(string: "https://api.weibo.com/oauth2/authorize?client_id=\(WB_APPKEY)&redirect_uri=\(WB_REDIRECTURI)")!
}
```

* 在 `info.plist` 中增加 `ATS` 设置

```xml
<key>NSAppTransportSecurity</key>
<dict>
	<key>NSAllowsArbitraryLoads</key>
	<true/>
</dict>
```

* 加载授权页面

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    webView.loadRequest(NSURLRequest(URL: oauthUrl))
}
```

### 自动填充

* 在 `viewDidLoad` 中添加`自动填充`按钮

```swift
navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", style: UIBarButtonItemStyle.Plain, target: self, action: "autoFill")
```

* 实现自动填充代码

```swift
    /// 自动填充账号与密码
@objc private func autoFill(){
    let jsString = "document.getElementById('userId').value='yohtr35601@163.com';document.getElementById('passwd').value='qw1987'"
    webView.stringByEvaluatingJavaScriptFromString(jsString)
}

```

* 实现代理方法，跟踪重定向 URL

```swift
// MARK: - UIWebView 代理方法
func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    print(request)

    return true
}
```

* 结果分析
    * 如果 URL 以回调地址开始，需要检查查询参数
    * 其他 URL 均加载

* 修改代码

```swift
func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {

    // 获取到url字符串
    let urlString = request.URL!.absoluteString

    // 如果不是以回调页开头，直接让WebView继承加载
    if !urlString.hasPrefix(WB_REDIRECTURI) {
        return true
    }

    // 判断是否包含 'code=' 字样
    if let query = request.URL?.query where query.containsString("code=") {
        // 截取授权码
        let code = query.substringFromIndex("code=".endIndex)
        print("请求码：\(code)")
    }else{
        // 用户点击了取消授权，直接关闭页面
        self.close()
    }

    return false
}
```

### 加载指示器

* 导入 `SVProgressHUD`

```swift
import SVProgressHUD
```

* WebView 代理方法

```swift
func webViewDidStartLoad(webView: UIWebView) {
    SVProgressHUD.show()
}

func webViewDidFinishLoad(webView: UIWebView) {
    SVProgressHUD.dismiss()
}
```

* 关闭

```swift
///  关闭
func close() {
    SVProgressHUD.dismiss()
    dismissViewControllerAnimated(true, completion: nil)
}
```
