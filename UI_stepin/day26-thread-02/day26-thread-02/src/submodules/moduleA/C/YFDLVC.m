//
//  YFDLVC.m
//  day26-thread-02
//
//  Created by apple on 15/10/26.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFDLVC.h"

@interface YFDLVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,weak)UITableView *tv;
@property (nonatomic,strong)NSMutableArray *datas;
@property (nonatomic,strong)NSMutableDictionary *imgs;
@property (nonatomic,strong)NSMutableDictionary *opers;
@end

@implementation YFDLVC


-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden=@"celliden";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
    if(!cell){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
    }
    
    cell.textLabel.text=self.datas[indexPath.row][@"name"];
    cell.detailTextLabel.text=self.datas[indexPath.row][@"download"];
    cell.imageView.image=[self asynDLImgAtIdx:indexPath];
    return cell;
}
-(UIImage *)asynDLImgAtIdx:(NSIndexPath *)indexPath {
    
    NSString *icon=self.datas[indexPath.row][@"icon"];

    UIImage *image=self.imgs[icon];
    if(!image){
        image=imgFromData4F([icon strByAppendToCachePath]);
        if(image)
           [self.imgs setObject:image forKey:icon];
    }
    if(image)
        return image;
    if(!self.opers[icon]){
        [self.opers setObject:@"1" forKey:icon];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [NSThread sleepForTimeInterval:1];
            UIImage *img=imgFromF(iRes(@"sound_Effect@2x.png"));
            if(img){
                [self.imgs setObject:img forKey:icon];
                [UIImagePNGRepresentation(img) writeToFile:[icon strByAppendToCachePath] atomically:YES];
            }
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.tv reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:1];
                [self.opers removeObjectForKey:icon];
            });
        });
    }
   
    
    return imgFromF(iRes(@"user_default@2x.png"));;


}



-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UITableView *tv=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tv];
    self.tv=tv;
    tv.dataSource=self;
    tv.delegate=self;
  
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
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    [self.imgs removeAllObjects];
}

@end





