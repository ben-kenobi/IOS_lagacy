//
//  NetworkTarget.h
//  MTimeMovie
//
//  Created by Lines on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkTarget : NSObject

{
    id _target;
    SEL _dataReady;
    SEL _dataProcessing;
    SEL _dataFailed;
}
@property (nonatomic,assign) id  target;
@property (nonatomic,assign) SEL readySelector;
@property (nonatomic,assign) SEL processingSelector;
@property (nonatomic,assign) SEL failedSelector;

+ (NetworkTarget *) initWithTarget:(id)target;

@end
