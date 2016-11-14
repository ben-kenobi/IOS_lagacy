
//
//  LibTestVC.m
//  day54-QRCodeNContactsNstaticlibs
//
//  Created by apple on 15/12/27.
//  Copyright © 2015年 yf. All rights reserved.
//

#import "LibTestVC.h"


#import "TestLib01.h"
#import "AVC.h"

#import "testframework.h"



@interface LibTestVC ()

@end

@implementation LibTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self staticlibTest];
    [self frameworkTest];
   
}


-(void)frameworkTest{
    [MyFWTest test];
}

-(void)staticlibTest{
    [[[TestLib01 alloc] init] test];
    [[[testlib alloc] init]test];
    [[[Util01 alloc] init]func01];
    [[[Util02 alloc] init]func02];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[[[testlib alloc] init] img]];
}



@end
