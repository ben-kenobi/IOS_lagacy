//
//  MTBaseViewController.m
//  IOSDemo
//
//  Created by Lines on 12-7-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MTBaseViewController.h"
#import "MTService.h"

@interface MTBaseViewController ()

@end

@implementation MTBaseViewController

@synthesize viewParameter = _viewParameter;

- (id) init {
    self = [super init];
    if (self) {
        _callList = [NSMutableArray new];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self loadData];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)dealloc {
    // Release any retained subviews of the main view.
    [self destroyEvents];
    [self destroyViews];
    [self destroyComponents];
    [MTService cancelRequestWithCaller:self];
    [self destroyFields];
    [_callList release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)loadView {
    [self createFields];
    [self createComponents];
    [self createViews];
    [self createEvents];
}

// initialize instance variables here
// called from loadView(), step 1
- (void)createFields {
    
}

// destroy instance variables here, which is created in createFields
// called from dealloc(), step 1
- (void)destroyFields {
    
}

// create components here,
// components means controller + view + self-event-dealing
// called from loadView(), step 2
- (void)createComponents {
    
}

// destroy the components created in createComponents()
// called viewDidUnload(), step 2
- (void)destroyComponents {
    
}

// create sub-view here
// sub-view means UIView without self-event dealing
// called from loadView(), step 3
- (void)createViews {
    
}

// destroy the subviews created in createViews()
// called viewDidUnload(), step 3
- (void)destroyViews {
    
}

// connect view's events or other events here
// called by loadView(), step 4
- (void)createEvents {
    
}

// disconnect view events or other events, connected by createEvents()
// called viewDidUnload(), step 1
- (void)destroyEvents {
    
}

// load web data, and assign it into views
- (void)loadData {
//    NetworkTarget *target = [NetworkTarget initWithTarget:self];
//    target.readySelector = @selector(getListSucceed:);
//    target.failedSelector = @selector(getListFailed);;
//    [MTService get:@"commovielist" withData:nil withTarget:target];
}


- (void)addSelectorToChain:(SEL)selector {
    NSString *str = NSStringFromSelector(selector);
    [_callList addObject:str];
}

// kick off the call chain execution
- (void)startCallChain {
    if ([_callList count] > 0)
        [self performSelectorInBackground:@selector(callChainThread) withObject:nil];
}

// call next selector in the call chain
- (void)loadNext {
    [self startCallChain];
}

- (void)callChainThread {
    if ([_callList count] <= 0)
        return;
    SEL selector = NSSelectorFromString([_callList objectAtIndex:0]);
    [self performSelector:selector];
    [_callList removeObjectAtIndex:0];
}

@end
