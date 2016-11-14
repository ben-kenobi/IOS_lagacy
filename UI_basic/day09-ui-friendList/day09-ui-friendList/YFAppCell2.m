//
//  YFAppCell2.m
//  day09-ui-friendList
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFAppCell2.h"
#import "YFApp.h"
@interface YFAppCell2 ()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *textlab;

@property (weak, nonatomic) IBOutlet UILabel *detaillab;
@property (weak, nonatomic) IBOutlet UIButton *download;

@end

@implementation YFAppCell2

+(instancetype)cellWithTv:(UITableView *)tv andMod:(YFApp *)mod{
    static NSString *iden=@"appiden2";
    YFAppCell2 *cell=[tv dequeueReusableCellWithIdentifier:iden];
    
    [cell setMod:mod];
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
    }
    return self;
}



-(void)setMod:(YFApp *)mod{
    _mod=mod;
    [self updateUI];
    
}
-(void)updateUI{
    self.img.image=[UIImage imageNamed:_mod.icon];
    self.textlab.text=_mod.name;
    self.detaillab.text=[NSString stringWithFormat:@"以下载:%@，大小:%@",_mod.download,_mod.size];
    [self.download setEnabled:!self.mod.downloaded];
    
}
- (IBAction)onBtnClicked:(UIButton *)sender {
    self.mod.downloaded=YES;
    [self.download setEnabled:NO];
}


@end
