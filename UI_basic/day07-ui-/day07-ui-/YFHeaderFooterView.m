//
//  YFHeaderFooterView.m
//  day07-ui-
//
//  Created by apple on 15/9/22.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFHeaderFooterView.h"

@interface YFHeaderFooterView ()
@property (nonatomic,weak)UIButton *add;
@property (nonatomic,weak)UIButton *del;
@property (nonatomic,weak)UITableView *tv;
@property (nonatomic,assign)CGFloat h;

@end

@implementation YFHeaderFooterView
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier tv:(UITableView *)tv andH:(CGFloat)h{
    if(self=[super initWithReuseIdentifier:reuseIdentifier]){
        self.tv=tv;
        self.h=h;
        [self initUI];
        [self initState];
        [self initListeners];
    }
    return self;
}
-(void)initState{
    
    [self updateUI];
}
-(void)initListeners{
    [self.add addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.del addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)onBtnClicked:(UIButton *)sender{
    UITableViewCellEditingStyle tag=sender.tag;
    if(tag==self.style){
        self.style=UITableViewCellEditingStyleNone;
         [self.tv setEditing:NO];
    }else{
        self.style=tag;
        [self.tv setEditing:NO];
        [self.tv setEditing:YES];
        
        
    }
    [self updateUI];
}


-(void)updateUI{
    switch(self.style){
        case UITableViewCellEditingStyleDelete:
            [self.add setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.del setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            break;
        case UITableViewCellEditingStyleInsert:
            [self.add setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [self.del setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        default:
            [self.add setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.del setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    }
}

-(void) initUI{
    UIButton *(^btnWithFrame)(CGRect,UIView *)=^(CGRect frame,UIView *supV){
        UIButton *btn=[[UIButton alloc] initWithFrame:frame];
        [btn setBackgroundColor:[UIColor colorWithRed:.7 green:.6 blue:.7 alpha:1]];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [supV addSubview:btn];
        return btn;
    };
    CGFloat wid=self.tv.frame.size.width;
    self.add=btnWithFrame((CGRect){wid-100-10,8,50,_h-16},self);
    self.del=btnWithFrame((CGRect){wid-50-5,8,50,_h-16},self);
    [self.add setTitle:@"add" forState:UIControlStateNormal];
    [self.del setTitle:@"del" forState:UIControlStateNormal];
    self.add.tag=UITableViewCellEditingStyleInsert;
    self.del.tag=UITableViewCellEditingStyleDelete;
}

@end
