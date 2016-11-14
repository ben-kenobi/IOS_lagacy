//
//  UITableViewCell+Extension.m
//  day09-ui-friends2
//
//  Created by apple on 15/9/26.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "UITableViewCell+Extension.h"

#import "YFFri.h"


@implementation UITableViewCell (Extension)

+(instancetype)cellWithTv:(UITableView *)tv andFri:(YFFri *)fri{
    static NSString *iden=@"friCellIden";
    UITableViewCell *cell=[tv dequeueReusableCellWithIdentifier:iden];
    if(nil==cell){
        cell=[[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
        cell.detailTextLabel.font=[UIFont systemFontOfSize:13];
        cell.detailTextLabel.textColor=[UIColor grayColor];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    cell.imageView.image=[UIImage imageNamed:fri.icon];
    cell.textLabel.text=fri.name;
    cell.detailTextLabel.text=fri.intro;
    cell.textLabel.textColor=fri.vip?[UIColor redColor]:[UIColor blackColor];
    
    return cell;
}

@end
