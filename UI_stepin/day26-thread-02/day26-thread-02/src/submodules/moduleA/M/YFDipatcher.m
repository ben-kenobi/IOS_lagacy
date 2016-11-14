//
//  YFDipatcher.m
//  day26-thread-02
//
//  Created by apple on 15/10/27.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFDipatcher.h"
#import "YFOper.h"

@implementation YFDipatcher

+(instancetype)share{
    static YFDipatcher *disp=nil;
    static long l=0;
    dispatch_once(&l, ^{
        disp=[[self alloc] init];
    });
    return disp;
}

-(void)cancelOper:(NSString *)key{
    [self.opers[key] cancel];
}
-(UIImage *)asynDLImg:(NSString *)key onComp:(void (^)(UIImage *img))onComp{

    UIImage *img=self.imgs[key];
    if(!img){
        img=imgFromData4F([key strByAppendToCachePath]);
        if(img)
           [self.imgs setObject:img forKey:key];
    }

//    NSLog(@"%@",[key strByAppendToCachePath]);
    if(img)
        return img;
    
    if(!self.opers[key]){
        YFOper *oper=[YFOper operWithAdr:key onComp:^(UIImage *img) {
            if(img){
                [self.imgs setObject:img forKey:key];
                [UIImagePNGRepresentation(img) writeToFile:[key strByAppendToCachePath] atomically:YES];
            }
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if(onComp&&![self.opers[key] isCancelled])
                    onComp(img);
                [self.opers removeObjectForKey:key];
            }];
            
        }];
        [self.opers setObject:oper forKey:key];
        [self.que addOperation:oper];
        
    }
    
    
    return self.defimg;
}

iLazy4Dict(imgs, _imgs)
iLazy4Dict(opers, _opers)
-(NSOperationQueue *)que{
    if(!_que){
        _que=[[NSOperationQueue  alloc] init];
    }
    return _que;
}
@end
