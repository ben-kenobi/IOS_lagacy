//
//  LoginVC.swift
//  am
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
import SSZipArchive

class LoginVC: BaseVC {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let title1 = UILabel(frame: nil, txt: "辅助决策系统", color: iColor(0xffffffff), font: iFont(33), align: NSTextAlignment.Center, line: 1, bgColor: iColor(0x00000000))
        view.addSubview(title1)
        title1.snp_makeConstraints { (make) in
            make.centerX.equalTo(0)
            make.top.equalTo(60)
        }
        let title2 = UILabel(frame: nil, txt: "基于移动端", color: iColor(0xffffffff), font: iFont(18), align: NSTextAlignment.Center, line: 1, bgColor: iColor(0x00000000))
        
        view.addSubview(title2)
        title2.snp_makeConstraints { (make) in
            make.centerX.equalTo(0)
            make.top.equalTo(title1.snp_bottom).offset(2)
        }
        let logo = UIImageView(frame: nil, img: iimg("login_logo"))
        view.addSubview(logo)
        logo.snp_makeConstraints { (make) in
            make.top.equalTo(title2.snp_bottom).offset(-15)
            make.centerX.equalTo(0)
            make.width.height.equalTo(260)
        }
        
        
        view.layer.contents=iimg("bg")?.CGImage
        view.addSubview(bottomView)
        bottomView.snp_makeConstraints { (make) in
            make.right.left.equalTo(0)
            make.bottom.equalTo(view)
            make.top.equalTo(0)
        }
        bottomView.addSubview(btn)
        let v:View = View()
        bottomView.addSubview(v)
        bottomView.addSubview(retrievePwd)
        bottomView.addSubview(emerLog)
        v.backgroundColor=iColor(0xffffffff)
        v.layer.cornerRadius=8
        v.layer.masksToBounds=true
        
        v.addSubview(username)
        v.addSubview(pwd)
        let divider:View = View()
        v.addSubview(divider)
        divider.backgroundColor=iColor(0xffaaaaaaaa)
        divider.snp_makeConstraints { (make) in
            make.centerY.equalTo(0)
            make.height.equalTo(0.5)
            make.width.equalTo(v)
            make.left.equalTo(0)
        }
        v.snp_makeConstraints { (make) in
            make.bottom.equalTo(btn.snp_top).offset(-20)
            make.width.equalTo(bottomView).multipliedBy(0.8)
            make.centerX.equalTo(0)
        }
        
        username.snp_makeConstraints { (make) in
            make.top.equalTo(0)
            make.centerX.equalTo(0)
            make.height.equalTo(44)
            make.width.equalTo(v)
        }
        username.becomeFirstResponder()
        
