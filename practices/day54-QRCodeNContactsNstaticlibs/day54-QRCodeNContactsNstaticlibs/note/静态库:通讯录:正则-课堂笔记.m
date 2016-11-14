//#pragma mark - 一. 静态库
//
//1. 模拟器运行没问题, 真机运行崩溃. 真机运行没问题, 模拟器崩溃
//2. 隐藏核心实现代码
//3. 如何制作自己的Framework框架
//
//#pragma mark 1. 创建.a静态库 (理解)
//1. 创建库的时候注意选择的是Framework & Library的静态库
//2. 创建成功, 默认会有一对.h和.m文件.
//3. 如果要新增工具类, 要注意头文件的导出问题 --> 选中项目 --> Build Phases --> Copy Files --> 添加需要导出的头文件
//4. 如果是静态库, 不会运行起来程序. 需要模拟器和真机分别编译一次. 此时Products里的东西就会变黑, 可以右键打开查看.
//5. 如果类有很多个, 我们可以提供一个.h专门导入其他的头文件, 方便开发者导入框架
//
//
//#pragma mark 2. 测试静态库(重点)
//一. 常见错误
//Undefined symbols for architecture x86_64 (i386 / armv7 / armv7s / arm64)
//architecture: 架构
//找不到的符号在 X86_64架构上
//解决方案: 看看是否导入了正确的架构包 --> 开发中一定要注意模拟器和真机不同的问题
//
//二. 架构的种类
//iPhone 5S 才有的64位架构
//架构是向下兼容的
//1. 模拟器:
//32位: i386     4s ~ 5
//64位: x86_64   5s ~ 6s
//
//2. 真机
//armv7 :  4 ~ 4s
//armv7s : 5 / 5c
//arm64 :  5s ~ 6s
//
//三. 查看架构
//
//查看架构命令: lipo -info 静态库.a
//
//1. 模拟器在编译生成时, 默认生成1个
//2. 真机在编译生成时, 默认是2个.
//3. 模拟器编译时, 不同的模拟器, 能编译出不同的架构
//
//四. 合成架构
//1. 模拟器合成多种架构
//方式一: 点击项目 --> Build Settings --> 只编译当前激活的架构 --> Debug --> NO
//方式二: lipo -create 静态库1.a 静态库2.a -output 新静态库.a
//示例:lipo -create libHMLib.a  Debug-iphonesimulator/libHMLib.a -output HMLib.a
//
//2. 模拟器和真机合并 --> 现在合并之后只有4种架构 (7S架构无所谓)
//在执行一次合并命令
//
//3. armv7s 是针对iPhone5 专门推出的架构. 但是实际效果并不好. 相当于失败品.
//在2014年10月份, xcode 版本更新, 去掉了armv7s的默认输出
//如果想要支持7s, 需要手动添加 要输出的架构
//
//五. 真机和模拟器合并的优缺点
//合并优点 : 方便开发调试, 不需要频繁切换真机/模拟器的包 示例: 友盟分享
//合并缺点 : 体积过大 示例: 百度地图合并大概50M
//
//六. Release 和 Debug 的区别
//Debug   : 调试模式. 系统会有大量的调试代码
//Release : 发布模式. 打包时, 会去掉调试代码以及其他一些看不见的小优化, 此时静态库, 文件变小, 速度变快. 但是对用户来讲, 体验不明显
//
//打包时, 应该使用Release的文件
//
//#pragma mark 3. 添加资源文件
//需要手动创建一个.bundle文件夹. 导入.a静态库中开发
//可以避免资源图片重名的问题.
//
//#pragma mark 4. 边开发边调试.a静态库
//1. 创建普通项目, 在添加一个target
//2. 实现工具类方法
//3. 在普通项目中 添加.a, 然后在需要的地方导入头文件直接使用即可.
//
//如果只是调试. 并不需要对.a进行编译
//如果需要导出静态库, 那么应该切换到对应的target下, 然后按照之前所学进行导出
//
//#pragma mark 5. 创建.framework静态库
//xcode6之前, 系统没有framework的模板. 要创建也可以, 需要找到第三方的模板来创建.
//xcode6以后, 各大SDK厂商, 都逐渐开始使用Framework来进行开发
//
//1. 创建库的时候注意选择的是Framework & Library的 Framework
//2. 创建成功, 默认只有一个.h
//    2.1 我们应该在这个.h导入所有需要公开的头文件
//    2.2 在使用的时候, 我们应该使用 <> 来导入 --> 系统导入的方式
//3. 进行常规的开发, 注意导出时, 需要查看头文件是否导出 --> 点击项目--> target --> Build Phases --> Headers--> 将Project里的头文件, 拖拽到Public中
//4. 创建之后, 默认是动态库, 如果想转换成静态库 , Build Settings --> Mach-O Type  --> 需要改成Static Library
//
//#pragma mark 6. 测试Framework
//1. 如果Framework是动态库, 一般运行会报错, 此时需要在 项目--> target --> General --> Embedded Binaries --> 添加要导出的动态库. 然后即可运行
//2. 如果Framework是静态库, 跟普通的使用方式是一样的, 不需要有什么注意点
//
//3. 如果要合并Framework的真机和模拟器的包. 需要合并的是framework文件夹内的, 同名文件(也就是没有后缀的那个文件) . 合并之后, 将合成的文件, 替换到任意文件夹内即可.
//
//4.  如果想要一边开发一边调试也是可以的. 注意头文件的导出, 然后在普通项目中就可以进行开发. 开发时, 可以使用<>, 以及""进行头文件的导入
//
//
//#pragma mark - 二. 通讯录
//
//#pragma mark 1. iOS9通讯录
//导入ContactsUI
//1. 创建联系人控制器
//    1.1. 创建联系人选择视图控制器
//    1.2. 设置代理
//    1.3. 弹出控制器
//2. 代理方法中, 打印contact对象, 来获取值(查看头文件)
//
//#pragma mark 2. 通讯录有界面
//面试题: Foundation框架和Core Foundation框架桥接的方式
//三种方式
//
//// 下面两种都是 Core Foundation对象 桥接到 Foundation中
//__bridge : 最简单的桥接: 将CF对象暂时给了Foundation, 但是没有移交所有权
//__bridge_transfer / CFBridgingRelease : 将CF对象暂时给了Foundation, 还移交了对象所有权 --> 如果对象的所有权给了Foundation框架, 就会有ARC机制来管理对象的内存问题
//
//// 还有一种情况 是 Foundation对象 桥接到  Core Foundation中
//__bridge_retained  : 此种方式, 将是Foundation对象给CF框架使用, 注意, 这种情况一般不会遇到, 面试的时候, 简单答一下就可以
//
//1. 获取姓名: ABRecordCopyValue
//
//2. 获取电话
//    2.1 ABRecordCopyValue 获取所有电话
//    2.2 ABMultiValueGetCount 获取个数
//    2.3 遍历phones数组 --> 不能使用forin循环
//    2.4 ABMultiValueCopyLabelAtIndex : 获取标签名
//    2.5 ABMultiValueCopyValueAtIndex : 获取电话值
//
//#pragma mark 3. 通讯录无界面
//一. 通讯录授权 一定要写, 否则可能上架被拒
//1. 获取授权状态
//2. 判断是否授权, 没有授权才应该进行授权
//3. 进行授权
//    3.1 创建通讯录对象 --> 创建==获取
//    3.2 调用授权方法
//
//二. 获取所有联系人信息
//1. 判断用户是否授权了 只有授权了才能执行对应的方法
//2. 获取通讯录信息
//3. 获取通讯录的联系人信息: ABAddressBookCopyArrayOfAllPeople
//4. 获取个数 : CFArrayGetCount
//5. 遍历联系人信息: CFArrayGetValueAtIndex
//6. 获取姓名
//7. 获取电话
//8. 一定要注意CoreFoundation的对象释放问题 --> Create / Copy
//
//#pragma mark 4. 使用第三方类库实现通讯录
//
//
//
//#pragma mark - 三. 正则表达式入门
//
//#pragma mark - 四. 二维码
//二维码iOS7 才有的自带的
//以前在iOS平台上流行2个框架 ZBar ZXing
//1. 输入设备AVCaptureDeviceInput
//2. 输出设备 (解析输入的内容)AVCaptureMetadataOutput
//3. 会话类绑定输入和输出设备
//4. 设置代理 --> 获取数据
//5. 设置扫描的类型 --> 二维码 QRCode
//6. 展示扫描到的内容的layer --> 需要设置session
//7. 开始扫描
//
//8. 代理方法中进行解析
//    8.1. 停止扫描
//    8.2. 删除layer
//    8.3. 获取数据 AVMetadataMachineReadableCodeObject 头文件没提示
//
//
//
//
//
//
//
//
