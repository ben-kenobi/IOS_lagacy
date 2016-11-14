/*------------------------------------ 网络基础: 1.二进制数据流 --------------------------------*/
重点:1.了解网络中传输的都是二进制数据流.  2.了解网络编程概念.
{
    认识网络:
    
    // 网络概念 <1> 经常见到的: 网卡/网线/IP地址/子网掩码/路由地址/DNS服务器地址 作用?
    // <2> 容易忽略的:MAC地址/数据/数据包
    // <3> 网络编程的概念:客户端/服务器/请求/响应/数据流
    
    // 网络是数据交互的媒介,我们通过网络得到服务器上的数据,也是通过网络给服务器传递数据.
    // 也就是说,网络的实质,是交互数据.
    
    0.移动网络应用 = 良好的UI + 良好的用户体验 + 实时更新的数据
    
    1.网络是应用的灵魂,是所有应用的数据来源.离开了网络,我们的应用就是一潭死水.
    
    网络编程概念:
    
    <1>客户端(Client):移动设备(手机/iPad等手持设备).
    客户端一般就是前端/前台等等.iOS,android开发都是前端开发.
    
    <2>服务器(Server):为客户端提供服务(比如数据/资源等)的机器---本质也是一台计算机(+服务器软件).
    服务器开发就是后端/后台开发.java/php/.net等.
    
    <3>请求(Request):客户端向服务器索取数据.
    
    <4>响应(Response):服务器对客户端请求做出的反应,一般就是返回数据给客户端.
    
    服务器:按开发阶段来分,分为两种:
    
    远程服务器: 外网服务器.应用上线之后供全体用户使用的服务器.速度取决于用户的网速和服务器的性能.
    
    本地服务器: 内网服务器,测试服务器.开发测试阶段使用的服务器.供内部开发测试人员使用.速度飞快.
    
    2.网络中传输的都是二进制数据流. html/图片/视频数据...
    
    二进制数据流是如何被分组并传输的呢?
}
/*------------------------------------- 网络基础: 2.七层协议  ---------------------------------*/
重点:1.理解网络 2.理解七层协议/五层模型 3.理解Socket.
{
    应用层: 规定"应用程序"的数据格式. http / ftp /email 等.   //纸条上写的是啥?
    
    传输层: 建立"端口"到"端口"之间的通信. UDP/TCP 协议."端口". //我们帮你传纸条
    
    网络层: 确定每一台计算机的位置,建立"主机"到"主机"之间的通信.IPv4协议,"IP地址".   // 女孩的位置
    
    数据链路层: 确定1和0的分组方式.以太网协议:一组电信号就是一个数据包."MAC地址"/网卡/广播. // 深情告白
    
    物理层: 将电脑连接入网络,传输电信号1和0.      // 一张白纸
    
    互联网分层结构的好处:
    
        上层的变动完全不影响下层的结构.
    
    Socket : "主机 + 端口"就是"Socket(套接字/插座)"  ----- TCP/IP协议
}
/*----------------------------------  网络基础: 3.数据包/流 ----------------------------------*/
重点:1.理解数据包. 2.理解网络通信实质.
{
    网络通信的基础: 知道对方的MAC地址和IP地址.
    
    网络通信的实质: 互相交换数据包.
    
    数据包:
        每一个数据包都包含 "标头"和"数据"两个部分."标头"包含本数据包的一些说明."数据"则是本数据包的内容.
    
    以太网数据包: 最基础的数据包.标头部分包含了通信双方的MAC地址,数据类型等. '标头'长度:18字节,'数据'部分长度:46~1500字节.
    
    IP数据包: 标头部分包含通信双方的IP地址,协议版本,长度等信息.  '标头'长度:20~60字节,"数据包"总长度最大为65535字节.
    
    TCP/UDP数据包:标头部分包含双方的发出端口和接收端口.  UDP数据包:'标头'长度:8个字节,"数据包"总长度最大为65535字节,正好放进一个IP数据包.  TCP数据包:理论上没有长度限制,但是,为了保证网络传输效率,通常不会超过IP数据长度,确保单个包不会被分割.
    
    应用程序数据包: 标头部分规定应用程序的数据格式.数据部分传输具体的数据内容.
    
    嵌套:
        数据包层层嵌套,上一层数据包嵌套在下一层数据包的数据部分.最后通通由以太网数据包来进行数据传递.
    
    分包/拆包:
        一般传递的数据都比较大,会将数据包分割成很多个部分来传递.
    
    拼包:
        将接收到数据包按序号拼接起来,组成完整的数据包.
    
}
/*----------------------------------  网络基础: 4.IP地址    ----------------------------------*/
重点:了解IP地址.
{
    静态IP地址:
        固定不变的IP地址,需要用户自己手动设置.
    
    动态IP地址:
        通过DHCP协议自动生成的IP地址.
    
    DHCP协议:
        通过DHCP协议,用户获得本机的动态IP地址,子网掩码,网关,DNS服务器等.
    
    子网掩码:
        与IP地址配合使用判断两台计算机是否位于同一个子网络.
    
    DNS服务器:
        可以将域名(网址)转换成IP地址.
    
}
/*----------------------------------  网络基础: 4.一个HTTP请求 --------------------------------*/
重点:了解一个HTTP请求的完整过程.
{
    对之前所学内容的一个系统的演示.
    
    1. URL(Uniform Resource Locator):
        统一资源定位符.URL就是资源的地址,位置.通过一个URL能够找到互联网上唯一的一个资源.
    
    URL的基本格式:  协议://主机地址/路径
    
    协议:不同的协议代表不同的资源查找方式,资源传输方式.
    {
        URL中的常见协议:
        
        <1>HTTP:超文本传输协议,在网络开发中最常用的协议.访问的是远程的网络资源.格式:http://...
        
        <2>file:访问的时本地计算机上的资源.格式:file://(不要再加主机地址了)
        
        <3>FTP:访问的是共享主机的文件资源.格式:ftp://
        
        <4>mailto:访问的是电子邮件地址.格式:mailto:
    }
    
    主机地址:存放资源的主机IP地址(域名).
    
    路径:资源在主机中得具体位置.
    
    2. HTTP请求的完整过程:
    
    <1> 请求: 客户端发出请求.向服务器索要数据(操作数据).
    
    <2> 响应: 服务器对客户端的请求做出响应.返回客户端所需要的数据.
    
    3. 包装一个HTTP请求
    
    用 NSURLRequest 来包装一个HTTP请求.可以指定缓存策略和超时时间.
    
    1> 缓存策略的选择:NSURLRequestCachePolicy
    {
        NSURLRequestUseProtocolCachePolicy = 0,
        // 默认的缓存策略,使用协议定义.
        
        NSURLRequestReloadIgnoringLocalCacheData = 1,
        // 忽略本地缓存,直接从原始服务器地址下载.
        
        NSURLRequestReturnCacheDataElseLoad = 2,
        // 只有在缓存中不存在数据时,才从原始地址下载
        
        NSURLRequestReturnCacheDataDontLoad = 3,
        // 只使用缓存数据,如果不存在缓存,则请求失败. 用于没有网络连接的离线模式
        
        NSURLRequestReloadIgnoringLocalAndRemoteCacheData = 4,
        // 忽略远程和本地的数据缓存,直接从原始地址下载
        
        NSURLRequestReloadIgnoringCacheData = NSURLRequestReloadIgnoringLocalCacheData = 1,
        // 忽略缓存,直接从原始服务器地址下载.
        
        NSURLRequestReloadRevalidatingCacheData = 5,
        // 验证本地数据和远程数据是否相同,如果不同则下载远程数据,否则使用本地数据.
        
    }
    
    // 网络数据缓存
    网络缓存数据,保存在SQLite的数据库中(NSHomeDirectory()),
    
    //查看缓存的数据命令行:
    cd 文件目录 (打开文件目录)
    ls 查看当前文件下目录
    sqlite3 Cache.db 打开数据库
    .tables 查看数据库中的表单
    select * from cfurl_cache_response; 查看服务器响应缓存
    select * from cfurl_cache_receiver_data; 查看服务器返回的数据缓存
    
    2> 默认的超时时间: timeoutInterval = 60
    
    4. 发送请求
    
    用 NSURLConnection 发送请求.
    
    同步方法:
    + (NSData *)sendSynchronousRequest:(NSURLRequest *)request returningResponse:(NSURLResponse **)response error:(NSError **)error;
    
    异步方法:
    + (void)sendAsynchronousRequest:(NSURLRequest*) request queue:(NSOperationQueue*) queue
    completionHandler:(void (^)(NSURLResponse* response, NSData* data, NSError* connectionError)) handler
    
    "iPhone AppleWebKit" 制定客户端类型
}
/*----------------------------------- 网络基础: 5.Socket演练 ---------------------------------*/
重点:"理解"什么是Socket.
{
    0.
    nc -lk 端口号 :始终监听本地计算机此端口的数据.
    
    
    1.导入三个头文件
    {
        #import <sys/socket.h>
        #import <netinet/in.h>
        #import <arpa/inet.h>
    }
    
    2.Socket书写步骤
    {
        1.创建客户端Socket            socket(<#int#>, <#int#>, <#int#>);
        2.创建服务器Socket            struct sockaddr_in serverAddress;
        3.连接到服务器(Socket编程)     connect(<#int#>, <#const struct sockaddr *#>, <#socklen_t#>);
        4.发送数据给服务器             send(<#int#>, <#const void *#>, <#size_t#>, <#int#>)
        5.接收服务器返回的数据          recv(<#int#>, <#void *#>, <#size_t#>, <#int#>)
        6.关闭 Socket                close(socketNumber)
    }
    
    /*
     创建客户端 Socket.
     三个参数: domain:网络地址类型 type:端口类型 protocal:传输协议
     
     domain:协议域 指定socket主机地址类型. 网络层协议 AF_INET/IPv4协议; AF_INET_6/IPv6协议
     
     type:指定Socket端口类型. 指定传输层协议类型(TCP/UDP),SOCK_STREAM(TCP/流) ,SOCK_DGRAM(UDP/报文头)
     
     protocal:指定传输协议:常用协议:IPPROTO_TCP、IPPROTO_UDP等，分别对应TCP传输协议、UDP传输协议.
     
     最后一个参数传0,会根据第二个参数,自动选择第二个参数对应的协议.
     
     返回值:如果 > 0 表示成功.
     */
    
    // 0.创建客户端 Socket.
    int socketNumber = socket(AF_INET, SOCK_STREAM, 0);
    
    if (socketNumber > 0) {
        NSLog(@"Socket创建成功:%d",socketNumber);
    }else{
        NSLog(@"Socket创建失败");
    };
    
    /*
     连接到服务器.
     三个参数:
     
     1.客户端socket.
     2.接收方的socket参数.
     3.数据长度.
     
     返回值: 0 表示成功,其他: 错误代号.
     */
    
    
    // 1.服务器socket
    struct sockaddr_in serverAddress;
    // IPv4协议.
    serverAddress.sin_family = AF_INET;
    // 接收方(服务器)IP地址.
    serverAddress.sin_addr.s_addr = inet_addr("127.0.0.1");
    // 端口号.
    serverAddress.sin_port = htons(56789);
    
    
    // 2.连接到服务器

    // serverAddress 的数据长度.
    socklen_t length = sizeof(serverAddress);
    // 连接服务器.
    // 在C语言中,传递结构体的时候,会指定结构体的长度
    // &取的是数据的起始位置,只有传递一个数据的长度,才能够保证拿到完整的结构体数据.
    // 返回值:0成功,其他都是失败.
    int connection = connect(socketNumber, (const struct sockaddr *)&serverAddress,length);
    
    if (!connection) {
        NSLog(@"连接成功%d",connection);
    }else{
        NSLog(@"连接失败");
    }
    
    /*
     发送消息到服务器
     参数:
     1> 客户端Socket.
     2> 发送内容地址.
     3> 发送内容长度.
     4> 发送方式标识,一般为0.
     
     */
    
    // 3.发送消息到服务器
    
    // 发送消息内容
    NSString *msg = @"hello socket!";
    
    msg.length :表示的是OC字符串的长度.
    msg.UTF8String :将OC字符串转换成 UTF8 的 ASCII 码,一个汉字需要占用3个字节的长度.
    strlen :计算所有 ASCII 码的长度.
    
    // 发送消息
    ssize_t result = send(socketNumber, msg.UTF8String, strlen(msg.UTF8String), 0);
    
    NSLog(@"result = %ld",result);
    
    /*
     接收服务器接返回的消息
     参数:
     1> 客户端Socket.
     2> 接收内容缓存区.
     3> 接收内容缓存区长度.
     4> 接收方式.0表示阻塞式.必须等待服务器返回数据.
     
     返回值:
     如果成功,则返回接收到的字节数.失败则返回SOCKET_ERROR
     
     */
    
    // 4.服务器接收消息
    
    // 创建接收内容缓存区.
    uint8_t buffer[1024];
    // 接受消息
    ssize_t len = recv(socketNumber, buffer, sizeof(buffer), 0);
    
    NSLog(@"len: %zd",len);
    // 取出接受内容缓存区中的数据.
    NSData *data = [NSData dataWithBytes:buffer length:len];
    // 将二进制流数据data转换成字符串类型.
    NSString *receive = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"receive:%@",receive);
    
    // 5.关闭Socket
    close(socketNumber);
}
/*---------------------------------  网络基础: 6.本地服务器的搭建 ------------------------------*/
{
    网络常识:
    本地主机IP地址:IPv4地址.    ----不通,说明网线有问题.
    本地主机回环地址:127.0.0.1.  ---不通,表示网卡不正常.
    本地主机名:localhost.       ---不通,表示网卡不正常.
    
    路由器:负责向不同的子网络传输数据.
    域名:是IP地址的一个速记符号.最终都会由DNS服务器解析成IP地址.
}
