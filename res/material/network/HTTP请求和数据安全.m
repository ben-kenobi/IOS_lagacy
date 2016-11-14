/*------------------------------------- 01 HTTP请求 ---------------------------------------*/
重点:1.超文本传输协议. 2.http请求过程.
{
    1> http协议: 超文本传输协议(Hypertext Transfer Protocol)
    {
        http协议规定了客户端和服务器之间的数据传输格式.
        
        http协议是在网络开发中最常用的协议.不管是移动客户端还是PC端,访问网络资源经常使用http协议.
        
        http优点:
        
        <1> 简单快速:
            http协议简单,通信速度很快.
        
        <2> 灵活:
            http协议允许传输任意类型的数据.
        
        <3> http协议是短连接(非持续性连接)
            http协议限制每次连接只处理一个请求,服务器对客户端的请求作出响应后,马上断开连接.这种方式可以节省传输时间.
    }
    
    2> http协议的使用;
    
    完整的http通信分为两步:
    
    <1> 请求:客户端向服务器索要数据.
    {
        http协议规定:一个完整的http请求包含'请求行','请求头','请求体'三个部分;
        
        '请求行':包含了请求方法,请求资源路径,http协议版本.
        
        "GET /resources/images/ HTTP/1.1"
        
        '请求头':包含了对客户端的环境描述,客户端请求的主机地址等信息.
        
        Accept: text/html // 客户端所能接收的数据类型
        Accept-Language: zh-cn // 客户端的语言环境
        Accept-Encoding: gzip // 客户端支持的数据压缩格式
        Host: m.baidu.com // 客户端想访问的服务器主机地址
        User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:37.0) Gecko/20100101 Firefox/37.0 // 客户端的类型,客户端的软件环境
       
        '请求体':客户端发给服务器的具体数据,比如文件/图片等.
    }
    
    <2> 响应:服务器返回客户端想要的数据.
    {
        http协议规定:一个完整的http响应包含'状态行','响应头','实体内容'三个部分;
        
        '状态行':包含了http协议版本,状态吗,状态英文名称.
        
        "HTTP/1.1 200 OK"
        
        '响应头':包含了对服务器的描述,对返回数据的描述.
    
        Content-Encoding: gzip // 服务器支持的数据压缩格式
        Content-Length:  1528 // 返回数据的长度
        Content-Type:  application/xhtml+xml;charset=utf-8 // 返回数据的类型
        Date: Mon, 15 Jun 2015 09:06:46 GMT // 响应的时间
        Server: apache  // 服务器类型
        
        '实体内容':服务器返回给客户端的具体数据(图片/html/文件...).
    }
    
    3> 发送http请求:
    {
        在iOS开发中,发送http请求的方案有很多,常见的有如下几种:
        <1> 苹果原生:
        {
            * NSURLConnection:用法简单,古老经典的一种方案.
        
            * NSURLSession:iOS7以后推出的技术,功能比NSURLConnection更加强大.
        
            * CFNetWork:NSURL 的底层,纯C语言,一般不用.
        }
        
        <2> 第三方框架:
        {
            * ASIHttpRequest:http终结者,功能很强大,可惜作者已停止更新.
            
            * AFNetWorking:简单易用,提供了基本够用的常用功能,维护和使用者多.
            
            * MKNetWorkKit:简单易用,产自印度,维护和使用者少.
        }
        
        在开发中,一般使用第三方框架.
    }
}
/*------------------------------------- 02 GET 和 POST ------------------------------------*/
重点:1.GET 和 POST的区别? 2.用POST方法发送登陆请求.
{
    <1> http方法:
    http协议定义了很多方法对应不同的资源操作,其中最常用的是GET 和 POST 方法.
    {
        { GET、POST、OPTIONS、HEAD、PUT、DELETE、TRACE、CONNECT、PATCH }
        
        增:PUT
        删:DELETE
        改:POST
        查:GET
    }
    
    <2> 参数
    {
        因为 GET 和 POST 可以实现上述所有操作,所以,在现实开发中,我们只要会用GET 和 POST 方法就可以了.
        
        在与服务器交互时,有时候需要给服务器发送一些数据,比如登录时需要发送用户名和密码.
        
        参数:就是指传递给服务器的具体数据.
    }

    <3> GET 和 POST 的主要区别表现在参数的传递上.
    
    "GET":
    {
        GET的本质是从服务器得到数据,效率更高.并且GET请求可以被缓存.
        
        '注意': 网络缓存数据,保存在SQLite的数据库中(路径:NSHomeDirectory()).
        查看缓存数据命令行:
        'cd 文件目录'   (打开文件目录)
        'ls'   查看当前文件下目录
        'sqlite3 Cache.db'   打开数据库
        '.tables'    查看数据库中的表单
        'select * from cfurl_cache_response;'   查看服务器响应缓存
        'select * from cfurl_cache_receiver_data;'   查看服务器返回的数据缓存
    
        在请求 URL 后面以 ? 的形式跟上发给服务器的参数,参数以 "参数名"="参数值"的形式拼接,多个参数之间用 & 分隔.
    
        注意:GET的长度是有限制的,不同的浏览器有不同的长度限制,一般在2~8K之间.
    }
    
    "POST":
    {
        POST的本质是向服务器发送数据,也可以获得服务器处理之后的结果,效率不如GET.POST请求不可以被缓存,每次刷新之后都需要重新提交表单.
    
        发送给服务器的参数全部放在'请求体'中;
    
        理论上,POST传递的数据量没有限制.
    
        注意:所有涉及到用户隐私的数据(密码/银行卡号等...)都要用POST的方式传递.
    }
    
    <4>注意:URL中不能出现空格以及中文等特殊符号.
    
    1>URL中,所有的字符都必须是 ASCII 码;
    
    2>URL中不能出现中文和特殊符号(如空格);
    
    所以,如果 URL 中出现了中文,需要添加百分号转译.
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    <5> POST 发送登陆请求:
    
    注意:
    
    1> 用可变请求: NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    2> 指定请求方法: request.HTTPMethod = @"POST";
    
    3> 设置请求体数据: request.HTTPBody = data;
    
    // 实例化请求体字符串
    NSString *body = [NSString stringWithFormat:@"username=%@&password=%@",self.userName.text,self.password.text];
    // 将字符串转换成二进制数据
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    4> 发送异步网络请求.
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        // NSURLResponse *response: 服务器响应
        
        // NSData *data: 服务器返回的数据
        
        // NSError *connectionError: 连接错误处理
        
        // 网络请求的回调.
    }]
}
/*------------------------------------- 03 保存用户信息 -------------------------------------*/
重点:1.偏好设置保存用户信息.
{
    <1>如果用户登陆成功,就保存用户信息.下次直接从偏好设置中读取用户信息,以此做到用户只需要输入一次账号和密码,以后登陆就可以不用再次输入.
    
    1>.登陆成功,保存用户信息(偏好设置)
    2>.再次进入,直接显示用户之前保存的信息.避免用户重复输入.
    
    // 偏好设置存储用户信息
    -(void)savaUserInfo
    {
        // 实例化偏好设置对象(单例)
        NSUserDefaults *User = [NSUserDefaults standardUserDefaults];
        // 保存用户名
        [User setObject:self.userName.text forKey:kITUSERNAMEKEY];
        // 保存用户密码
        [User setObject:pass forKey:kITUSERPASSKEY];
        // 同步保存用户信息
        [User synchronize];
    }
    
    // 加载偏好设置中的用户信息
    - (void)loadUserInfo
    {
        NSUserDefaults *User = [NSUserDefaults standardUserDefaults];
        
        if ([User objectForKey:ITUSERNAMEKEY]) {
            
            self.userName.text = [User objectForKey:ITUSERNAMEKEY];
            
        }if ([User objectForKey:ITUSERPASSKEY]) {
            
            self.password.text = [User objectForKey:ITUSERPASSKEY];
            
        };
    }
    
    <2> 用户登陆业务逻辑
    {
        // <1> 用户登陆需要一个单独的控制器,因为只需要登陆一次(Login.storyboard). 应用程序需要有一个入口:main.storyboard: app 主页面
        
        // <2> 判断用户是否登陆成功过(通过偏好设置中存储的用户信息判断)
        // 1> 如果偏好设置中存有用户信息(说明之前登陆成功过),直接进入 app 主页面 :main.storyboard
        // 2> 如果偏好设置中不存在用户信息(第一次登陆或者之前注销了用户信息),进入登陆界面 :Login.storyboard
        
        // <3> 如果用户登陆成功,跳转到 app 主页面:main.storyboard.并且在偏好设置中保存用户信息.
        
        // <4> 如果用户点击注销按钮,注销用户信息,返回到登陆页面.
    }
    

    <3> 问题: 用户密码不能以明文的形式保存,需要对用户密码加密之后再保存!
    
    密码的安全原则:
    
    1> 本地和服务器都不允许保存用户的密码明文.
    
    2> 在网络上,不允许传输用户的密码明文.
    
    现代密码学趣闻! 中途岛海战(AF)
    
    <4> 数据加密算法:
    
    1> 对称加密算法:加密和解密使用同一密钥.加密解密速度快,要保证密钥安全.适合给大数据加密.
    
    2> 非对称加密算法:使用公钥加密,私钥解密.或者使用私钥加密,公钥解密.更加安全,但是加密解密速度慢,适合给小数据加密.
    
    <5> 小技巧:
    
    openssl :是一个强大的安全套接字层密码库,囊括主要的密码算法,常用的密钥和证书封装管理功能以及 SSL 协议.提供丰富的应用程序测试功能.
    
    终端命令:
    
        echo hello |openssl md5
        echo hello |openssl sha1
        echo hello |openssl sha -sha256
        echo hello |openssl sha -sha512
}


