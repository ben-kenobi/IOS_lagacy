//
//  YFSettingCell.m
//  day20-ui-lottery
//
//  Created by apple on 15/10/16.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFSettingCell.h"
static NSString *suitename=@"settingPref";
@interface YFSettingCell ()
@property (nonatomic,strong)NSDictionary *dict;


@end


@implementation YFSettingCell
+(instancetype)cellWithDict:(NSDictionary *)dict andTv:(UITableView *)tv{
     NSString *iden;
    
    int i=[self styleWithDict:dict iden:&iden];
    YFSettingCell *cell=[tv dequeueReusableCellWithIdentifier:iden];
    if(!cell){
        cell=[[YFSettingCell alloc] initWithStyle:i reuseIdentifier:iden];
    }
    [cell setDict:dict];
    
    return cell;
}
-(void)setDict:(NSDictionary *)dict{
    _dict=dict;
    [self updateUI];
    
}
-(void)updateUI{
   if( _dict[@"img"])
    self.imageView.image=[UIImage imageNamed:_dict[@"img"]];
    self.textLabel.text=_dict[@"title"];
    self.detailTextLabel.text=_dict[@"subtitle"];
    self.detailTextLabel.textColor=[_dict[@"isRed"] boolValue]?[UIColor redColor]:[UIColor blackColor];
    Class clz=NSClassFromString(_dict[@"acclz"]);
    id obj=[[clz alloc] init];
    if([obj isKindOfClass:[UIImageView class]]){
        [obj setImage:[UIImage imageNamed:_dict[@"acimg"]]];
        [obj sizeToFit];
    }else if([obj isKindOfClass:[UISwitch class]]){
        UISwitch *swi=obj;
        NSUserDefaults *ud=[[NSUserDefaults alloc] initWithSuiteName:suitename];
        if(_dict[@"acimg"]){
            swi.on= [ud boolForKey:_dict[@"acimg"]];
            [swi addTarget:self action:@selector(onChange:) forControlEvents:UIControlEventValueChanged];
        }
    }
    
    self.accessoryView=obj;
}


-(void)onChange:(id)sender{
    BOOL b=[(UISwitch *)sender isOn];
     NSUserDefaults *ud=[[NSUserDefaults alloc] initWithSuiteName:suitename];
    [ud setBool:b forKey:_dict[@"acimg"]];
    [ud synchronize];
}

+(UITableViewCellStyle)styleWithDict:(NSDictionary *)dict iden:(NSString **)iden{
    NSString *str=dict[@"cellstyle"];
    UITableViewCellStyle style=UITableViewCellStyleDefault;
    
     if([[str lowercaseString] isEqualToString:[@"UITableViewCellStyleValue1" lowercaseString]]){
        style=UITableViewCellStyleValue1;
    }else if([[str lowercaseString] isEqualToString:[@"UITableViewCellStyleValue2" lowercaseString]]){
        style=UITableViewCellStyleValue2;
    }else if([[str lowercaseString] isEqualToString:[@"UITableViewCellStyleSubtitle" lowercaseString]]){
        style=UITableViewCellStyleSubtitle;
    }
    
    *iden=[NSString stringWithFormat:@"settingcelliden_%ld",style];
    return style;
}

@end
