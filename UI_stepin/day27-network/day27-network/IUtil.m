//
//  IUtil.m
//  day27-network
//
//  Created by apple on 15/11/1.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "IUtil.h"

@implementation IUtil

+(void)broadcast:(NSString *)mes info:(NSDictionary *)info{
    [[NSNotificationCenter defaultCenter] postNotificationName:mes object:0 userInfo:info];
}
+(float)systemVersion{
    return  [[UIDevice currentDevice].systemVersion floatValue];
}



+(void)uploadFile:(NSString *)file name:(NSString *)name
         filename:(NSString *)filename toURL:(NSURL *)url callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback{
    NSString *boundary=@"--------------1234566";
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:15];
    
    req.HTTPMethod=@"POST";
    [req setValue:[@"multipart/form-data; boundary=" stringByAppendingString:boundary] forHTTPHeaderField:@"Content-Type"];
    req.HTTPBody=[self uploadBodyWithBoundary:boundary file:file name:name filename:filename];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(callback)
                callback(data,response,error);
        });
        
    }] resume];
}
+(NSData *)uploadBodyWithBoundary:(NSString *)boundary file:(NSString *)file  name:(NSString *)name filename:(NSString *)filename{
    NSMutableData *mdata=[NSMutableData dataWithData:[self segWithBoundary:boundary file:file name:name filename:filename]];
    [mdata appendData:[self segOfEndingWithBoundary:boundary]];
    return mdata;
    
}


//----multi--


+(void)multiUpload:(NSArray *)contents toURL:(NSURL *)url callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback{
    NSString *boundary=@"--------------1234566";
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:15];
    
    req.HTTPMethod=@"POST";
    [req setValue:[@"multipart/form-data; boundary=" stringByAppendingString:boundary] forHTTPHeaderField:@"Content-Type"];
    req.HTTPBody=[self multiUploadBodyWithBoundary:boundary contents:contents];
    [req.HTTPBody writeToFile:@"/Users/apple/Desktop/con.txt" atomically:YES];
    [[[NSURLSession sharedSession] dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(callback)
                callback(data,response,error);
        });
        
    }] resume];
}



+(NSData *)multiUploadBodyWithBoundary:(NSString *)boundary contents:(NSArray *)contents{
    NSMutableData *mdata=[NSMutableData data];
    for(int i=0;i<contents.count;i++){
        [mdata appendData:[self segWithBoundary:boundary dict:contents[i]]];
    }
    [mdata appendData:[self segOfEndingWithBoundary:boundary]];
    return mdata;
}


+(NSData *)segWithBoundary:(NSString *)boundary dict:(NSDictionary *)dict{
    if(dict[@"file"]){
        return [self segWithBoundary:boundary file:dict[@"file"] name:dict[@"name"] filename:dict[@"filename"]];
    }else{
        return [self segWithBoundary:boundary name:dict[@"name"] val:dict[@"value"]];
    }
}
+(NSData *)segOfEndingWithBoundary:(NSString *)boundary{
    return [[NSString stringWithFormat:@"\r\n--%@--",boundary ] dataUsingEncoding:4];
}

+(NSData *)segWithBoundary:(NSString *)boundary name:(NSString *)name val:(NSString *)val{
    return [NSData dataWithData:[[NSString stringWithFormat:@"\r\n--%@\r\nContent-Disposition: form-data; name=%@\r\n\r\n%@",boundary,name,val] dataUsingEncoding:4]];
    ;
}

+(NSData *)segWithBoundary:(NSString *)boundary file:(NSString *)file  name:(NSString *)name filename:(NSString *)filename{
    NSURLResponse *resp= [self synResponseByURL:[NSURL URLWithString:[NSString stringWithFormat:@"file://%@",file]]];
    if(!filename)
        filename=[resp suggestedFilename];
    NSMutableData *mdata=[NSMutableData dataWithData:[[NSString stringWithFormat:@"\r\n--%@\r\nContent-Disposition: form-data; name=%@; filename=%@\r\nContent-Type: %@\r\n\r\n",boundary,name,filename,resp.MIMEType] dataUsingEncoding:4]];
    ;
    
    [mdata appendData:[NSData dataWithContentsOfFile:file]];
    ;
    return mdata;
}


+(NSURLResponse *)synResponseByURL:(NSURL *)url{
    NSURLResponse *respon;
    [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:url] returningResponse:&respon error:0];
    return respon;
}

//----multi--
@end
