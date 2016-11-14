//
//  HMWelcomeViewController.swift
//  Weibo11
//
//  Created by itheima on 15/12/8.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class HMWelcomeViewController: UIViewController {

    override func loadView() {
        view = bgImageView
        
        setupUI()
    }
    
    
    /// 设置视图
    private func setupUI(){
        // 添加控件
        view.addSubview(headImageView)
        view.addSubview(messageLabel)
        
        // 添加约束
        headImageView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(view.snp_centerX)
            make.top.equalTo(view.snp_top).offset(200)
            make.size.equalTo(CGSize(width: 90, height: 90))
        }
        
        messageLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(headImageView)
            make.top.equalTo(headImageView.snp_bottom).offset(15)
        }
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        // 先更改约束 
        headImageView.snp_updateConstraints { (make) -> Void in
            make.top.equalTo(view).offset(100)
        }
        
        
        // 执行动画
        // Damping: 阻尼 0-1 --> 阻尼越大,弹性效果越小
        // initialSpringVelocity: 执行弹性动画的初始速度
        
        messageLabel.alpha = 0
        
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: { () -> Void in
            // 如果界面需要重新布局,就去 layout
            self.view.layoutIfNeeded()
        }) { (_) -> Void in
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.messageLabel.alpha = 1
            }, completion: { (_) -> Void in
                // 跳转到首页
                // 发送一个切换根控制器的通知
                NSNotificationCenter.defaultCenter().postNotificationName(HMSwitchRootVCNotification, object: nil)
            })
        }
    }
    
    // MARK: - 懒加载控件
    private lazy var bgImageView: UIImageView = {
        let image = UIImage(named: "ad_background")
        return UIImageView(image: image)
    }()
    
    // 头像
    private lazy var headImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "avatar_default_big"))
        imageView.sd_setImageWithURL(NSURL(string: HMUserAccountViewModel.sharedAccount.userAccount!.avatar_large!)!, placeholderImage: UIImage(named: "avatar_default_big"))
        imageView.cornerRadius = 45
        return imageView
    }()
    
    
    // 欢迎回来的 label
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(18)
        label.textColor = UIColor.darkGrayColor()
        label.text = "欢迎回来"
        return label
    }()
    
}
