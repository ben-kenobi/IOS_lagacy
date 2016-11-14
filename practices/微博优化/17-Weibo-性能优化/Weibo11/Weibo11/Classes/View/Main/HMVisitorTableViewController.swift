//
//  HMVisitorTableViewController.swift
//  Weibo11
//
//  Created by itheima on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

class HMVisitorTableViewController: UITableViewController {
    
    // 用户是否登录的标记
    var userLogin = HMUserAccountViewModel.sharedAccount.accessToken != nil
    
    // 访客视图
    var visitorView: HMVisitorView?
    
    // 在这个方法里面判断如果用户没有登录,就不执行 super.loadView, view 让我们自己来定义
    override func loadView() {
        userLogin ? super.loadView() : setupVisitorView()
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    /// 设置访客模式所要显示的内容
    private func setupVisitorView(){
        visitorView = HMVisitorView()
//        visitorView?.delegate = self
        visitorView?.registerButton.addTarget(self, action: "login", forControlEvents: UIControlEvents.TouchUpInside)
        visitorView?.loginButton.addTarget(self, action: "login", forControlEvents: UIControlEvents.TouchUpInside)
        view = visitorView
        
        // 设置左边右边登录注册
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", target: self, action: "login")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", target: self, action: "login")
    }
    
    @objc private func login(){
        printLog("login")
        // 弹出一个登录的控制器
        let oauthVC = HMOAuthViewController()
        presentViewController(HMNavigationController(rootViewController: oauthVC), animated: true, completion: nil)
        
    }
    
    // MARK: - visitorDelegate
//    
//    func loginButtonDidSelected() {
//        login()
//    }
//    
//    func registerButtonDidSelected() {
//        login()
//    }
 }
