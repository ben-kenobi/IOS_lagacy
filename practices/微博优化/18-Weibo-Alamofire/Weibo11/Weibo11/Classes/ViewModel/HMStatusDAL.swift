//
//  HMStatusDAL.swift
//  Weibo11
//
//  Created by itheima on 15/12/21.
//  Copyright © 2015年 itheima. All rights reserved.
//

import Foundation

// TODO: - 测试完成之后，恢复日期
/// 数据库最大缓存时间
private let kMaxDBCacheDateTime: NSTimeInterval = 60 //7 * 24 * 60 * 60

/// 目标：负责本地数据缓存以及网络数据加载
class HMStatusDAL {
    
    /// 清理数据缓存
    /**
        1. SQLite 数据库有一个特点，数据越多，文件越大
        2. 但是，如果删除了数据，文件不会变小，因为 SQLite 认为，既然数据库曾经有这么大，会再次这么大
            - 为了避免重复开销磁盘空间，删除数据，不会释放已经申请的磁盘空间！
        3. 不会把图片／音频／视频放在数据库中！
    
        问题：数据库已经很大，如何处理？
        处理方法：
        1. 程序启动的时候，不要 opendb 开启数据库
        2. 数据库的备份，改个名字
        3. 新建同名的数据库，创表
        4. 打开备份的数据库
        5. 编写 SQL，从备份数据库导入数据
        6. 删除备份数据！
    
        及时清理缓存很重要！测试的时候，观察数据库的成长速度！决定清除周期！
    
        问题：如果修改数据库字段！
        两个办法：
        1. 用 `ALTER` 指令，可以给一个表增加字段或者删除字段！
        2. 第二种方法，参照上面的步骤，慢慢搞！借力(找后台程序员帮忙！)
    */
    class func clearDBCache() {
        print(__FUNCTION__)
        
        // 准备时间字符串
        let date = NSDate(timeIntervalSinceNow: -kMaxDBCacheDateTime)
        
        // 转换日期格式
        let df = NSDateFormatter()
        df.locale = NSLocale(localeIdentifier: "en")
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateStr = df.stringFromDate(date)
        
        // sql
        // 提示：如果要删除数据的 SQL，先写 `SELECT *`，确认无误之后，再替换成 `DELETE`
        let sql = "DELETE FROM T_Status WHERE createTime < ?;"
        
        // 执行sql
        SQLiteManager.sharedManager.queue.inTransaction { (db, rollback) -> Void in
            if !db.executeUpdate(sql, dateStr) {
                rollback.memory = true
            } else {
                print("删除了 \(db.changes()) 条数据")
            }
        }
    }
    
    /// 加载微博数据
    class func loadStatus(sinceId: Int64, maxId: Int64, finished: (result: [[String: AnyObject]]?)->()) {
        
        // 1. 检查本地是否有缓存数据
        let result = checkCacheData(sinceId, maxId: maxId)
        
        // 2. 如果有，返回本地的缓存数据
        // 返回的结果，可能是一个没有内容的空数组，所以不能单纯判断nil
        if result?.count > 0 {
            
            // 返回本地数据库提取的字典数组
            finished(result: result)
            
            return
        }
        
        // 3. 如果没有，发起网络请求，加载网络数据
        HMNetworkTools.shareTools.loadStatus(HMUserAccountViewModel.sharedAccount.accessToken!,sinceId:sinceId, maxid: maxId) { (response, error) -> () in
            
            if error != nil {
                printLog("\(error)")
                // 加载失败
                finished(result: nil)
                return
            }
            
            // 执行到这一步,就代表数据请求回来了
            guard let result = response as? [String: AnyObject] else {
                printLog("返回的数据不是一个字典")
                finished(result: nil)
                return
            }
            
            // 一个字典数据
            guard let statusDicts = result["statuses"] as? [[String: AnyObject]] else {
                printLog("没有statuses")
                finished(result: nil)
                return
            }
            
            // 4. 将网络数据保存在本地
            HMStatusDAL.saveCacheData(statusDicts)
            
            // 5. 返回网络数据 - 通过回调返回
            finished(result: statusDicts)
        }
    }
    
    /// 目标：检查本地缓存数据
    class func checkCacheData(sinceId: Int64, maxId: Int64) -> [[String: AnyObject]]? {
        
        // 0. 获取 userId
        guard let userId = HMUserAccountViewModel.sharedAccount.userAccount?.uid else {
            print("用户没有登录")
            return nil
        }
        
        print("刷新数据 \(sinceId) - \(maxId)")
        
        // 1. 准备 SQL
        var sql = "SELECT statusId, status, userId FROM T_Status \n"
        sql += "WHERE userId = \(userId) \n"
        
        if sinceId > 0 {        // 下拉刷新
            sql += "    AND statusId > \(sinceId) \n"
        } else if maxId > 0 {   // 上拉刷新
            sql += "    AND statusId <= \(maxId) \n"
        }
        
        sql += "ORDER BY statusId DESC LIMIT 20;"
        
        // 2. 执行 SQL -> 如果检查到数据就返回字典数组，否则返回 nil
        guard let array = SQLiteManager.sharedManager.execRecordSet(sql) else {
            
            return nil
        }
        
        // 3. 遍历数组，将 `status` 转换成字典数组
        var arrayM = [[String: AnyObject]]()
        for dict in array {
            // 将 json 的 data 反序列化
            let jsonData = dict["status"] as! NSData
            
            let statusDict = try! NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
            
            // 添加到数组
            arrayM.append(statusDict as! [String : AnyObject])
        }
        
        return arrayM
    }
    
    /// 目标：保存网络返回的数据
    ///
    /**
        1. 明确方法目标
        2. 寻找切入点，尽快测试！
        3. 单独测试可运行的 `SQL`
        4. 粘贴 SQL - 根据 SQL 明确数据来源
        1>  如果 SQL 比较复杂，要 print 立即测试！
        5. 遍历数组，将数据保存到数据库
        6. 测试！！！
    */
    class func saveCacheData(array: [[String: AnyObject]]) {
        
        // 0. 获取 userId
        guard let userId = HMUserAccountViewModel.sharedAccount.userAccount?.uid else {
            print("用户没有登录")
            return
        }
        
        /**
            1. 准备 SQL
            statusId
            status - 将 array 中完整的字典进行`序列化`
            userId
        */
        var sql = "INSERT OR REPLACE INTO T_Status (statusId, status, userId) \n"
        sql += "VALUES (?, ?, ?);"
        
        // 2. 遍历数组
        SQLiteManager.sharedManager.queue.inTransaction { (db, rollback) -> Void in
            
            for dict in array {
                
                // 1> 拿到 statusId - 在做网络开发的时候，字典中保存的数值类型是 NSNumber 类型
                let statusId = dict["id"] as! NSNumber
                
                // 2> 将字典序列化成 json - 变成二进制数据
                let jsonData = try! NSJSONSerialization.dataWithJSONObject(dict, options: [])
                
                // 3> 保存到数据库
                db.executeUpdate(sql, statusId, jsonData, userId)
            }
        }
        
        print("保存了 \(array.count) 条数据")
    }
}