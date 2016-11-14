
//
//  YFWebVC.swift
//  day-43-microblog
//
//  Created by apple on 15/12/6.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit
//import SVProgressHUD

class YFWebVC: UIViewController ,UIWebViewDelegate{
    
    lazy var wv:UIWebView={
        let w=UIWebView(frame: CGRect(x: 0, y: 0, width: self.view.w(), height: self.view.h()))
        w.delegate=self
        return w
    }()
    
    
//    
//    func webViewDidStartLoad(webView: UIWebView){
//        SVProgressHUD.show()
//    }
//    func webViewDidFinishLoad(webView: UIWebView){
//        SVProgressHUD.dismiss()
//    }
//    func webView(webView: UIWebView, didFailLoadWithError error: NSError?){
//        SVProgressHUD.dismiss()
//    }
    
}
