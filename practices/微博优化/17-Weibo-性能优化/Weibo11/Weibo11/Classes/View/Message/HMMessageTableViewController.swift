//
//  HMMessageTableViewController.swift
//  Weibo11
//
//  Created by itheima on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

class HMMessageTableViewController: HMVisitorTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 如果没有登录,就设置访客视图的内容
        if !userLogin {
            visitorView?.setVisitorInfo("visitordiscover_image_message", message: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知")
            return
        }
        
        setupUI()
    }
    
    private func setupUI(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "发现群", target: self, action: "discoverGroup")
    }
    
    @objc private func discoverGroup(){
        printLog("discoverGroup")
        
        let vc = HMTempViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}