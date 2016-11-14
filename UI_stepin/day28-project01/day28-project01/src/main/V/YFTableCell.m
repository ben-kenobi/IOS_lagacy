//
//  YFTableCell.m
//  day28-project01
//
//  Created by apple on 15/10/31.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFTableCell.h"
#import "YFTableCellF.h"
#import "YFImgVC.h"

@interface  YFTableCell ()
@property (nonatomic,weak)UILabel *labL;
@property (nonatomic,weak)UILabel *labR;

@end

@implementation YFTableCell
-(void)drawRect:(CGRect)rect{
    CGContextRef con=UIGraphicsGetCurrentContext();
    CGContextAddRect(con, (CGRect){rect.size.width*.35,0,rect.size.width*.65,rect.size.height});
    [[UIColor rgba:@[@.9,@.9,@.9,@1]] setFill];
    CGContextDrawPath(con, 0);
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initUI];
    }
    return self;
}

+(instancetype)cellWithTv:(UITableView *)tv dict:(YFTableCellF *)f idxed:(BOOL)idxed{
    static NSString *iden=@"tablecelliden";
    YFTableCell *cell=[tv dequeueReusableCellWithIdentifier:iden];
    
    if(!cell){
        cell=[[YFTableCell alloc] initWithStyle:0 reuseIdentifier:tv?iden:0];
        [cell setUserInteractionEnabled:NO];
    }
    cell.idxed=idxed;
    [cell setF:f];
    return cell;
}

-(void)setF:(YFTableCellF *)f{
    _f=f;
    [self updateUI];
}
-(void)updateUI{
    UIColor *tcolor=[UIColor colorWithRed:.4 green:.4 blue:.55 alpha:1];
    UIColor *tcolor2=[UIColor colorWithRed:.2 green:.2 blue:.9 alpha:1];
    if(_idxed){
        [self.labR setTextColor: tcolor2];
        NSAttributedString *str=[[NSAttributedString alloc] initWithString:[_f.dict[@"val"] lastPathComponent] attributes:@{NSUnderlineColorAttributeName:[UIColor blueColor],NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)}];
        [self.labR setAttributedText:str];
        [self.labR setUserInteractionEnabled:YES];
        UITapGestureRecognizer *reg=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
        [self.labR setGestureRecognizers:@[reg]];
        [self setUserInteractionEnabled:YES];
        
    }else{
        [self.labR setTextColor:tcolor];
        self.labR.text=[_f.dict[@"val"] lastPathComponent] ;
        [self.labR setUserInteractionEnabled:NO];
        [self setUserInteractionEnabled:NO];
    }
    self.labL.text=_f.dict[@"key"];
    self.labL.frame=_f.keyf;
    self.labR.frame=_f.valf;
}


-(void)onTap:(id)sender{
    if([sender isKindOfClass:[UITapGestureRecognizer class]]){
        YFImgVC *vc=[[YFImgVC alloc] init];
        vc.dict=_f.dict;
        [UIViewController pushVC:vc];
    }
}
-(void)initUI{
    
    UIView *head=[[UIView alloc] init];
    [head setBackgroundColor:[UIColor rgba:@[@.8,@.8,@.8,@1]]];
    [self addSubview:head];
    [head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.height.equalTo(@2);
    }];
    [head.layer setShadowColor:[[UIColor lightGrayColor]CGColor]];
    [head.layer setShadowOffset:(CGSize){0,.5}];
    [head.layer setShadowOpacity:.5];


    UIColor *tcolor=[UIColor colorWithRed:.4 green:.4 blue:.55 alpha:1];
    UIFont *font=[UIFont systemFontOfSize:12];
    
    UILabel *labL=[[UILabel alloc] init];
    self.labL=labL;
    [self.contentView addSubview:labL];
    [labL setTextColor:tcolor];
    [labL setFont:font];
    [labL setNumberOfLines:0];
//    [labL mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.equalTo(@(15));
//        make.bottom.lessThanOrEqualTo(@-15);
//        make.right.lessThanOrEqualTo(self.contentView).multipliedBy(.35).offset(-15);
//    }];
  
    
    UILabel *labR=[[UILabel alloc] init];
    self.labR=labR;
    [self.contentView addSubview:labR];
    [labR setTextColor:tcolor];
    [labR setFont:font];
    [labR setNumberOfLines:0];
//    [labR mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@(15));
//        make.bottom.lessThanOrEqualTo(@(-15));
//        make.left.equalTo(self.contentView.mas_right).multipliedBy(.35).offset(15);
//        make.right.lessThanOrEqualTo(@(-15));
//    }];
   
}


@end
