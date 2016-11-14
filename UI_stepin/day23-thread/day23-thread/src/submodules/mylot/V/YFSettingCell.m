//
//  YFSettingCell.m
//  day20-ui-loterry02
//
//  Created by apple on 15/10/18.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFSettingCell.h"

static NSString *suitname=@"settingPref";

@interface YFSettingCell()
@property (nonatomic,strong)NSDictionary *dict;
@end

@implementation YFSettingCell

+(instancetype)cellWithTv:(UITableView *)tv dict:(NSDictionary *)dict{
    NSString *iden;
    NSInteger style=[self styleBy:dict[@"cellstyle"] iden:&iden];
    YFSettingCell *cell=[tv dequeueReusableCellWithIdentifier:iden];
    if(!cell){
        cell=[[YFSettingCell alloc] initWithStyle:style reuseIdentifier:iden];
    }
    [cell setDict:dict];
    return cell;
}




-(void)setDict:(NSDictionary *)dict{
    _dict=dict;
    [self updateUI];
}

-(void)updateUI{
    self.textLabel.text=_dict[@"title"];
    if(_dict[@"img"])
        self.imageView.image=[UIImage imageNamed:_dict[@"img"]];
    self.detailTextLabel.text=_dict[@"subtitle"];
    self.detailTextLabel.textColor=[_dict[@"isRed"] boolValue]?
    [UIColor redColor]:[UIColor blackColor];
    
    id ac=[[NSClassFromString(_dict[@"acclz"]) alloc] init];
    if([ac isKindOfClass:[UIImageView class]]){
        [ac setImage:[UIImage imageNamed:_dict[@"acimg"]]];
        [ac sizeToFit];
    }else if([ac isKindOfClass:[UISwitch class]]){
        UISwitch *sw=ac;
        if(_dict[@"acimg"])
            sw.on=[[[NSUserDefaults alloc] initWithSuiteName:suitname] boolForKey:_dict[@"acimg"]];
        [sw addTarget:self action:@selector(onChange:) forControlEvents:UIControlEventValueChanged];

    }
    self.accessoryView=ac;
    
}

-(void)onChange:(id)sender{
    if(_dict[@"acimg"]){
        NSUserDefaults *ud=  [[NSUserDefaults alloc] initWithSuiteName:suitname];
        [ud setBool:[sender isOn] forKey:_dict[@"acimg"]];
        [ud synchronize];
    }
}


+(UITableViewCellStyle)styleBy:(NSString *)str iden:(NSString **)iden{
    UITableViewCellStyle style=UITableViewCellStyleDefault;
    str=[str lowercaseString];
    if([str isEqualToString:[@"UITableViewCellStyleValue1" lowercaseString]]){
        style=UITableViewCellStyleValue1;
    }else if([str isEqualToString:[@"UITableViewCellStyleValue2" lowercaseString]]){
        style=UITableViewCellStyleValue2;
    }else if([str isEqualToString:[@"UITableViewCellStyleSubtitle" lowercaseString]]){
        style=UITableViewCellStyleSubtitle;
    }
    
    *iden=[NSString stringWithFormat:@"settingcelliden_%ld",style];
    return style;
}

@end
