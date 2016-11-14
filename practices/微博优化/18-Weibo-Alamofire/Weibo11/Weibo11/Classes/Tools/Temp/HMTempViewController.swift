//
//  HMTempViewController.swift
//  Weibo11
//
//  Created by itheima on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

class HMTempViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = "当前是第\(navigationController?.childViewControllers.count ?? 0)级控制器"
        view.backgroundColor = UIColor.whiteColor()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "PUSH", target: self, action: "push")
        
        // 如果当前是第2级控制器
        // 左上角显示第1级控制器的title
        // 否则显示返回
        
        
    }
    
    @objc private func push(){
        let vc = HMTempViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
