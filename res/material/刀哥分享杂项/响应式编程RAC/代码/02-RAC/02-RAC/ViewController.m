//
//  ViewController.m
//  02-RAC
//
//  Created by Romeo on 15/8/31.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import "NetworkTools.h"

@interface ViewController ()
@property (nonatomic, strong) Person *person;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *demoButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

/**
 关于 pod 的源代码管理，很多公司有两种使用方法
 
 1. pod 框架不加入源代码管理
    需要程序员从服务器下载所有的代码之后，在终端执行 pod update/install，更新/安装框架
 
    好处：服务器不需要记录所有的框架文件，可以节约空间
    坏处：如果pod框架升级了，不能备份之前版本的框架文件
 
 2. pod 框架同样加入源代码管理(使用的少)
    程序员直接下载就可以使用，不需要额外的操作
 
    好处：能够备份所有pod框架的中间版本
    坏处：占用的磁盘空间大，浪费服务器的存储空间
 
    重要原因：cocoapods升级太快，导致即使把 pod 框架备份在服务器，有的时候，pod 同样不能使用
    技巧：一旦从服务器 clone 的项目无法编译，进入终端，项目文件夹下面
    `pod update`
 */
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[[NetworkTools sharedTools] request:GET URLString:@"http://localhost/YL.json" parameters:nil] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    } error:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)notificationDemo {
    // 监听通知 rac_addObserverForName
    // takeUntil 表示信号的有效期 rac_willDeallocSignal (对象被销毁的信号)，对象被销毁之前，释放通知
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil] takeUntil:[self rac_willDeallocSignal]] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}

- (void)textFieldDemo {
    [[self.textField rac_textSignal] subscribeNext:^(id x) {
        NSLog(@"%@ %@", x, [x class]);
    }];
}

// 循环引用，RAC使用的时候，循环引用特别多，只要 self. 就一定有循环引用
/**
 1. #import <ReactiveCocoa/RACEXTScope.h>
 2. block 外面 weakify(self)
 3. block 里面 strongify(self)
 
 一定记住，RAC 的 block 中，只要出现 self. 一定会强引用
 */
- (void)targetDemo {
    
    // 监听按钮的点击事件 addTarget
    @weakify(self)
    [[self.demoButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        // 强引用宏
        @strongify(self)
        
        // 当点击事件发生时，发送的消息中 x 就是按钮本身
        NSLog(@"%@", x);
        
        self.textField.text = @"hello";
    }];
}

// OC 解决循环引用的方法
/**
 block 外面 __weak typeof(self) weakSelf = self;
 block 内部 __strong typeof(weakSelf) strongSelf = weakSelf;
 调用的时候，统一使用 strongSelf
 
 有些公司会使用 __unsafe_unretained 来修饰 weakSelf，如果 self 被释放， weakSelf 仍然会记录原有的地址
 如果调用的时候使用 weakSelf，就会出现野指针
 
 因此，会有大量的 __strong 的写法
 */
- (void)targetDemo2 {
    
    // 监听按钮的点击事件 addTarget
    __unsafe_unretained typeof(self) weakSelf = self;
    [[self.demoButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        // 为了保证 block 在传出 vc后，self 被销毁，block 仍然能够正常执行
        // __strong
        // strongSelf 对 weakSelf 进行了强引用，不会影响self的引用技术
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        // 当点击事件发生时，发送的消息中 x 就是按钮本身
        NSLog(@"%@", x);
        
        // 当 block 执行完毕后，strongSelf 出了生命周期，被释放，weakSelf 也同样被释放
        strongSelf.textField.text = @"hello";
    }];
}

- (void)dealloc {
    NSLog(@"88");
}

- (void)kvoDemo {
    // 监听 person 的 name 属性
    // 本质上是使用 KVO 监听对象属性变化，一旦发生变化，会给 subscribe(订阅者) 发送 next 消息
    // 在 next 的 block 中作相应的处理
    // 使用 RACObserve 不需要在 dealloc 中移除监听者
    [RACObserve(self.person, name) subscribeNext:^(NSString *x) {
        NSLog(@"%@", x);
        
        // 模型数据发生变化，更新 UI
        self.nameLabel.text = x;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.person.name = [NSString stringWithFormat:@"zhangsan %05d", arc4random_uniform(100000)];
}

@end
