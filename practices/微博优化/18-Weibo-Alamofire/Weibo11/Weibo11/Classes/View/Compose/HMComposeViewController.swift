//
//  HMComposeViewController.swift
//  Weibo11
//
//  Created by itheima on 15/12/12.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit
import SVProgressHUD

class HMComposeViewController: UIViewController {
    
    // toolBar 是否执行动画
    var isToolBarAnim: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        setupNav()
        view.backgroundColor = UIColor.whiteColor()
        
        // 添加子控件
        view.addSubview(textView)
        view.addSubview(toolBar)
        textView.addSubview(composePictureView)
        
        // 添加约束
        textView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(view).offset(UIEdgeInsetsZero)
        }
        
        // 添加约束
        toolBar.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(self.view)
            make.bottom.equalTo(self.view)
            make.height.equalTo(44)
        }
        
        // 因为能滚动,添加到 textView 身上
        // 宽度与高度一样
        // 中心x与 textView 一样
        composePictureView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(textView)
            make.width.equalTo(textView).offset(-20)
            make.height.equalTo(textView.snp_width).offset(-20)
            make.top.equalTo(textView).offset(100)
        }
        
        
        // 设置属性
        toolBar.childButtonClickClosure = { [weak self] (type: HMComposeToolBarButtonType) -> () in
            switch type {
            case .Picture:
                self?.selectedPicture()
            case .Mention:
                printLog("@")
            case .Trend:
                printLog("#")
            case .Emotion:
                // 切换键盘
                self?.switchKeyboard()
            case .Add:
                printLog("添加")
            }
        }
        
        // 通知监听键盘弹出
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "emoticonDidSelected:", name: HMEmoticonButtonDidSelectedNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "deleteBtnDidSelected", name: HMDeleteButtonDidSelectedNotification, object: nil)
    }
    
    /// 设置导航栏的内容
    private func setupNav(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", target: self, action: "back")
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sendButton)
        navigationItem.rightBarButtonItem?.enabled = false
        // 设置中间
        navigationItem.titleView = titleView
    }
    
    
    // MARK: - 监听事件
    
    @objc private func emoticonDidSelected(noti: NSNotification){
        let emoticon = noti.userInfo!["emoticon"]! as! HMEmoticon
        textView.insertEmoticon(emoticon)
    }
    
    @objc private func deleteBtnDidSelected(){
        // 执行键盘上删除按钮的逻辑
        textView.deleteBackward()
    }
    
    @objc private func back(){
        // 关闭键盘
        self.view.endEditing(true)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /// 发送按钮点击一事件
    @objc private func send(){
        
        // 怎么判断用户是发文字微博或者图片微博
        
        if composePictureView.images.count > 0 {
            upload()
        }else {
            // 发送文字微博
            update()
        }
    }
    /// 上传图片发送微博
    private func upload(){
        
        HMNetworkTools.shareTools.upload(HMUserAccountViewModel.sharedAccount.accessToken!, status: textView.text!, image: composePictureView.images.first!) { (response, error) -> () in
            if error != nil {
                printLog(error)
                SVProgressHUD.showErrorWithStatus("发送失败")
                return
            }
            SVProgressHUD.showSuccessWithStatus("发送成功")
        }
//        let url = "https://upload.api.weibo.com/2/statuses/upload.json"
//        let params = [
//            "access_token": HMUserAccountViewModel.sharedAccount.accessToken!,
//            "status": textView.text!
//        ]
//        
//        let manager = AFHTTPSessionManager()
//        // 发送 post 请求,拼装上传的数据
//        manager.POST(url, parameters: params, constructingBodyWithBlock: { (formData) -> Void in
//            
//            // 拼装上传数据
//            let data = UIImagePNGRepresentation(self.composePictureView.images.first!)!
//            
//            /**
//            参数:
//                - data: 要上传的二进制数据
//                - name: 接口里面对应的字段名
//                - fileName: 保存在服务器的文件名,可以随意传,因为后台会做相应处理
//                    - 取到上传的图片 --> 生成不同质量的图片,命名好放在不同的文件夹里面
//                - mimeType: 告诉后台当前我上传的文件的准确类型
//                    - image/jpeg --> 大类型/小类型
//                    - text/plian, text/html
//                    - 如果不知道准确类型: application/octet-stream
//
//            */
//            formData.appendPartWithFileData(data, name: "pic", fileName: "sss", mimeType: "image/png")
//            
//        }, success: { (_, response) -> Void in
//            printLog(response)
//            SVProgressHUD.showSuccessWithStatus("发表成功")
//        }) { (_, error) -> Void in
//            printLog(error)
//            SVProgressHUD.showErrorWithStatus("发表失败")
//        }
    }
    
    /// 发送文字微博
    private func update(){
        
        
        // 把 textView 身上的 attributedText 转成表情字符串
        HMNetworkTools.shareTools.update(HMUserAccountViewModel.sharedAccount.accessToken!, status: textView.emoticonText) { (response, error) -> () in
            if error != nil {
                printLog(error)
                SVProgressHUD.showErrorWithStatus("发送失败")
                return
            }
            SVProgressHUD.showSuccessWithStatus("发送成功")
        }
    }
    
    /// 键盘的 frame 高度改变的通知
    ///
    /// - parameter noti: 通知
    @objc private func keyboardWillChangeFrame(noti: NSNotification){
        
        // 如果  isToolBarAnim 为 true 才执行动画
        if !isToolBarAnim {
            return
        }

        // 取到键盘的结束位置
        let endRect = (noti.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        // 取到动画执行时间
        let duration = noti.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
        // 把 toolBar 的底部改成 endRect 里面y 里面
        toolBar.snp_updateConstraints { (make) -> Void in
            make.bottom.equalTo(self.view).offset(endRect.origin.y - self.view.height)
        }
        
        UIView.animateWithDuration(duration.doubleValue) { () -> Void in
            self.toolBar.layoutIfNeeded()
        }
    }
    
    
    // MARK: - 懒加载控件
    
    /// 发送按钮
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: "send", forControlEvents: UIControlEvents.TouchUpInside)
        
        // 设置不同状态的背景图
        button.setBackgroundImage(UIImage(named: "common_button_orange"), forState: UIControlState.Normal)
        button.setBackgroundImage(UIImage(named: "common_button_orange_highlighted"), forState: UIControlState.Highlighted)
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Disabled)
        
        // 如果把 button 放在 UIBarButtonItem 里面,其状态由 UIBarButtonItem 控制
        // button.enabled = false
        
        // 设置不同状态的文字颜色
        button.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Disabled)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        // 设置文字以及其大小
        button.setTitle("发送", forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(15)
        // 指定其大小
        button.size = CGSize(width: 45, height: 30)
        return button
    }()
    
    // navigationItem 的 titleView
    private lazy var titleView: UILabel = {
        let titleView = UILabel()
        if let name = HMUserAccountViewModel.sharedAccount.userAccount?.screen_name {
            // 设置多行显示
            titleView.numberOfLines = 0
            // 通过内容生成一个富文本对象
            let attrText = NSMutableAttributedString(string: "发微博\n\(name)")
            let range = (attrText.string as NSString).rangeOfString(name)
            
            //            let attrss = [
            //                NSStrokeWidthAttributeName: 2,
            //                NSStrokeColorAttributeName: UIColor.greenColor()
            //            ]
            //
            //            attrText.addAttributes(attrss, range: NSMakeRange(0, 3))
            
            // 设置对应位置的字体属性
            let attrs = [
                NSFontAttributeName: UIFont.systemFontOfSize(14),
                NSForegroundColorAttributeName: UIColor.grayColor()
            ]
            attrText.addAttributes(attrs, range: range)
            
            // 设置到 label上去
            titleView.attributedText = attrText
        }else {
            titleView.text = "发微博"
        }
        // 设置文字居中
        titleView.textAlignment = .Center
        // 适配内容大小
        titleView.sizeToFit()
        return titleView
    }()
    
    /// 文字输入框
    private lazy var textView: HMComposeTextView = {
        let textView = HMComposeTextView()
        textView.font = UIFont.systemFontOfSize(16)
        textView.placeholder = "听说下雨天音乐和辣条更配哟~"
        // 设置代理监听文字改变
        textView.delegate = self
        // 开启竖直方向的弹簧效果
        textView.alwaysBounceVertical = true
        return textView
    }()
    // toolBar
    private lazy var toolBar: HMComposeToolBar = HMComposeToolBar(frame: CGRectZero)
    
    // 初始化配图控件
    private lazy var composePictureView: HMComposePictureView = {
        let composePictureView = HMComposePictureView()
        // 添加图片要调用的闭包
        composePictureView.addImageClosure = { [weak self] in
            self?.selectedPicture()
        }
        composePictureView.backgroundColor = self.textView.backgroundColor
        return composePictureView
    }()
    
    // 表情键盘
    private lazy var emoticonKeyboard: HMEmoticonKeyboard = {
        let keyboard = HMEmoticonKeyboard()
        keyboard.frame = CGRect(x: 0, y: 0, width: SCREENW, height: 216)
        return keyboard
    }()
}

