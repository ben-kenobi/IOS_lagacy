//
//  YFHomePopCell.m
//  day30-tuangou
//
//  Created by apple on 15/11/8.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFHomePopCell.h"

@implementation YFHomePopCell

+(instancetype)cellWithTv:(UITableView *)tv{
    static NSString *iden=@"popcelliden";
    YFHomePopCell *cell=[tv dequeueReusableCellWithIdentifier:iden];
    if(!cell){
        cell=[[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
    }
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        UIImageView *bg=[[UIImageView alloc] initWithImage:img(@"bg_dropdown_leftpart")];
        UIImageView *selbg=[[UIImageView alloc] initWithImage:img(@"bg_dropdown_left_selected")];
        self.backgroundView=bg;
        self.selectedBackgroundView=selbg;
    }
    return self;
}

@end
