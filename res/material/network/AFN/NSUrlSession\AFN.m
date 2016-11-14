/*------------------------------------- 01  NSURLSession ---------------------------------------*/
重点:1.NSURLSession的使用 2.熟练掌握 NSURLSession
{
    <1> NSURLSession 简介:
    {
        NSURLSession 是 iOS 7.0 之后推出的网络解决方案!用于替代 NSURLConnection,  针对下载/上传等复杂的网络操作提供了专门的解决方案!
    
        NSURLSession 使用更加简单/方便!
    
    }
    <2> NSURLSession 中新增的内容:
    {
        1> 全局的 NSURLSession 对象: 所有的网络会话都由一个 NSURLSession 对象发起, 实例化一个 NSURLSession 对象有两种方法:
            {
                *1 对于简单的,不需要监听网络请求过程的网络会话来说,使用系统提供的,全局的 NSURLSession 单利对象:
            
                NSURLSession *session = [NSURLSession sharedSession];
            
                *2 如果需要监听网络进度,需要自定义一个 NSURLSession 对象,并且设置代理!这时还需要一个 NSURLSessionConfiguration,可以设置全局的网络访问属性.
            
                NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration defaultSessionConfiguration];
            
                NSURLSession *session = [NSURLSession sessionWithConfiguration:cfg delegate:self delegateQueue:[NSOperationQueue mainQueue]];
            }
        2> 网络任务(Task);在 NSURLSession 中,有三种网络任务类型.
            {
                *1 用于非文件下载的普通的 GET/POST请求 NSURLSessionDataTask.实例化对象有以下2种方法:
                {
                    // 1> 通过一个 request 实例化普通网络任务,增加完成之后的 block 回调,使用比较多.
                    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                        
                    }];
                
                    // 2> 通过一个 url 实例化普通网络任务,增加完成之后的 block 回调,使用比较多.
                    NSURLSessionDataTask *task = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    
                    }];
                }
                *2 用于文件下载的网络任务 NSURLSessionDownloadTask (无论文件大小,下载都使用 NSURLSessionDownloadTask) ,实例化对象有以下三种方法:
                {
                    // 1> 通过一个 request 实例化下载网络任务,增加任务完成之后的 block 回调,一般用在小文件下载.

                    NSURLSessionDownloadTask *task = [self.session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                        
                    }];

                    // 2> 通过一个 url 实例化下载网络任务,增加任务完成之后的 block 回调,一般用在小文件下载.
                    NSURLSessionDownloadTask *task = [self.session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                        
                    }];
                
                    // 3> 通过之前下载的数据 ResumeData ,实例化一个下载任务,用于断点续传.
                    NSURLSessionDownloadTask *task = [session downloadTaskWithResumeData:ResumeData completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                        
                    }];
                }
                *3 用于文件上传的网络任务 NSURLSessionUploadTask.
                {
                    // 目前,只有通过这种方式实例化的下载任务,才能实现文件上传.依然需要拼接数据.
                
                    NSURLSessionUploadTask *task = [session uploadTaskWithRequest:request fromData:fromData completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                        //
                    }]
                }
            }
    }
    <3> NSURLSession 的使用分为三步:
    {
        1> 实例化一个 NSURLSession 对象 session ;
        NSURLSession *session = [NSURLSession sharedSession];

        2> 通过 NSURLSession 对象,实例化对应的网络任务 task;
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request];

        3> 开启网络任务
        [task resume];
    }
}
/*------------------------------------  02 NSURLSession 下载的断点续传 ---------------------------*/
重点:1.学会使用 NSURLSession 实现下载任务. 2.实时监听下载进度,学会使用断点续传.
{
    利用 NSURLSession 实现文件下载,首先需要创建一个 NSURLSessionDownloadTask; 由于需要实时监听下载进度,所以,需要实现 <NSURLSessionDownloadDelegate>方法,这样,就需要自定义一个会话 session.并且制定代理.
    
    // NSURLSession 下载的断点续传实现步骤:
    
    1. 懒加载全局网络会话
    {
        -(NSURLSession *)session
        {
            if (!_session) {
                
                NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
                
                _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
                
            }
            return _session;
        }
    }
    2. 利用全局网络会话,创建下载 task, 开始下载任务
    {
        self.task = [self.session downloadTaskWithURL:url];
        
        [self.task resume];
    }
    3. 在代理方法中,实时监听下载进度
    {
        // 监听下载进度的方法
        // bytesWritten :本次下载的字节数
        // totalBytesWritten :已经下载的字节数
        // totalBytesExpectedToWrite :下载文件的总字节数
        -(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
        {
            
            NSLog(@"代理回调~");
            
            float progress = (float)totalBytesWritten/totalBytesExpectedToWrite;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.progress.progress = progress;
                
            });
            
        }
        
        // 完成下载的时候调用
        -(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
        {
            NSLog(@"下载完成%@",location);
        }
        
        // 断点续传的代理方法,暂时什么都不写
        -(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
        {
            NSLog(@"%s",__FUNCTION__);
        }
    }
    4. 当点击暂停之后,应该取消下载任务,记录当前下载的文件数据,并且将 task 任务设为 nil
    {
        [self.task cancelByProducingResumeData:^(NSData *resumeData) {
            
            self.reusemData = resumeData;
            
            self.task = nil;
        }];
    }
    5. 当点击继续之后,应该从上次下载的进度继续下载,这时,重新创建下载 task, 并且是根据上次记录的文件下载数据来实例化下载任务
    {
        if (!self.reusemData) {
            return;
        }
        
        self.task = [self.session downloadTaskWithResumeData:self.reusemData];
        
        self.reusemData = nil;
        
        [self.task resume];
    }
    
}
/*------------------------------------- 03 NSURLSession 实现上传文件 -----------------------------*/
重点:1.学会使用 NSURLSession 实现文件上传.
{
    NSURLSession 上传文件和 NSURLConnection 一样需要按格式拼接文件数据.重要的是要学会封装方法,具体使用如下:
    {
        // NSURLSession 做文件上传
        - (void)uploadMfileSession
        {
            // 1.实例化全局网络会话
            NSURLSession *session = [NSURLSession sharedSession];
            
            // 2.创建网络请求
            {
                NSURL *url = [NSURL URLWithString:@"http://localhost/upload/upload-m.php"];
                
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
                // 设置请求方法
                request.HTTPMethod = @"POST";
                // 告诉服务器,需要做文件上传
                NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",kBOUNDARY];
                
                [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
            }
            
            // 3. 将需要上传至服务器的文件包装在字典中.
            {
                // 需要上传的文件路径
                NSString *file1 = @"/Users/likaining/Desktop/meinv.jpg";
                NSString *file2 = @"/Users/likaining/Downloads/XMLdemo.xml";
                
                // 文件在服务器中保存的名称
                NSString *fileName1 = @"meinv";
                NSString *fileName2 = @"demo";
                
                // 将上传数据包装在字典中
                NSMutableDictionary *fileDict = [NSMutableDictionary dictionary];

                [fileDict setObject:file1 forKey:fileName1];
                [fileDict setObject:file2 forKey:fileName2];
            }
            // 4. 将需要上传的非文件数据也包装在字典中
            {
                NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
                [parameter setObject:@"likaining" forKey:@"username"];
            }
            // 5. 将需要上传的数据,按照上传的数据格式化数据.并且转为二进制数据.
            NSData *dataM = [self formDataWithfileName:@"userfile[]" fileDict:fileDict parameter:parameter];
            
            // 6. 利用网络会话,建立上传任务
            NSURLSessionUploadTask *task = [session uploadTaskWithRequest:request fromData:dataM completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                //
                NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                
                NSLog(@"response: %@",response);
                
            }];
            
            // 7 .开始上传.
            [task resume];
        }
        
        // 格式化上传数据的方法封装.
        - (NSData *) formDataWithfileName:(NSString *)fileName fileDict:(NSDictionary *)fileDict parameter:(NSDictionary *)parameter
        {
            
            NSMutableData *data = [NSMutableData data];
            
            // key : 服务器保存的文件名
            // obj : 上传的文件地址
            [fileDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                //
                NSMutableString *headerStrM = [NSMutableString stringWithFormat:@"\r\n--%@\r\n",kBOUNDARY];
                [headerStrM appendFormat:@"Content-Disposition: form-data; name=%@; filename=%@\r\n",fileName,key];
                
                NSString *contentType = [self getContentTypeFromFile:obj];
                
                [headerStrM appendFormat:@"Content-Type: %@\r\n\r\n",contentType];
                
                NSData *headerData = [headerStrM dataUsingEncoding:NSUTF8StringEncoding];
                
                NSData *fileData = [NSData dataWithContentsOfFile:obj];
                
                
                [data appendData:headerData];
                [data appendData:fileData];
                
            }];
            
            // key :username 服务器接收的 key
            // obj :上传文件的人
            [parameter enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                //
                NSMutableString *headerM = [NSMutableString stringWithFormat:@"\r\n--%@\r\n",kBOUNDARY];
                [headerM appendFormat:@"Content-Disposition: form-data; name=%@\r\n\r\n",key];
                
                NSString *username = obj;
                
                NSData *headerData = [headerM dataUsingEncoding:NSUTF8StringEncoding];
                
                NSData *userData = [username dataUsingEncoding:NSUTF8StringEncoding];
                
                [data appendData:headerData];
                [data appendData:userData];
                
            }];
            
            NSMutableString *footerStrM = [NSMutableString stringWithFormat:@"\r\n--%@--\r\n",kBOUNDARY];
            
            NSData *footerData = [footerStrM dataUsingEncoding:NSUTF8StringEncoding];
            
            [data appendData:footerData];
            
            return data;
        }
    }
    
}
/*------------------------------------- 04 文件的复制和剪切 ---------------------------------------*/
重点:掌握文件操作中的复制和剪切.
{
    文件下载到本地之后,有时候需要对文件进行移动操作,这样就需要掌握掌握文件的复制和剪切操作.
    
    1.文件的拷贝
    // 新建一个文件路径
    NSString *path = @"/Users/likaining/Desktop/abc/";
    
    // 从一个文件路径拷贝文件到另一个文件路径
    // AtPath : 拷贝前的文件路径
    // ToPath : 拷贝后的文件路径
    [[NSFileManager defaultManager] copyItemAtPath:location.path toPath:path error:0];
    
    
    2.文件的剪切
    // response.suggestedFilename:建议使用的文件名,一般跟服务器端的文件名一致
    NSString *file = [caches stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    
    // 将临时文件剪切到Caches文件夹
    // AtPath : 剪切前的文件路径
    // ToPath : 剪切后的文件路径
    [[NSFileManager defaultManager] moveItemAtPath:location.path toPath:file error:nil];
    
}
/*------------------------------------- 05 文件的解压缩 ------------------------------------------*/
重点:掌握文件的解压缩操作,会使用解压缩框架.
{
    为了方便网络传输,文件经常被压缩之后再进行网络传输,这个时候,需要学会解压缩文件.
    
    1.文件的解压缩需要导入第三方框架: SSZipArchive ,需要注意的是,这个框架依赖一个动态度 libz.dylib.
    
    2. 压缩文件:
    // 1.获得需要压缩的文件夹
    NSString *images = [caches stringByAppendingPathComponent:@"images"];
    
    // 1.创建一个zip文件（压缩）
    NSString *zipFile = [caches stringByAppendingPathComponent:@"images.zip"];
    
    BOOL result = [SSZipArchive createZipFileAtPath:zipFile withContentsOfDirectory:images];
    
    3. 解压缩文件:
    // location.path:需要解压缩的文件
    // 文件解压缩之后存放的路径(注意,只需要给出一个文件路径就可以,因为很可能解压缩之后,生成很多个文件).
    [SSZipArchive unzipFileAtPath:location.path toDestination:path];

}
/*------------------------------------- 06 AFN 的使用  ------------------------------------------*/
重点: 掌握 AFN 发送网络请求的方法.
{
    AFN 是最常用的网络框架, AFN 内部封装了 NSURLConnection 和 NSURLSession
    
    其中:
    
        AFHTTPRequestOperationManager 是对 NSURLConnection 的封装;
    
        AFHTTPSessionManager 是对 NSURLSession 的封装.

    AFN 的使用非常简单:
    
        总共分为两步: 1. 创建网络请求管理者; 2. 封装请求参数; 3.发送请求.
    
        // 1. 创建网络请求管理者
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
        // 2. 封装请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"username"] = @"zhangsan";
        params[@"password"] = @"zhang";
    
        // 3. 发送网络请求 ,AFN 中最常用的两个请求就是 GET 请求 和 POST 请求
        {
            // GET请求
            [mgr GET:url parameters:params
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 // 请求成功的时候调用这个block
                 NSLog(@"请求成功---%@", responseObject);
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 // 请求失败的时候调用调用这个block
                 NSLog(@"请求失败");
             }];
            
            // POST请求
            [mgr POST:url parameters:params
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  // 请求成功的时候调用这个block
                  NSLog(@"请求成功---%@", responseObject);
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  // 请求失败的时候调用调用这个block
                  NSLog(@"请求失败");
              }];
        }
}
/*------------------------------------- 07 AFN 数据解析  ----------------------------------------*/
重点: 针对不同的网络请求,设置不同的数据解析器
{
    <1> AFN 可以自动对服务器返回的数据进行解析,默认将服务器返回的数据当做 JSON 数据解析.
    
        必须按照服务器返回的数据格式,选择不同的解析器.不然,就会报错,得不到想要的数据.
    {
        // 创建网络请求管理者
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        
        // 1. 默认情况下,网络请求的管理者的解析器如下:
        // 由于返回的是 JSON 数据,所以从服务器返回的数据:responseObject 的类型是 NSDictionary 或者 NSArray
        mgr.responseSerializer = [AFJSONResponseSerializer serializer];

        
        // 2. 如果服务器返回的是 XML 数据,那么必须设置网络请求管理者的解析器类型如下:
        // 这时,服务器返回的数据 responseObject 的数据类型是 NSXMLParser
        mgr.responseSerializer = [AFXMLParserResponseSerializer serializer];
        
        // 3. 如果服务器返回的是 data(比如:文件数据),这时需要告诉 AFN 不要去解析服务器返回的数据,保持原来的 data 数据就可以了.
        mgr.responseSerializer = [AFHTTPResponseSerializer serializer];

    }
    
    <2> 需要特别注意的是,服务器返回的数据一定要跟 responseSerializer 相对应.对应关系如下:
    {
        1> 服务器返回的是JSON数据
        * AFJSONResponseSerializer
        * AFHTTPResponseSerializer
        
        2> 服务器返回的是XML数据
        * AFXMLParserResponseSerializer
        * AFHTTPResponseSerializer
        
        3> 服务器返回的是其他数据
        * AFHTTPResponseSerializer
    }
}















