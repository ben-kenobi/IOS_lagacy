//
//  YFDLVC04.m
//  day26-thread-02
//
//  Created by apple on 15/10/27.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFDLVC04.h"

@interface YFDLVC04 ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak)UITableView *tv;
@property (nonatomic,strong)NSMutableArray *datas;
@property (nonatomic,strong)NSMutableDictionary *imgs;
@property (nonatomic,strong)NSMutableDictionary *opers;

@end

@implementation YFDLVC04


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden=@"celliden";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
    if(!cell){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:iden];
    }
    NSDictionary *dict=self.datas[indexPath.row];
    cell.textLabel.text=dict[@"name"];
    cell.detailTextLabel.text=dict[@"download"];
    cell.imageView.image=[self asynDLImg:indexPath];
    
    
    return cell;
}

-(UIImage *)asynDLImg:(NSIndexPath *)ip{
    NSString *icon=self.datas[ip.row][@"icon"];
    UIImage *img=self.imgs[icon];
    if(!img){
        img=imgFromData4F([icon strByAppendToCachePath]);
        if(img)
           [self.imgs setObject:img forKey:icon];
    }
    NSLog(@"%@",[icon strByAppendToCachePath]);
    if(img)
        return img;
    if(!self.opers[icon]){
        [self.opers setObject:@"" forKey:icon];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [NSThread sleepForTimeInterval:1];
            UIImage *img=imgFromF(iRes(@"sound_Effect@2x.png"));
            if(img){
                [self.imgs setObject:img forKey:icon];
                [UIImagePNGRepresentation(img) writeToFile:[icon strByAppendToCachePath] atomically:YES];
            }
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.tv reloadRowsAtIndexPaths:@[ip] withRowAnimation:1];
                [self.opers removeObjectForKey:icon];
            });
        });
        
        
    }
    
    
    
    return imgFromData4F(iRes(@"user_default@2x.png"));
}


-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UITableView *tv=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tv];
    self.tv=tv;
    [tv setRowHeight:80];
    tv.delegate=self;
    tv.dataSource=self;
    
}

-(NSMutableArray *)datas{
    if(!_datas){
        _datas=[NSMutableArray array];
        [_datas addObjectsFromArray:iRes4ary(@"apps.plist")];
    }
    return  _datas;
}

iLazy4Dict(imgs, _imgs)
iLazy4Dict(opers, _opers)

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}


-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    [self.imgs removeAllObjects];
}
@end
