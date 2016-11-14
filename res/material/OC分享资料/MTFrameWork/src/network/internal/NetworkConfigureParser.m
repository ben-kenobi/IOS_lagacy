//
//  NetworkConfigureParser.m
//  MTimeMovie
//
//  Created by Lines on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NetworkConfigureParser.h"
#import "TBXML.h"
#import "MTConfigureEntity.h"
#import "MTFileManager.h"

@implementation NetworkConfigureParser

+ (NSDictionary *)parse:(NSString *)fileName {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    NSString *xml = nil;
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *filePath = [resourcePath stringByAppendingPathComponent:fileName];
    @try {
        xml = [[NSString alloc] initWithContentsOfFile:filePath
                                              encoding:NSUTF8StringEncoding
                                                 error:nil];
    }
    @catch (NSException *e) {
        NSLog(@"Exception: %@\n", e.name);
         NSLog(@"Exception: %@\n", e.reason);
    }

    if (nil == xml)
        return nil;
    
    // parse the file
    NSAutoreleasePool *pool = [NSAutoreleasePool new];
    TBXML *tbXML = [TBXML tbxmlWithXMLString:xml];
    TBXMLElement *entity = [TBXML childElementNamed:@"entity" parentElement:tbXML.rootXMLElement];
    while (nil != entity) {
        NSString *key = [TBXML valueOfAttributeNamed:@"id" forElement:entity];
        if (key == nil)
            continue;
        MTConfigureEntity *value = [MTConfigureEntity new];
        TBXMLElement * element = [TBXML childElementNamed:@"url" parentElement:entity];
        value.url = [TBXML textForElement:element];
        element = [TBXML childElementNamed:@"method" parentElement:entity];
        value.method = [TBXML textForElement:element];
        
        element = [TBXML childElementNamed:@"params" parentElement:entity];
        NSString *str = [TBXML textForElement:element];
        value.params = [str componentsSeparatedByString:@","];
        element = [TBXML childElementNamed:@"resultType" parentElement:entity];
        value.resultType = [TBXML textForElement:element];
        
        element = [TBXML childElementNamed:@"cacheTime" parentElement:entity];
        str = [TBXML textForElement:element];
        value.cacheSeconds = [str intValue];
        
        // add the value to dictionary
        [dic setObject:value forKey:key];
        [value release];
        entity = [TBXML nextSiblingNamed:@"entity" searchFromElement:entity];
    }
    [pool drain];
    // end of parse file
    
    [xml release];
    return [dic autorelease];
}

@end
