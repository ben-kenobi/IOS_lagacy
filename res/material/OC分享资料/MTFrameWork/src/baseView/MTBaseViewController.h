//
//  MTBaseViewController.h
//  IOSDemo
//
//  Created by Lines on 12-7-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+Message.h"

@interface MTBaseViewController : UIViewController {
    id _viewParameter;
    NSMutableArray *_callList; // the array to store all the selectors need to call sequently
}
@property (nonatomic, retain) id viewParameter;

- (void)createFields;
- (void)destroyFields;

- (void)createEvents;
- (void)destroyEvents;

- (void)createComponents;
- (void)destroyComponents;

- (void)createViews;
- (void)destroyViews;

- (void)loadData;

/**
 * Usage of Call Chain:
 * 1, add selectors into call chain by:
 * [self addSelectorToChain:@selector(YouSelector)];
 * 2, kick off the call chain after adding all:
 * [self startCallChain];
 * 3, in you call back function, call:
 * [self loadNext];
 * to load next selector in the call chain, if there is NO selector any more, nothing will do
 */
// add selector into call chain
// the call chain will be called one by one
- (void)addSelectorToChain:(SEL)selector;

// kick off the call chain execution
- (void)startCallChain;

// call next selector in the call chain
- (void)loadNext;

@end
