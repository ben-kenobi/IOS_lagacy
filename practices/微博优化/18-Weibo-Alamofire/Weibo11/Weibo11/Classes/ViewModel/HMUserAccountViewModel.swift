//
//  HMUserAccountViewModel.swift
//  Weibo11
//
//  Created by itheima on 15/12/8.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

class HMUserAccountViewModel {

    // ViewModel 引用 Model (返过来不可以)
    var userAccount: HMUserAccount?
    
    // 归档与解档的路径
    var archivePath: String = (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last! as NSString).stringByAppendingPathComponent("useraccount.archive")
    
    // 是否登录
    var userLogon: Bool {
        return accessToken != nil
    }
    
    // 只读取属性
    // 返回当前用户的accessToken
    var accessToken: String? {
    
        // 从 userAccount 取出 accessToken
        // 如果没有 return nil
        // 如果取出来存在,还有得判断是否过期
        if let accessToken = userAccount?.access_token where !isExpires {
            // 判断是否过期
            return accessToken
        }
        return nil
    }
    
    // 返回 true 代表过期, false 没有过期
    // 写 getOnly 的原因是代表,我们判断的 accessToken 是否过期是根据当前时间变化计算出来的
    var isExpires: Bool {
        
        guard let expiresDate = userAccount?.expiresDate else {
            return true
        }
        
        // 通过过期时间计算出比过期时间少1的时间
//        let newDate = expiresDate.dateByAddingTimeInterval(0)
        
        // 当前时间与 expiresDate 进行对比
        // 如果当前时间 不大于 expiresDate 过期时间,是代表不过期:false
        if NSDate().compare(expiresDate) == NSComparisonResult.OrderedAscending {
            return false
        }
        return true
    }
    
    // 全局访问点
    static let sharedAccount: HMUserAccountViewModel = HMUserAccountViewModel()
    
    // 构造方法私有化,外界不能直接通过 类名() 初始化对象
    private init(){
        // 从归档里面解档
        userAccount = loadUserAccount()
    }
}


// MARK: - OAuth 登录请求
extension HMUserAccountViewModel {
    
    // MARK: - 获取 AccessToken 以及 获取用户的数据
    
    func loadAccessToken(code: String, complete:(isSuccessed: Bool)->()){
        
        HMNetworkTools.shareTools.loadAccessToken(code) { (response, error) -> () in
            if error != nil {
                printLog("请求错误:\(error)")
                complete(isSuccessed: false)
                return
            }
            
            // 在强转的时候,`!` 与 `?` 怎么选,只要看前面的数据是否是一个可选值
            guard let dict = response as? [String: AnyObject] else {
                printLog("返回数据不是字典")
                return
            }
            let account = HMUserAccount(dict: dict)
            
            self.userAccount = account
            
            self.loadUserInfo(account.uid!, accessToken: account.access_token!, complete: complete)
        }
        
        // 以下代码,提取到 HMNetworkTools里面
//        // 请求地址
//        let urlString = "https://api.weibo.com/oauth2/access_token"
//        // 请求参数
//        let params = [
//            "client_id": WB_APPKEY,
//            "client_secret": WB_APP_SECRET,
//            "grant_type": "authorization_code",
//            "code": code,
//            "redirect_uri": WB_REDIRECT_URI
//        ]
//        
//        // 发送请求
//        HMNetworkTools.shareTools.request(.POST, urlString: urlString, params: params, callback: { (response, error) -> () in
//            
//            if error != nil {
//                printLog("请求错误:\(error)")
//                complete(isSuccessed: false)
//                return
//            }
//            
//            // 在强转的时候,`!` 与 `?` 怎么选,只要看前面的数据是否是一个可选值
//            guard let dict = response as? [String: AnyObject] else {
//                printLog("返回数据不是字典")
//                return
//            }
//            let account = HMUserAccount(dict: dict)
//            
//            self.userAccount = account
//            
//            complete(isSuccessed: true)
//            
//            self.loadUserInfo(account.uid!, accessToken: account.access_token!, complete: complete)
//        })
    }
    
    /// 请求用户的数据
    ///
    private func loadUserInfo(uid: String, accessToken: String, complete:(isSuccessed: Bool)->()){
        
        HMNetworkTools.shareTools.loadUserInfo(uid, accessToken: accessToken) { (response, error) -> () in
            if error != nil {
                printLog("请求失败\(error)")
                complete(isSuccessed: false)
                return
            }
            printLog(response)

            // 在 if let 或者 guard let 里面 使用 as 都使用 ?
            guard let responseDic = response as? [String: AnyObject] else {
                printLog("返回数据不是一个字典")
                return
            }

            // 赋值用户的头像与昵称
            self.userAccount?.screen_name = responseDic["screen_name"] as? String
            self.userAccount?.avatar_large = responseDic["avatar_large"] as? String
            
            // 保存
            self.saveAccount(self.userAccount!)
            complete(isSuccessed: true)
        }
        
        // 下面的代码提取到 HMNetworkTools 里面
//        // 定义 url
//        let urlString = "https://api.weibo.com/2/users/show.json"
//        // 组织参数
//        let params = [
//            "access_token": accessToken,
//            "uid": uid
//        ]
//        // 发送请求
//        HMNetworkTools.shareTools.request(.GET, urlString: urlString, params: params) { (response, error) -> () in
//            
//            if error != nil {
//                printLog("请求失败\(error)")
//                complete(isSuccessed: false)
//                return
//            }
//            printLog(response)
//            
//            // 在 if let 或者 guard let 里面 使用 as 都使用 ?
//            guard let responseDic = response as? [String: AnyObject] else {
//                printLog("返回数据不是一个字典")
//                return
//            }
//            
//            // 赋值用户的头像与昵称
//            self.userAccount?.screen_name = responseDic["screen_name"] as? String
//            self.userAccount?.avatar_large = responseDic["avatar_large"] as? String
//            
//            // 保存
//            self.saveAccount(self.userAccount!)
//            complete(isSuccessed: true)
//        }
    }
    
}

// MARK: - 归档与解档当前对象
extension HMUserAccountViewModel {
    // 归档当前对象
    func saveAccount(account: HMUserAccount) {
        // 1. 获取路径
        // 因为与解档的路径一样,抽取
//        let file = (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last! as NSString).stringByAppendingPathComponent("useraccount.archive")
        
        printLog(archivePath)
        // 2. 归档
        NSKeyedArchiver.archiveRootObject(account, toFile: archivePath)
    }
    
    // 解档
    func loadUserAccount() -> HMUserAccount? {
        // 1. 获取路径
        // 2. 解档
        let result = NSKeyedUnarchiver.unarchiveObjectWithFile(archivePath) as? HMUserAccount
        return result
    }
}