// MARK: - 处理toolBar 按钮点击
extension HMComposeViewController {
    
    // 选择图片
    private func selectedPicture(){
        // 弹出选择照片的控制器
        let pickerVC = UIImagePickerController()
        // 判断照相机是否可用
        // let result = UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary)
//        // 判断照相机前后摄像头是否可用
//        UIImagePickerController.isCameraDeviceAvailable(.Rear)
        // 是否允许编辑图片,默认不开启
        // pickerVC.allowsEditing = true
        pickerVC.delegate = self
        presentViewController(pickerVC, animated: true, completion: nil)
    }
    
    /// 切换键盘.系统键盘与表情键盘互相切换
    private func switchKeyboard(){
        
        // 把 isToolBarAnim 设置成 false
        isToolBarAnim = false
        
        // 1. 取消第 1 响应者 --> 退出键盘-> 响应通知,会调整 toolBar 的位置
        textView.resignFirstResponder()
        
        // 2. 切换键盘
        // 如果当前是系统键盘,执行此方法会切换到表情键盘,否则相反
        
        // 如果 inputView 为 nil 就代表是系统键盘
//        if textView.inputView == nil {
//            // 切换到表情键盘
//            textView.inputView = emoticonKeyboard
//        }else {
//            // 切换到系统的键盘
//            textView.inputView = nil
//        }
        textView.inputView = (textView.inputView == nil) ? emoticonKeyboard : nil
        // 如果 textView.inputView 不为 nil 就代表当前是表情键盘
        toolBar.isEmoticonKeyboard = (textView.inputView != nil)
        
        // 将 isToolBarAnim 设置成 true ,就代表 成为第一响应者 的时候,需要执行动画
        isToolBarAnim = true
        // 3. 成为第一响应者
        textView.becomeFirstResponder() //--> 弹出键盘-> 响应通知,会调整 toolBar 的位置
    }
}

// MARK: - 选择图片控制器的代理方法
extension HMComposeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        composePictureView.addImage(image.scaleToWidth(600))
        // 关闭控制器
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        printLog("点击取消了")
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}

// MARK: - UITextViewDelegate
extension HMComposeViewController: UITextViewDelegate {
    
    func textViewDidChange(textView: UITextView) {
        navigationItem.rightBarButtonItem?.enabled = textView.hasText()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}
