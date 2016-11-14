//
//  ViewController.m
//  day03-ui-appManagement
//
//  Created by apple on 15/9/14.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "AppMod.h"
#import "AppModViewNib.h"
#import "FlowListView.h"

#define WITH 80
#define HEIGHT 90
#define COL 3


@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)NSMutableArray *appAry;
@property (nonatomic,weak)UIScrollView *sv;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *sv=[[UIScrollView alloc] initWithFrame:self.view.frame];
    [sv setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
    [self.view addSubview:sv];
    [sv setClipsToBounds:YES];
    self.sv=sv;
    self.sv.delegate=self;
    
    
    int i,j;
    CGRect mainR=self.sv.frame;
    int gapV=40,gapH=(mainR.size.width-WITH*COL)/4;
   
    NSInteger row=self.appAry.count%COL?self.appAry.count/COL+1:self.appAry.count/COL;
    
    for(i=0;i<row;i++)
        for(j=0;j<COL&&i*COL+j<self.appAry.count;j++){
            AppMod *mod=self.appAry[i*COL+j];
            [self.sv addSubview:[self viewWithX:(j+1)*gapH+j*WITH Y:(i+1)*gapV+i*HEIGHT mod:mod]];
        }
    CGFloat contentH=(row)*(gapV+HEIGHT)+gapV;
    [self.sv setContentSize:(CGSize){0,contentH}];
    
    
//    FlowListView *lv=[[NSBundle mainBundle] loadNibNamed:@"Empty" owner:nil options:nil][1];
//    [self.view addSubview:lv];
//    lv.backgroundColor=[UIColor cyanColor];
//    for(i=0;i<self.appAry.count;i++){
//        [lv insertSubview:[self viewWithX:0 Y:0 mod:_appAry[i]] atIndex:i];
//       
//    }
    
    
    
}

-(NSArray *)appAry{
    if(nil==_appAry){
        NSArray *ary = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"mod.plist" ofType:nil]];
        
        _appAry=[NSMutableArray array];
        for(int i=0;i<ary.count;i++){
            [_appAry addObject:[AppMod appModWithDict:(NSDictionary *)ary[i]]];
        }
    }
    
    return _appAry;

}


-(UIView *)viewWithX:(int)x Y:(int)y mod:(AppMod*)mod{
    AppModViewNib *v=[[NSBundle mainBundle] loadNibNamed:@"Empty" owner:nil options:nil][0];
    [v setMod:mod andFrame:(CGRect){x,y,WITH,HEIGHT} andMainV:self.view];
  
    return v;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

   NSLog(@"%@", NSStringFromCGPoint(scrollView.contentOffset));
}



@end
