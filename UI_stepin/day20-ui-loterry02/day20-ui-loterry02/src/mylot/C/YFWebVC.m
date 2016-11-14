//
//  YFWebVC.m
//  day20-ui-loterry02
//
//  Created by apple on 15/10/18.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFWebVC.h"
#import "YFWeb2VC.h"
#import "YFNavCon.h"
@interface YFButton:UIButton


@end

@implementation YFButton
-(void)setHighlighted:(BOOL)highlighted{
    [self willChangeValueForKey:@"highlighted"];
    [super setHighlighted:highlighted];
    [self didChangeValueForKey:@"highlighted"];

}

+(BOOL)automaticallyNotifiesObserversForKey:(NSString *)key{
    return NO;
}

@end
@interface  YFWebVC()<UIWebViewDelegate>
@property (nonatomic,weak)UIBarButtonItem *back;

@property (nonatomic,weak)id btn;

@property (nonatomic,weak)UIWebView *web;
@end

@implementation YFWebVC

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
    
    [self initState];
}

-(void)initState{

   [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL  fileURLWithPath:[[NSBundle mainBundle]pathForResource:self.path ofType:0]]]] ;

}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.location.href='#%@';",self.anchor]];
}

-(void)initUI{
    self.view.backgroundColor=[UIColor redColor];
    
    UIBarButtonItem *back=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"NavBack"] style:UIBarButtonItemStylePlain target:self action:@selector(onItemClicked:)];
    self.navigationItem.leftBarButtonItem=back;
    self.back=back;
    
   UIButton *btn= [[YFButton alloc] init];
    [btn setTitle:@"titletitle" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [btn sizeToFit];
    UIBarButtonItem *rbtn=[[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem=rbtn;
    self.btn=btn;
    

    [self.btn addObserver:self forKeyPath:@"highlighted" options:    NSKeyValueObservingOptionNew context:0];
    

    [btn addTarget:self  action:@selector(onItemClicked:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)dealloc{

    [self.btn removeObserver:self forKeyPath:@"highlighted"];
}


-(void)onItemClicked:(id)sender{
    if(sender==self.back){
        [self.navigationController dismissViewControllerAnimated:YES completion:0];
    }else if(sender==self.btn){
        NSLog(@"%s",object_getClassName(self.btn));
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSLog(@"%@----%@",keyPath,change);
}


-(void)loadView{
    self.view=[[UIView alloc] init];
//    self.web=(UIWebView *)self.view;
//    _web.delegate=self;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UIAlertView *aler=[[UIAlertView alloc] initWithTitle:[[NSBundle mainBundle]localizedStringForKey:@"title" value:@"" table:@"fan"] message:[[NSBundle mainBundle]localizedStringForKey:@"message" value:@"123123" table:@"fan"] delegate:0 cancelButtonTitle:[[NSBundle mainBundle]localizedStringForKey:@"btn" value:@"cancelbtn" table:@"fan"] otherButtonTitles:0, nil];

    [aler show];
}



@end
