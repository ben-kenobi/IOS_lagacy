//
//  HMDiscoverSearchView.swift
//  Weibo11
//
//  Created by itheima on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

class HMDiscoverSearchView: UIView, UITextFieldDelegate {
    
//    @IBInspectable var cornerRadius: CGFloat{
//        get{
//            return textfield.layer.cornerRadius
//        }
//        
//        set{
//            textfield.layer.cornerRadius = newValue
//            textfield.layer.masksToBounds = true
//        }
//    }

    @IBOutlet weak var textFieldRightCons: NSLayoutConstraint!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var textfield: UITextField!
    
    
    
    
    // 从xib里面加载 View
    class func searchView () -> HMDiscoverSearchView {
        
        return NSBundle.mainBundle().loadNibNamed("HMDiscoverSearchView", owner: nil, options: nil).last! as! HMDiscoverSearchView
        
    }
    
    
    // 与代码创建控件有关
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // xib 里面将线与控件连好之后会调用这个方法
    override func awakeFromNib() {
        
        let leftView =  UIImageView(image: UIImage(named: "searchbar_textfield_search_icon"))
        leftView.frame = CGRectMake(0, 0, frame.height, frame.height)
        // 设置内容显示模式
        leftView.contentMode = .Center
        // 设置leftView
        textfield.leftView = leftView
        // 指定其显示模式
        textfield.leftViewMode = UITextFieldViewMode.Always
        
        
//        textfield.layer.cornerRadius = 5
//        textfield.layer.borderColor = UIColor.redColor().CGColor
//        textfield.layer.borderWidth = 3
    }
    
    // 可以通过代码往当前控件添加子控件
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
   
    
    // 取消按钮点击
    @IBAction func cancelButtonClick(sender: UIButton) {
        
        // 1. 让 textfiled 取消第一响应者
        textfield.resignFirstResponder()
        // 第二种方式
        // self.endEditing(ture)
        
        // 2. 执行动画
        // 要执行约束的动画,
        self.textFieldRightCons.constant = 0
        UIView.animateWithDuration(0.25) { () -> Void in
            // 把执行动画的代码放进去
            self.textfield.layoutIfNeeded()
        }
    }
    
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        // 要执行约束的动画,
        self.textFieldRightCons.constant = self.cancelButton.frame.width
        
        UIView.animateWithDuration(0.25) { () -> Void in
            // 把执行动画的代码放进去
            self.textfield.layoutIfNeeded()
        }
    }

}
