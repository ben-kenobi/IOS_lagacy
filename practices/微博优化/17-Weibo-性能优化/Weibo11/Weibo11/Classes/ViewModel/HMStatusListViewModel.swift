//
//  HMStatusListViewModel.swift
//  Weibo11
//
//  Created by itheima on 15/12/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit
import SDWebImage

class HMStatusListViewModel: NSObject {
    
    // 模型数据就封装到这个地方,控制器不需要关心 model 的存储
    // 装有模型的数组
    var statusList: [HMStatusViewModel]?
    
    /// 加载微博数据
    // 用于告诉外界,当前请求成功与失败信息
    /// <#Description#>
    ///
    /// - parameter isPullUp: 代表是否是上拉加载
    /// - parameter complete: 数据请求成功,把加载成功的信息回调给外界
    func loadData(isPullUp: Bool, complete: (isSuccess: Bool, count: Int)->()){
        
        // 上拉加载所需要的数据.如果 isPullUp 是ture,代表是上拉加载,就取当前数组最后一个元素的id传给服务器
        var maxId = isPullUp == true ? (statusList?.last?.status?.id ?? 0) : 0
        // 因为,其接口是返回比 maxId 小或等于max_id 的微博,为了避免重复数据,所以直接减1
        if maxId > 0 {
            maxId -= 1
        }
        // 下拉刷新用的 sinceId
        let sinceId = isPullUp == true ? 0 : (statusList?.first?.status?.id ?? 0)
        
        // 通过 StatusDAL 加载`数据`
        HMStatusDAL.loadStatus(sinceId, maxId: maxId) { (result) -> () in
            
            guard let statusDicts = result else {
                // 如果加载的数据不存在，直接返回
                complete(isSuccess: false, count: 0)
                return
            }
            
            // 应该把模型的计算，同样放到后台
            dispatch_async(dispatch_get_global_queue(0, 0), { () -> Void in
                
                var tempArray = [HMStatusViewModel]()
                
                // 遍历数组,转成模型，实现了内部的所有需要的计算，包括：行高和配图视图大小
                for value in statusDicts {
                    let status = HMStatus(dict: value)
                    tempArray.append(HMStatusViewModel(status: status))
                }
                
                printLog("加载回来的数量\(tempArray.count)")
                if self.statusList == nil {
                    self.statusList = [HMStatusViewModel]()
                }
                
                // 如果是上拉加载
                if isPullUp {
                    // 拼接到数组的后面
                    self.statusList = self.statusList! + tempArray
                } else {
                    // 拼接到数组的前面
                    self.statusList = tempArray + self.statusList!
                }
                
                self.cacheSingleWebImage(tempArray, complete: complete)
                
//                // 主线程回调
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    complete(isSuccess: true,count: tempArray.count)
//                })
            })
        }
    }
    
    /// 缓存`单张`网络图片
    /// 参数：本次网络请求获得的微博数组
    /// 提示：在实际开发中，一定要`确认`缓存图片的具体大小
    func cacheSingleWebImage(array: [HMStatusViewModel], complete: (isSuccess: Bool, count: Int)->()) {
        
        // 创建调度组
        let group = dispatch_group_create()
        var dataLength = 0
        
        // 遍历数组 － 获得`单张`图片的记录
        for vm in array {
            
            // 如果转发微博有配图，原创微博一定没有配图
            let urls = vm.status?.retweeted_status?.pic_urls ?? vm.status?.pic_urls
            
            // 判断是否是单张图片 - 不是单张图片继续循环
            if urls?.count != 1 {
                continue
            }
            
            let imageUrl = urls![0].picUrl!
            
            print(imageUrl)
            
            // 入组 － 监听紧随的 block
            dispatch_group_enter(group)
            
            // 使用 SDWebImage 异步缓存图片
            // 提示：如果本地已经缓存过图片，该图片仍然会通过回调传递
            // dataLength 比实际从网络下载缓存的图像大小要 `大`
            SDWebImageManager.sharedManager().downloadImageWithURL(imageUrl, options: [], progress: nil, completed: { (image, _, _, _, _) -> Void in
                
                // image 不一定有内容
                if let webImage = image, data = UIImagePNGRepresentation(webImage) {
                    
                    // 累加数据长度
                    dataLength += data.length
                    
                    // 让配图视图重新计算配图视图大小以及行高
                    vm.recalcPictureViewSize(image.size)
                }
                
                // 出组 － 在 block 的最后一句
                dispatch_group_leave(group)
            })
        }
        
        // 所有下载操作完成之后，更新 UI
        dispatch_group_notify(group, dispatch_get_main_queue()) { () -> Void in
            print("图像缓存完成 \(dataLength / 1024) K")
            
            // 主线程回调更新 UI
            complete(isSuccess: true,count: array.count)
        }
    }
}
