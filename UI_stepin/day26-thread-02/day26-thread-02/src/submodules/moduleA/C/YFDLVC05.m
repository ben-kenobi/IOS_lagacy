//
//  YFDLVC05.m
//  day26-thread-02
//
//  Created by apple on 15/10/27.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFDLVC05.h"
#import "YFOper.h"
#import "YFDipatcher.h"
#import "YFDispatcher02.h"
#import "UIImageView+WEB.h"
#import "UIImageView+WebCache.h"
#import "UIImage+GIF.h"
#import "objc/runtime.h"


@interface YFDLVC05()<UITableViewDataSource,UITableViewDelegate,NSCacheDelegate>


@property (nonatomic,weak)UITableView *tv;
@property (nonatomic,strong)NSMutableArray *datas;
@property (nonatomic,strong)YFDipatcher *disp;
@property (nonatomic,weak)UIImageView *iv;
@property (nonatomic,strong)NSCache *imgs;


@end

@implementation YFDLVC05


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden=@"celliden";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
    if(!cell){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:iden];
    }
    NSDictionary *dict=self.datas[indexPath.row];
    cell.textLabel.text=dict[@"name"];
    cell.detailTextLabel.text=dict[@"download"];
//    cell.imageView.image=[self.disp02 asynDLImg:dict[@"icon"] onComp:^(UIImage *img) {
//        [self.tv reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:3];
//    }];
    [cell.imageView asynDL:dict[@"icon"] def:img(@"user_default@2x.png") ];

//    [cell.imageView sd_setImageWithURL:iURL(([NSString stringWithFormat:@"file://%@",iRes(@"sb.gif")])) placeholderImage:img(@"user_default@2x.png") options:SDWebImageRetryFailed  progress:nil completed:nil];
//    NSLog(@"%@",NSHomeDirectory());
    return cell;
}


-(void)initUI2{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIImageView *iv=[[UIImageView alloc] init];
    [self.view addSubview:iv];
    self.iv=iv;
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.height.equalTo(@100);
    }];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    static int i=0;
    
    NSString *str=[NSString stringWithFormat:@"TabBar%dSel",(i++%5)+1];
//    [self.iv asynDL:str def:img(@"user_default@2x.png")];
    
//      NSLog(@"%@",  [NSString stringWithFormat:@"file://%@",[[NSBundle mainBundle] pathForResource:@"sb.gif" ofType:nil]]);
    
    UIImage *imgs=[UIImage sd_animatedGIFNamed:@"sb"];
    self.iv.image=imgs;
    
    for (int i = 0; i < 10 ; i++) {
        [self.imgs setObject:@"123" forKey:[NSString stringWithFormat:@"%i",i]];
    }
    [self.imgs setObject:@"123" forKey:@"123"];
    [self.imgs removeAllObjects];
    [self.imgs setObject:@"qqqq" forKey:@"222"];
    NSLog(@"%@",[self.imgs objectForKey:@"222"]);
   
}


- (void)cache:(NSCache *)cache willEvictObject:(id)obj{\

    NSLog(@"------%@",obj);

}
-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UITableView *tv=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tv];
    self.tv=tv;
    [tv setRowHeight:80];
    tv.delegate=self;
    tv.dataSource=self;
   
}

-(void)viewDidAppear:(BOOL)animated{
   
}

-(NSMutableArray *)datas{
    if(!_datas){
        _datas=[NSMutableArray array];
        [_datas addObjectsFromArray:iRes4ary(@"apps.plist")];
    }
    return  _datas;
}


-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}
-(YFDipatcher *)disp{
    if(!_disp){
        _disp=[[YFDipatcher alloc] init];
        [_disp setDefimg:imgFromData4F(iRes(@"user_default@2x.png"))];
    }
    return _disp;
}
-(NSCache *)imgs{
    if(!_imgs){
        _imgs=[[NSCache alloc] init];
        [_imgs setCountLimit:10];
        _imgs.delegate=self;
    }
    return _imgs;
}


-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    [[self.disp imgs] removeAllObjects];
}

@end
