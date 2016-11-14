//
//  NetworkTools.m
//  02-RAC
//
//  Created by Romeo on 15/8/31.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "NetworkTools.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@protocol NetworkToolsProxy <NSObject>

@optional
// 复制粘贴了 AFN 的内部方法
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

@end

// 遵守协议，由 NetworkTools 实现 协议方法
// 但是，协议方法，AFN 已经实现好了
@interface NetworkTools() <NetworkToolsProxy>

@end

@implementation NetworkTools

+ (instancetype)sharedTools {
    static NetworkTools *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWithBaseURL:nil];
        
        // 设置反序列化数据格式
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    return instance;
}

// 只需要返回信号即可，不再需要定义 完成回调 的 block
- (RACSignal *)request:(RequestMethod)method URLString:(NSString *)URLString parameters:(id)parameters {
    
    // 根据 method 确定是 GET / POST
    NSString *methodName = (method == GET) ? @"GET" : @"POST";
    
    // 信号的返回值，是对信号销毁的处理，一般返回 nil即可
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        // 协议中定义了方法声明之后，此处就可以直接调用
        // OC 是消息机制！
        [[self dataTaskWithHTTPMethod:methodName URLString:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {

            // 发生事件后，通知订阅者消息
            [subscriber sendNext:responseObject];
            
            // 结束订阅 - 后续不再发布网络通知
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
            
            // 通知订阅者出现错误
            [subscriber sendError:error];
        }] resume];
        
        return nil;
    }];
}

@end
