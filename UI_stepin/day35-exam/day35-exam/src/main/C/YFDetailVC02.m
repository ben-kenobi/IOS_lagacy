//
//  YFDetailVC02.m
//  day35-exam
//
//  Created by apple on 15/11/10.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFDetailVC02.h"
#import "YFDetailV.h"
#import "MBProgressHUD+MJ.h"


@implementation YFDetailVC02
-(void)loadView{
    self.view=[[YFDetailV alloc] init];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor orangeColor]];
    [self loadData];
}
-(void)loadData{
    [iApp setNetworkActivityIndicatorVisible:YES];
    [IUtil get:iURL(([NSString stringWithFormat:@"http://localhost/hero/getHero.php?heroId=%@",self.hid])) cache:1 callBack:^(NSData *data, NSURLResponse *response, NSError *error) {
        [iApp setNetworkActivityIndicatorVisible:NO];
        if(data&&!error){
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:0 error:0];
            [(YFDetailV *)self.view setDict:dict];
        }else{
            [MBProgressHUD showError:@"error"];
        }
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view setNeedsDisplay];
}



@end
