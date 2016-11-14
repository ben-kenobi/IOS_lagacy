//
//  YFDLVC03.m
//  day26-thread-02
//
//  Created by apple on 15/10/26.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFDLVC03.h"

@interface YFDLVC03 ()
@property (nonatomic,strong)NSMutableArray *datas;
@property (nonatomic,strong)NSMutableDictionary *imgs;
@property (nonatomic,strong)NSMutableDictionary *opers;
@end

@implementation YFDLVC03




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden=@"celliden";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
    if(!cell){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
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

    if(img)
        return img;
    
    if(!self.opers [icon]){
        [self.opers setObject:@"1" forKey:icon];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [NSThread sleepForTimeInterval:1];
            UIImage *img=imgFromF(iRes( @"sound_Effect@2x.png"));

            if(img){
                [UIImagePNGRepresentation(img) writeToFile:[icon strByAppendToCachePath] atomically:YES];
                [self.imgs setObject:img forKey:icon];
            }
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.tableView reloadRowsAtIndexPaths:@[ip] withRowAnimation:1];
                [self.opers removeObjectForKey:icon];
            });

        });
    }
    
    
    
    return imgFromF(iRes(@"user_default@2x.png"));
}


-(NSMutableArray *)datas{
    if(!_datas){
        _datas=[NSMutableArray array];
        [_datas addObjectsFromArray:iRes4ary(@"apps.plist")];
    }
    return _datas;
}

iLazy4Dict(imgs, _imgs)
iLazy4Dict(opers, _opers)

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.tableView setRowHeight:80];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    [self.imgs removeAllObjects];
}



@end
