//
//  YFDLVC02.m
//  day26-thread-02
//
//  Created by apple on 15/10/26.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFDLVC02.h"

@interface YFDLVC02 ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,weak)UITableView *tv;
@property (nonatomic,strong)NSMutableArray *datas;
@property (nonatomic,strong)NSMutableDictionary *imgs;
@property (nonatomic,strong)NSMutableDictionary *opers;
@property (nonatomic,strong)NSOperationQueue *queue;

@end

@implementation YFDLVC02

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
    
    NSString *icon=dict[@"icon"];

    UIImage *img=self.imgs[icon];
    if(!img){
        img=[UIImage imageWithData:iData4F([icon strByAppendToCachePath]) scale:2];

        if(img)
           [self.imgs setObject:img forKey:icon];
    }
    if(img){
        cell.imageView.image=img;
        return cell;
    }
    cell.imageView.image=imgFromF(iRes(@"user_default@2x.png"));

    if(!self.opers[icon]){
        NSBlockOperation *bo=[NSBlockOperation blockOperationWithBlock:^{
            [NSThread sleepForTimeInterval:1];
            UIImage *img=imgFromF(iRes(@"sound_Effect@2x.png"));
            NSLog(@"-----%@",[icon strByAppendToCachePath]);
            if(img){
                [self.imgs setObject:img forKey:icon];
                [UIImagePNGRepresentation(img) writeToFile:[icon strByAppendToCachePath]  atomically:YES];
            }
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.tv reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:0];
                [self.opers removeObjectForKey:icon];
            }];
        }];
        [self.opers setObject:bo forKey:icon];
        
        [self.queue addOperation:bo];
        
    }

    
    
    
    
    return cell;
}


-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UITableView *tv=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tv];
    self.tv=tv;
    tv.delegate=self,tv.dataSource=self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self.imgs removeAllObjects];

}

-(NSMutableArray *)datas{
    if(!_datas){
        _datas=[NSMutableArray array];
        [_datas addObjectsFromArray:iRes4ary(@"apps.plist")];
    }
    return _datas;
}

iLazy4Dict(imgs,_imgs)
iLazy4Dict(opers,_opers)

-(NSOperationQueue *)queue{
    if(!_queue){
        _queue=[[NSOperationQueue alloc] init];
    }
    return _queue;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

@end
