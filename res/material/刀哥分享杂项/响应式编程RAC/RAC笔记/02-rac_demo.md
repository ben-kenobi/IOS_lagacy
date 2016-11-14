# RAC 演练

## 准备工作

* 新建项目
* 进入终端，建立 `Podfile`，并且输入以下内容

```
pod 'ReactiveCocoa'
```

* 在终端输入以下命令安装框架

```bash
$ pod install
```

* 打开 `项目名称.xcworkspace`
* 导入头文件

```objc
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
```

## 监听事件

* 监听 `textField` 文本输入

```objc
[[self.textField rac_textSignal] subscribeNext:^(id x) {
    NSLog(@"%@", x);
}];
```

* 监听按钮点击事件

```objc
- (void)setupDemoButton {
    [[self.demoButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"tip" message:@"please input message" preferredStyle:UIAlertControllerStyleAlert];

        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

            [self dismissViewControllerAnimated:YES completion:nil];
        }]];

        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

            self.textField.text = [alert textFields][0].text;
        }]];

        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入银行密码";
        }];

        [self presentViewController:alert animated:YES completion:nil];
    }];
}
```

### 循环引用

* 导入头文件

```objc
#import <ReactiveCocoa/RACEXTScope.h>
```

* 增加 weakify & strongify

```objc
- (void)setupDemoButton {

    @weakify(self)
    [[self.demoButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"tip" message:@"please input message" preferredStyle:UIAlertControllerStyleAlert];

        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

            [self dismissViewControllerAnimated:YES completion:nil];
        }]];

        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

            self.textField.text = [alert textFields][0].text;
        }]];

        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入银行密码";
        }];

        [self presentViewController:alert animated:YES completion:nil];
    }];

    [[self.textField rac_willDeallocSignal] subscribeCompleted:^{
        NSLog(@"dealloc");
    }];
}
```

## 监听文本代理

* 定义代理属性

```objc
@property (nonatomic, strong) RACDelegateProxy *proxy;
```

* 监听代理方法

```objc
self.proxy = [[RACDelegateProxy alloc] initWithProtocol:@protocol(UITextFieldDelegate)];
[[self.proxy rac_signalForSelector:@selector(textFieldShouldReturn:)] subscribeNext:^(RACTuple *tuple) {
    UITextField *text = tuple.first;

    NSLog(@"%@", text);
}];
self.textField.delegate = (id<UITextFieldDelegate>)self.proxy;
```

## 观察对象属性变化

```objc
self.person = [[Person alloc] init];
@weakify(self)
[RACObserve(self.person, name) subscribeNext:^(NSString *str) {
    @strongify(self)
    self.textField.text = str;
}];

[[self.demoButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
    @strongify(self)
    self.person.name = [NSString stringWithFormat:@"zhangsan - %05d", arc4random_uniform(100000)];;
}];
```

## 监听通知

* 以下代码会在视图控制器被销毁时，自动删除通知

```objc
[[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil] takeUntil:[self rac_willDeallocSignal]] subscribeNext:^(id x) {
    NSLog(@"%@", x);
}];
```

* 说明 `[self rac_willDeallocSignal]` 是对象被销毁通知