/*------------------------------------- 04 信息安全加密 -------------------------------------*/
了解:常用加密方法: 1> base64  2> MD5  3> MD5加盐  4> HMAC  5> 时间戳密码(用户密码动态变化)
{
    1> base64
    {
        base64 编码是现代密码学的基础.
        
        原本是 8个bit 一组表示数据,改为 6个bit一组表示数据,不足的部分补零,每 两个0 用 一个 = 表示.
        用base64 编码之后,数据长度会变大,增加了大约 1/3 左右.
        
        base64 基本能够达到安全要求,但是,base64能够逆运算,非常不安全!
        base64 编码有个非常显著的特点,末尾有个 '=' 号.
        
        利用终端命令进行base64运算:
        
            // 将文件 meinv.jpg 进行 base64运算之后存储为 meinv.txt
            base64 meinv.jpg -o meinv.txt
        
            // 讲meinv.txt 解码生成 meinv.png
            base64 -D meinv.txt -o meinv.png
        
            // 将字符串 "hello" 进行 base 64 编码 结果:aGVsbG8=
            echo "hello" | base64
        
            // 将 base64编码之后的结果 aGVsbG8= 反编码为字符串
            echo aGVsbG8= | base64 -D
    }
    
    2> MD5 -- (信息-摘要算法) 哈希算法之一.
    {
    
        把一个任意长度的字节串变换成一定长度的十六进制的大整数. 注意,字符串的转换过程是不可逆的.
    
        用于确保'信息传输'完整一致.
    
        MD5特点:
        
        *1.压缩性:   任意长度的数据,算出的 MD5 值长度都是固定的.
        *2.容易计算: 从原数据计算出 MD5 值很容易.
        *3.抗修改性: 对原数据进行任何改动,哪怕只修改一个字节,所得到的 MD5 值都有很大区别.
        *4.弱抗碰撞: 已知原数据和其 MD5 值,想找到一个具有相同 MD5 值的数据(即伪造数据)是非常困难的.
        *5.强抗碰撞: 想找到两个不同数据,使他们具有相同的 MD5 值,是非常困难的.
        
        MD5 应用:
        
        *1. 一致性验证: MD5 将整个文件当做一个大文本信息,通过不可逆的字符串变换算法,产生一个唯一的 MD5 信息摘要.就像每个人都有自己独一无二的指纹,MD5 对任何文件产生一个独一无二的"数字指纹".
        
            利用 MD5 来进行文件校验, 被大量应用在软件下载站,论坛数据库,系统文件安全等方面.
        
        *2. 数字签名;
        
        *3. 安全访问认证;
    
    }
    
    3> MD5加盐
    {
        MD5 本身是不可逆运算,但是,目前网络上有很多数据库支持反查询.
        
        MD5加盐 就是在密码哈希过程中添加的额外的随机值.
        
        注意:加盐要足够长,足够复杂.
    }
    
    4> HMAC
    {
        HMAC 利用哈希算法,以一个密钥和一个消息为输入,生成一个消息摘要作为输出.
        
        HMAC 主要使用在身份认证中;
        
        认证流程:
        
            *1. 客户端向服务器发送一个请求.
            *2. 服务器接收到请求后,生成一个'随机数'并通过网络传输给客户端.
            *3. 客户端将接收到的'随机数'和'密钥'进行 HMAC-MD5 运算,将得到的结构作为认证数据传递给服务器.
            (实际是将随机数提供给 ePass,密钥也是存储在 ePass中的)
            *4. 与此同时,服务器也使用该'随机数'与存储在服务器数据库中的该客户'密钥'进行 HMAC-MD5 运算,如果
            服务器的运算结果与客户端传回的认证数据相同,则认为客户端是一个合法用法.
        
    }
    
    5> 时间戳密码(用户密码动态变化)
    {
        相同的密码明文 + 相同的加密算法 ===》 每次计算都得出不同的结果.可以充分保证密码的安全性.
        
        原理:将当前时间加入到密码中;
        
        因为每次登陆时间都不同,所以每次计算出的结果也都不相同.
        
        服务器也需要采用相同的算法.这就需要服务器和客户端时间一致.
        
        注意:服务器端时间和客户端时间,可以有一分钟的误差(比如:第59S发送的网络请求,一秒钟后服务器收到并作出响应,这时服务器当前时间比客户端发送时间晚一分钟).
        
        这就意味着,服务器需要计算两次（当前时间和一分钟之前两个时间点各计算一次）.只要有一个结果是正确的,就可以验证成功!
        
    }
    
    // IP辅助/手机绑定...

}
/*-------------------------------------- 05 钥匙串访问 -------------------------------------*/
重点: 1.钥匙串访问
{
    苹果在 iOS 7.0.3 版本以后公布钥匙串访问的SDK. 钥匙串访问接口是纯C语言的.
    
    钥匙串使用 AES 256加密算法,能够保证用户密码的安全.
    
    钥匙串访问的第三方框架(SSKeychain),是对 C语言框架 的封装.注意:不需要看源码.
    
    钥匙串访问的密码保存在哪里?只有苹果才知道.这样进一步保障了用户的密码安全.
    
    使用步骤:
    {
        // 获取应用程序唯一标识.
        
        NSString *bundleId = [NSBundle mainBundle].bundleIdentifier;
        
        // 1.利用第三方框架,将用户密码保存在钥匙串
        
        [SSKeychain setPassword:self.pwdText.text forService:bundleId account:self.usernameText.text];
        
        "注意"三个参数:
        
        1.密码:可以直接使用明文.钥匙串访问本身是使用 AES 256加密,就是安全的.所以使用的时候,直接传递密码明文就可以了.
        
        2.服务名:可以随便乱写,建议唯一! 建议使用 bundleId.
        
        bundleId是应用程序的唯一标识,每一个上架的应用程序都有一个唯一的 bundleId
        
        3.账户名:直接用用户名称就可以.
        
        // 2.从钥匙串加载密码
        
        self.pwdText.text = [SSKeychain passwordForService:bundleId account:self.usernameText.text];
    }
}
/*-------------------------------------- 06 指纹识别 ---------------------------------------*/
重点: 1.指纹识别用法
{
    指纹识别功能是 iphone 5S之后推出的.SDK是 iOS 8.0 推出!

    推出指纹识别功能的目的,是为了简化移动支付环节,占领移动支付市场.

    使用步骤:
    {
        1> 导入框架;
    #import <LocalAuthentication/LocalAuthentication.h>
        
        2> 指纹识别的实现:
        {
            1. 需要判断手机系统版本是否是 iOS 8.0 以上的版本.只有 iOS 8.0 以上才支持.
            
            // 获得当前系统版本号
            float version = [UIDevice currentDevice].systemVersion.floatValue;
            
            if (version < 8.0 ) // 判断当前系统版本
            {
                NSLog(@"系统版本太低,请升级至最新系统");
                return;
            }
            
            2. 实例化指纹识别对象,判断当前设备是否支持指纹识别功能(是否带有TouchID).
            
            // 1> 实例化指纹识别对象
            LAContext *laCtx = [[LAContext alloc] init];
            
            // 2> 判断当前设备是否支持指纹识别功能.
            if (![laCtx canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:NULL])
            { // 如果设备不支持指纹识别功能
                
                NSLog(@"该设备不支持指纹识别功能");
                
                return;
            };
            
            3.指纹登陆(默认是异步方法)
            // 指纹登陆
            [laCtx evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"指纹登陆" reply:^(BOOL success, NSError *error)
             {
                 // 如果成功,表示指纹输入正确.
                 if (success) {
                     NSLog(@"指纹识别成功!");
                     
                 }else
                 {
                     NSLog(@"指纹识别错误,请再次尝试");
                 }
             }];
        }
    }
}


















