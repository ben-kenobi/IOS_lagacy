//
//  NetworkConfigureParser.h
//  MTimeMovie
//
//  Created by Lines on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkConfigureParser : NSObject

+ (NSDictionary *)parse:(NSString *)fileName;

@end
