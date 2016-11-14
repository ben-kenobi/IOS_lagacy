//
//  HMOAuthViewController.swift
//  Weibo11
//
//  Created by itheima on 15/12/6.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit
import SVProgressHUD

// 添加一个 webview
// 打开登录页面


// 登录需要一个常量
let WB_APPKEY = "3863118655"
let WB_APP_SECRET = "b94c088ad2cdae8c3b9641852359d28c"
let WB_REDIRECT_URI = "http://www.baidu.com"


class HMOAuthViewController: UIViewController, UIWebViewDelegate {
    
    private lazy var webView = UIWebView()
    
    override func loadView() {
        webView.delegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        // 定义 url
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(WB_APPKEY)&redirect_uri=\(WB_REDIRECT_URI)"
        let url = NSURL(string: urlString)!
        
        // 定义 request
        let request = NSURLRequest(URL: url)
        
        webView.loadRequest(request)
    }
    
    private func setupUI(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", target: self, action: "dismiss")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", target: self, action: "autoFill")
        navigationItem.title = "微博登录"
    }
    
    // 原有请求 accessToken 和 请求个人信息的代码
    // 已抽取到 ViewModel 里面去
    
    // MARK: - 监听方法
    
    @objc private func dismiss(){
        SVProgressHUD.dismiss()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc private func autoFill(){
        printLog("autoFill")
        // 了解
        // xingzhong964375@163.com
        // yohtr35601@163.com
        // vgfjh15964@163.com
        let jsString = "document.getElementById('userId').value='daoge10000@sina.cn';document.getElementById('passwd').value='qqq123'"
        webView.stringByEvaluatingJavaScriptFromString(jsString)
    }
   
}

// MARK: - webview delegate
extension HMOAuthViewController {
    
    /// webview将要去加载某个 请求的时候,会调用这个方法,判断是否要加载
    ///
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        // 拦截回调页:如果是回调页,那么在回调地址里面截取 code,然后拿着 code 去获取 accessToken
        
        guard let url = request.URL?.absoluteString else {
            return true;
        }
        
        // 如果判断到不是以回调页开头,就放行让其去加载
        if !url.hasPrefix(WB_REDIRECT_URI) {
            return true
        }
        
        // 执行到这个地方地方,就代表,是回调页
        
        
        if request.URL!.query!.hasPrefix("code=") {
            // 获取 code
            printLog(request.URL!.query)
            
            // 截取授权 code
            let code = request.URL!.query!.substringFromIndex("code=".endIndex)
            
            // 获取 accessToken
            
            HMUserAccountViewModel.sharedAccount.loadAccessToken(code, complete: { (isSuccessed) -> () in
                if !isSuccessed {
                    printLog("加载失败")
                    SVProgressHUD.showErrorWithStatus("网络异常,登录失败")
                    return
                }
                // 加载成功
                printLog("登录成功")
                // 代表登录成功,
                
                SVProgressHUD.dismiss()
                
                // 1.关闭当前页面. 页面并不立即关闭,我们需要在直接关闭完页面之后再去切换界面
                self.dismissViewControllerAnimated(false, completion: { () -> Void in
                    // 2.跳到欢迎页
                    // 切换根控制器的逻辑,应该放在一起,一般放在 appdelegate 里面
                    NSNotificationCenter.defaultCenter().postNotificationName(HMSwitchRootVCNotification, object: self)
                })
            })
            
//            loadAccessToken(code)
        }else{
            printLog(request.URL)
            // 将当前页面,给干掉
            dismiss()
        }
        
        return false
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
}
