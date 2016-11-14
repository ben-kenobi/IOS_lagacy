//
//  ViewController.m
//  day02-ui-imgView
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 itheima. All rights reserved.
//
//[NSBundle mainBundle] pathForResource:]
#import "ViewController.h"
#define AryPath @"Property List.plist"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *prev;
@property (weak, nonatomic) IBOutlet UIButton *next;
@property (weak, nonatomic) IBOutlet UILabel *page;

@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (nonatomic,assign)NSInteger index;
@property (nonatomic,strong) NSArray *ary;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

   
    _index=1;

    [self updateView];
}
-(void)updateView{
    NSDictionary *dict = self.ary[_index-1];
    _page.text=[NSString stringWithFormat:@"%ld/%ld",_index,_ary.count ];
    _comment.text=dict[@"comment"];
    _imgV.image=[UIImage imageNamed:dict[@"img"]];
    
    _prev.enabled=_index>1;
    _next.enabled=_index<_ary.count;
}
- (IBAction)prev:(id)sender {
    _index--;
    [self updateView];
}
- (IBAction)next:(id)sender {
    _index++;
    [self updateView];
}
-(NSArray *)ary{
    if(nil==_ary){
        _ary=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]
                                               pathForResource:AryPath ofType:nil]];
    }
    return _ary;
}


@end
