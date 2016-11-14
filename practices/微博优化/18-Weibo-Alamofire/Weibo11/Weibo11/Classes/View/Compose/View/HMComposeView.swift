 //
//  HMComposeView.swift
//  Weibo11
//
//  Created by itheima on 15/12/12.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit
import pop

class HMComposeView: UIView {
    
    
    var target: UIViewController?
    
    private lazy var buttons: [HMComposeMenuButton] = [HMComposeMenuButton]()
    
    // 内部所有按钮显示的信息
    private var composeButtonInfos: [HMComposeButtonInfo]?
    
    // MARK: - 设置界面

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        width = SCREENW
        height = SCREENH
        
        setupUI()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(){
        // 添加子控件
        addSubview(bgImageView)
        addSubview(sloganImageView)
        
        // 添加约束
        bgImageView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self).offset(UIEdgeInsetsZero)
        }
        sloganImageView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(100)
        }
        
        
        // 添加 6 个子按钮
        addChildButton()
        
    }
    
    /// 添加6个子控件
    private func addChildButton(){
        
        // 定义按钮的宽高
        let childW: CGFloat = 80
        let childH: CGFloat = 110
        // 计算每一个按钮之间的间距
        let childMargin: CGFloat = (SCREENW - 3 * childW) / 4
        
        composeButtonInfos = getComposeButtonInfos()
        
        for (i,value) in composeButtonInfos!.enumerate() {
            // 初始化 button
            let button = HMComposeMenuButton()
            // 添加点击事件
            button.addTarget(self, action: "composeButtonClick:", forControlEvents: .TouchUpInside)
            
            let icon = value.icon!
            let title = value.title!
            
            // 指定显示的内容
            button.setImage(UIImage(named: icon), forState: UIControlState.Normal)
            button.setTitle(title, forState: UIControlState.Normal)
            
            
            // 设置 button的 tag,以便确定是哪一个按钮点击了,根据不同的按钮读取对应位置的信息,初始化控制器
            button.tag = i
            // 指定大小
            button.size = CGSize(width: childW, height: childH)
            
            // 求出当前遍历添加的按钮是在第几行第几列
            let col = i % 3
            let row = i / 3
            
            button.x = CGFloat(col+1)*childMargin + CGFloat(col)*childW
            button.y = CGFloat(row) * (childMargin + childH) + SCREENH
            
            addSubview(button)
            buttons.append(button)
        }
        
    }
    
    /// 获取按钮信息
    private func getComposeButtonInfos() -> [HMComposeButtonInfo] {
        // 读取文件路径
        let file = NSBundle.mainBundle().pathForResource("compose.plist", ofType: nil)!
        // 转成数组
        let composeButtonInfos = NSArray(contentsOfFile: file)!
        // 定义返回值
        var result = [HMComposeButtonInfo]()
        // 遍历字典转模型
        for value in composeButtonInfos {
            result.append(HMComposeButtonInfo(dict: value as! [String : AnyObject]))
        }
        // 设置返回值
        return result
    }
    
    /// 执行动画
    ///
    /// - parameter button: 执行动画的元素
    /// - parameter isUp:   是否是上升
    /// - parameter index:  当前 button 的位置
    private func anim(button: UIButton,isUp: Bool = true, index: Int){
        // 执行动画
        let anim = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        // 设置终点的位置
        let y: CGFloat = isUp ? button.center.y - 350 : button.center.y + 350
        
        anim.toValue = NSValue(CGPoint: CGPoint(x: button.center.x, y: y))
        // 弹性度 越大,抖动幅度越大
        anim.springBounciness = 8
        // 弹性速度
        anim.springSpeed = 10
        anim.beginTime = CACurrentMediaTime() + Double(index) * 0.025
        button.pop_addAnimation(anim, forKey: nil)

    }
    
    // MARK: - 外界访问方法
    /// 外界调用此方法将控件显示到屏幕上
    func show(target: UIViewController?){
        self.target = target
        // 将其添加到 window 上
//        let window = UIApplication.sharedApplication().windows.last
        // 添加控件到 mainViewController 里面.弹出的控制器,就可以在 当前View的上面弹出
        target?.view?.addSubview(self)
        
        // 执行显示的动画
        // 遍历 button 数组
        for (i,value) in buttons.enumerate() {
            anim(value, index: i)
        }
    }
    

    // MARK: - 监听方法
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        removeFromSuperview()
        // 执行显示的动画
        // 遍历 button 数组
        for (i,value) in buttons.reverse().enumerate() {
            anim(value, isUp: false, index: i)
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(0.3 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
            self.removeFromSuperview()
        })
    }
    
    /// 子按钮点击执行的方法
    ///
    /// - parameter button: <#button description#>
    @objc private func composeButtonClick(button: UIButton){
        
        // 遍历执行动画
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            for value in self.buttons {
                value.alpha = 0.2
                if value == button {
                    // 是当前的按钮,
                    // 执行放大透明
                    value.transform = CGAffineTransformMakeScale(2, 2)
                }else{
                    // 执行缩小透明
                    value.transform = CGAffineTransformMakeScale(0.3, 0.3)
                }
            }
            
        }) { (_) -> Void in
//            UIView.animateWithDuration(0.25, animations: { () -> Void in
//                for value in self.buttons {
//                    value.alpha = 1
//                    value.transform = CGAffineTransformIdentity
//                }
//            })
            
            // 1. 给按钮设置不同的 tag,根据 tag 值去判断到底要打开哪个控制器
            
            // 2. 以配置文件的形式将类名读取出来,初始化并弹出
            
            
            let info = self.composeButtonInfos![button.tag]
            
            if let name = info.classname {
                let cls = NSClassFromString(name) as? UIViewController.Type
                let result = cls?.init()
                // 弹
                self.target?.presentViewController(HMNavigationController(rootViewController: result!), animated: true, completion: { () -> Void in
                    self.removeFromSuperview()
                })
            }
        }
    }
    
    
    // MARK: - 懒加载
    
    private lazy var bgImageView: UIImageView = UIImageView(image: UIImage.screentShot().applyLightEffect())
    
    // 宣传语的图片
    private lazy var sloganImageView: UIImageView = UIImageView(image: UIImage(named: "compose_slogan"))
}