        pwd.snp_makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.centerX.equalTo(0)
            make.height.equalTo(44)
            make.width.equalTo(v)
            make.top.equalTo(username.snp_bottom)
            
        }
        btn.snp_makeConstraints { (make) in
            make.top.equalTo(bottomView.snp_bottom).multipliedBy(0.8)
            make.centerX.equalTo(0)
            make.height.equalTo(48)
            make.width.equalTo(bottomView.snp_width).multipliedBy(0.8)
            
        }
        emerLog.snp_makeConstraints { (make) in
            make.right.equalTo(bottomView.snp_right).multipliedBy(0.9)
            make.height.equalTo(33)
            make.width.equalTo(120)
            make.bottom.equalTo(-35)
        }
        retrievePwd.snp_makeConstraints { (make) in
            make.left.equalTo(bottomView.snp_right).multipliedBy(0.1)
            make.height.width.bottom.equalTo(emerLog)
            
        }
        
        view.addSubview(setting)
        
        
        
        btn.setTitle("登录", forState: UIControlState.Normal)
        btn.setTitleColor(iColor(0xff66aaf8), forState: .Normal)
        username.placeholder="用户名"
        pwd.placeholder="密码"
        
        username.text=PrefUtil.getUsername()
        pwd.text=PrefUtil.getPwd()
        iNotiCenter.addObserver(self, selector: #selector(self.onKeyboardChange(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
        
        
    }
    var setCheckNum:Int = 0
    
    lazy var bottomView:View={
        let view = View()
        return view
    }()
    
    lazy var pwd:ClearableTF = {
        let pwd = ClearableTF(frame: nil, bg: iColor(255, 255, 255, 0.3), corner: 0)
        pwd.leftView=View(frame: CGRectMake(0, 0, 12, 0))
        pwd.leftViewMode = UITextFieldViewMode.Always
        pwd.secureTextEntry=true
        pwd.returnKeyType=UIReturnKeyType.Go
        pwd.delegate=self
        return pwd
        
    }()
    lazy var username:ClearableTF = {
        let pwd = ClearableTF(frame: nil, bg: iColor(255, 255, 255, 0.3), corner: 0)
        pwd.leftView=View(frame: CGRectMake(0, 0, 12, 0))
        pwd.leftViewMode = UITextFieldViewMode.Always
        pwd.returnKeyType=UIReturnKeyType.Go
        pwd.delegate=self
        return pwd
        
    }()
    lazy var btn:UIButton = {
        
        let btn = UIButton(frame: nil,bgimg: iimg(iColor(255, 255, 255, 1)), hlbgimg: iimg(iColor(200,200,200,0.2)), tar: self,action:#selector(self.onClick(_:)))
        btn.layer.cornerRadius=8
        btn.layer.masksToBounds=true
        
        return btn
    }()
    lazy var retrievePwd:UIButton = {
        
        let btn = UIButton(frame: nil, img: iimg("retrieve"), title: "找回密码", font: iFont(15), titleColor: iColor(0xffffffff), titleHlColor: iColor(0xffaaaaaaaa),  tar: self, action: #selector(self.onClick(_:)), tag: 0)
        
        btn.imageView?.snp_makeConstraints(closure: { (make) in
            make.left.top.height.equalTo(btn)
            make.width.equalTo(btn.snp_height)
        })
        btn.imageView?.contentMode=UIViewContentMode.ScaleAspectFit
        btn.titleEdgeInsets=UIEdgeInsetsMake(0, -15, 0, 15)
        
        return btn
    }()
    lazy var emerLog:UIButton = {
        
        let btn = EmerBtn(frame: nil, img: iimg("emergency"), title: "紧急登录", font: ibFont(15), titleColor: iColor(0xffee5555), titleHlColor: iColor(0xffaaaaaa),  hlbgimg:iimg(iColor(0xffaaaaaaaa)),bgcolor:iColor(0xffee5555), corner: 6, bordercolor: iColor(0xffffffff), borderW: 1, tar: self, action: #selector(self.onClick(_:)), tag: 0)
        btn.titleLabel?.backgroundColor=iColor(0xffffffff)
        btn.titleLabel?.textAlignment = .Center
        btn.imageView?.contentMode=UIViewContentMode.ScaleAspectFit
        btn.imageView?.snp_removeConstraints()
        btn.titleLabel?.snp_removeConstraints()
        
        //        btn.imageView?.snp_remakeConstraints(closure: { (make) in
        //            make.centerY.equalTo(0)
        //            make.left.equalTo(7)
        //            make.width.height.equalTo(20)
        //        })
        //        btn.titleLabel?.snp_remakeConstraints(closure: { (make) in
        //            make.top.bottom.right.equalTo(0)
        //            make.left.equalTo(36)
        //        })
        return btn
    }()
    lazy var setting:UIButton = {
        
        let btn = UIButton(frame:CGRectMake(0, 0, 70, 70))
        btn.backgroundColor=iColor(0x00ffffff)
        btn.addTarget(self, action: #selector(self.onClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
    
    lazy var usernames:[(String,String)] = {
        return PrefUtil.getUsers()
    }()
    
    deinit{
        iNotiCenter.removeObserver(self)
    }
    
    func  DLFrom(url:String,delegate:NSURLSessionDownloadDelegate){
        iPop.showProg()

        let session = NSURLSession(configuration:         NSURLSessionConfiguration.defaultSessionConfiguration()
            , delegate: delegate, delegateQueue: NSOperationQueue())
        session.downloadTaskWithRequest(NSURLRequest(URL: iUrl(url)!, cachePolicy: .ReloadIgnoringLocalCacheData, timeoutInterval: 15)).resume()
        
    }
    
    
    
    
}


extension LoginVC:UITextFieldDelegate,NSURLSessionDownloadDelegate{
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        onClick(btn)
        
        return true
    }
    
    
    func onClick(sender:View){
        if (sender == btn) {
            login()
        }else if(sender == retrievePwd ){
            doretrievePwd()
        }else if(sender == emerLog){
            doemerLog()
        }else if(sender == setting){
            dosetting()
        }else if(sender.isKindOfClass(UITextField.self)){
            let tf = sender as! UITextField
            tf.text=iConst.defServerIp
        }
    }
    
    
    func dosetting(){
        
        setCheckNum += 1
        if (setCheckNum >= 5) {
            setCheckNum = 0
            var tfo:UITextField? = nil
            let ac = UIAlertController(title: "noti", message: "", preferredStyle: .Alert)
            
            ac.addAction(UIAlertAction(title: "取消", style: .Cancel, handler: nil))
            
            ac.addAction(UIAlertAction(title: "确定", style: .Default, handler: { (aa) in
                NetUtil.setServerIP(tfo?.text ?? "")
            }))
            ac.addTextFieldWithConfigurationHandler({ (tf) in
                tf.placeholder="输入要设置的ip:port"
                tfo=tf
                tf.text=NetUtil.serverIP()
                tf.addTarget(self, action: #selector(self.onClick(_:)), forControlEvents: UIControlEvents.TouchDragExit)
            })
            ac.view.setNeedsLayout()
            
            presentViewController(ac, animated: true, completion: nil)
        }
    }
    func doretrievePwd(){
        
        let vc = MainNavVC(rootViewController: RetrievePwdVC())
        presentViewController(vc, animated: true, completion: nil)
        
    }
    func doemerLog(){
        let pwdtext = pwd.text ?? ""
        let usernametext = username.text ?? ""
        if(isBlank(usernametext)){
            iPop.toast("请输入用户名")
            username.becomeFirstResponder()
            return
        }
        if (isBlank(pwdtext) ){
            iPop.toast("请输入密码")
            pwd.becomeFirstResponder()
            return
        }
        
        //-----
        
        
//        UserInfo.me.NAME=usernametext
//        PrefUtil.saveUser(usernametext, pwd: pwdtext)
//        UserInfo.loginWithDict(PrefUtil.getUserInfoByUser())
        
        //-------
        for (name,pwd) in usernames{
            if usernametext == name && pwd == pwdtext{
                UserInfo.me.NAME=usernametext
                PrefUtil.saveUser(usernametext, pwd: pwdtext)
                UserInfo.loginWithDict(PrefUtil.getUserInfoByUser())
                updateRVC()
                return ;
            }
        }
  
        iPop.toast("用户名密码不匹配")
    }
    
    
    
    func login(){
        
        let pwdtext = pwd.text ?? ""
        let usernametext = username.text ?? ""
        if(isBlank(usernametext)){
            iPop.toast("请输入用户名")
            username.becomeFirstResponder()
            return
        }
        if (isBlank(pwdtext) ){
            iPop.toast("请输入密码")
            pwd.becomeFirstResponder()
            return
        }
        
        
        
        let path = iConst.loginUrl + "?name=" + username.text! + "&pwd=" + pwd.text!
        NetUtil.commonRequestJson(true, path: path, para: nil, succode: ["200"],cb:{ (data, idx) in
            
            if let userinfomap = data["data"] as? [String:AnyObject]{
                UserInfo.loginWithDict(userinfomap)
                PrefUtil.saveUser(self.username.text!, pwd: self.pwd.text!)
                PrefUtil.putUserInfoByUser(userinfomap)
                updateRVC()
                UserInfo.pushChannelId()
            }
      
        })
    }
    
    

    
    
    func onKeyboardChange(noti:NSNotification){
        if let userinfo = noti.userInfo{
            let dura=Double((userinfo[UIKeyboardAnimationDurationUserInfoKey] as? String) ??
            "0")
            
            
            let endframe:CGRect = (userinfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
            UIView.animateWithDuration(dura!, animations: { 
                self.bottomView.transform=CGAffineTransformMakeTranslation(0, endframe.origin.y-self.view.h)
            })
            

        }
   
    }

    
    override func viewWillAppear(animated: Bool) {
        let name = "eqAppData.zip"
        super.viewWillAppear(animated)
        if iFm.fileExistsAtPath(name.strByAp2Doc()){
            if UserInfo.shouldAutoLogin(){
                login();
            }
        }else{
            var url = NetUtil.fullUrl(name)
            print(url)
//            url = "http://192.168.200.118/\(name)"
//            print(url)
            DLFrom(url, delegate: self)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        pwd.resignFirstResponder()
        view.endEditing(true)
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL){
        let name = (downloadTask.currentRequest!.URL!.absoluteString! as NSString).lastPathComponent
        
        try! iFm.copyItemAtURL(location, toURL: NSURL(fileURLWithPath: name.strByAp2Doc()))
        SSZipArchive.unzipFileAtPath(name.strByAp2Doc(), toDestination: "".strByAp2Doc())
        dispatch_async(dispatch_get_main_queue()) { 
            iPop.dismProg()

        }
        
    }
    
    
}


class EmerBtn:UIButton{
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        return CGRectMake(7, (contentRect.maxY-20)/2, 20, 20)
    }
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        return CGRectMake(34, 0, (contentRect.maxX-34), contentRect.maxY)
    }
}
    
