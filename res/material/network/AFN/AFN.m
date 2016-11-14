一、2大管理对象
1.AFHTTPRequestOperationManager
* 对NSURLConnection的封装

2.AFHTTPSessionManager
* 对NSURLSession的封装

二、AFHTTPRequestOperationManager的具体使用
1.创建管理者
AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];

2.封装请求参数
NSMutableDictionary *params = [NSMutableDictionary dictionary];
params[@"username"] = @"哈哈哈";
params[@"pwd"] = @"123";

3.发送请求
NSString *url = @"http://localhost:8080/MJServer/login";
[mgr POST:url parameters:params
  success:^(AFHTTPRequestOperation *operation, id responseObject) {
      // 请求成功的时候调用这个block
      NSLog(@"请求成功---%@", responseObject);
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      // 请求失败的时候调用调用这个block
      NSLog(@"请求失败");
  }];
// GET请求
[mgr GET:url parameters:params
  success:^(AFHTTPRequestOperation *operation, id responseObject) {
      // 请求成功的时候调用这个block
      NSLog(@"请求成功---%@", responseObject);
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      // 请求失败的时候调用调用这个block
      NSLog(@"请求失败");
  }];

三、对服务器返回数据的解析
1.AFN可以自动对服务器返回的数据进行解析
* 默认将服务器返回的数据当做JSON来解析

2.设置对服务器返回数据的解析方式
1> 当做是JSON来解析（默认做法）
* mgr.responseSerializer = [AFJSONResponseSerializer serializer];
* responseObject的类型是NSDictionary或者NSArray

2> 当做是XML来解析
* mgr.responseSerializer = [AFXMLParserResponseSerializer serializer];
* responseObject的类型是NSXMLParser

3> 直接返回data
* 意思是：告诉AFN不要去解析服务器返回的数据，保持原来的data即可
* mgr.responseSerializer = [AFHTTPResponseSerializer serializer];

3.注意
* 服务器返回的数据一定要跟responseSerializer对得上
1> 服务器返回的是JSON数据
* AFJSONResponseSerializer
* AFHTTPResponseSerializer

2> 服务器返回的是XML数据
* AFXMLParserResponseSerializer
* AFHTTPResponseSerializer

3> 服务器返回的是其他数据
* AFHTTPResponseSerializer
