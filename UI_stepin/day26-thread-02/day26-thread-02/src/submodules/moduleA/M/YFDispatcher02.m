//
//  YFDispatcher02.m
//  day26-thread-02
//
//  Created by apple on 15/10/27.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFDispatcher02.h"

@implementation YFDispatcher02


+(instancetype)share{
    static YFDispatcher02 *dis=nil;
    static long l=0;
    dispatch_once(&l, ^{
        dis=[[YFDispatcher02 alloc] init];
    });
    return dis;
}
-(void)cancelOper:(NSString *)key{
    if(key)
        [self.opers removeObjectForKey:key];
}

-(void)asynDLImg:(NSString *)key onComp:(void (^)(UIImage *img))onComp def:(UIImage *)defimg{

    UIImage *img=[self.imgs objectForKey:key];
    if(!img){
        img=imgFromData4F([key strByAppendToCachePath]);
        if(img)
           [self.imgs setObject:img forKey:key];
    }
//    NSLog(@"%@",[key strByAppendToCachePath]);
    if(img){
        if(onComp)
            onComp(img);
        return ;
    }else{
        onComp(defimg);
    }
        
    if(!self.opers[key]){
        [self.opers setObject:@"" forKey:key];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [NSThread sleepForTimeInterval:1.5];
            UIImage *img=imgFromF(iRes(@"sound_Effect@2x.png"));
//            UIImage *img=img(key);
            if(img){
                [UIImagePNGRepresentation(img) writeToFile:[key strByAppendToCachePath] atomically:YES];
                [self.imgs setObject:img forKey:key];
            }
            dispatch_sync(dispatch_get_main_queue(), ^{
                if(onComp&&self.opers[key]){
                    onComp(img);
                    [self.opers removeObjectForKey:key];
                }
            });
            
        });
    }
    
    
}


- (void)cache:(NSCache *)cache willEvictObject:(id)obj{
    NSLog(@"%@",obj);
   
}

iLazy4Dict(opers, _opers)
-(NSCache *)imgs{
    if(!_imgs){
        _imgs=[[NSCache alloc] init];
        [_imgs setCountLimit:10];
        _imgs.delegate=self;
    }
    return _imgs;
}

@end
