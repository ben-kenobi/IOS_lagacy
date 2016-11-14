//
//  YFPushCon.m
//  day20-ui-lottery
//
//  Created by apple on 15/10/16.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFPushCon.h"

@interface YFPushCon ()
@property (nonatomic,weak)UIDatePicker *picker;

@end

@implementation YFPushCon



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==1||indexPath.section==2){
        UIView *v=[tableView cellForRowAtIndexPath:indexPath];
        UITextField *tf=[[UITextField alloc] init];
        [v addSubview:tf];
        UIDatePicker *picker = [[UIDatePicker alloc] init];
        picker.locale = [NSLocale localeWithLocaleIdentifier:@"zh-cn"];
        picker.datePickerMode=UIDatePickerModeTime;
        
        UIToolbar *tb=[[UIToolbar alloc] initWithFrame:(CGRect){0,0,0,44}];
        UIBarButtonItem *items[3];
        NSString *strs[]={@"hide",0,@"done"};
        for(int i=0;i<3;i++){
            if(!strs[i]){
                items[i]=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:0 action:0];
            }else{
                items[i]=[[UIBarButtonItem alloc] initWithTitle:strs[i] style:UIBarButtonItemStylePlain target:self action:@selector(onBtnClicked:)];
                items[i].tag=i+1;
            }
        
        }
        tb.items=@[items[0],items[1],items[2]];
        
        
        tf.inputView=picker;
        self.picker=picker;
        tf.inputAccessoryView=tb;
        
        [tf becomeFirstResponder];
    }
}


-(void)onBtnClicked:(id)sender{
     [super onBtnClicked:sender];
    NSInteger tag=[sender tag];
    if(tag==1){
        [self.tableView endEditing:YES];
    }else if(tag==3){
        NSDateFormatter *form=[[NSDateFormatter alloc] init];
        form.dateFormat=@"HH:mm";
        NSString *str = [form stringFromDate: self.picker.date];
        UITableViewCell *cell=[self.tableView cellForRowAtIndexPath:[self.tableView indexPathForSelectedRow]];
        
        cell.detailTextLabel.text=str;
        [self.tableView endEditing:YES];
    }
}

@end
