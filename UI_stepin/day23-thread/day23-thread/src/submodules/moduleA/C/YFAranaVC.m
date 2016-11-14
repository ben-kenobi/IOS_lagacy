//
//  YFAranaVC.m
//  day23-thread
//
//  Created by apple on 15/10/23.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFAranaVC.h"
#import <pthread.h>
#import "YFSingleton.h"




@interface YFAranaVC ()<UIScrollViewDelegate,UIPickerViewDataSource>

@property (nonatomic,weak)UISegmentedControl *seg;
@property (atomic,assign)int count;
@property (nonatomic,weak)UIScrollView *sv;
@property (nonatomic,weak)UIImageView *iv;
@property (nonatomic,strong)NSOperationQueue *queue;
@property (nonatomic,strong)NSOperationQueue *queue2;
@property (nonatomic,strong)NSOperation *bo;

@property (nonatomic,weak)UIPickerView *pv;

@property (nonatomic,strong)NSTimer *timer;


@end

@implementation YFAranaVC

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return scrollView.subviews[1];
}

-(void)onBtnClicked:(id)sender{
    if(sender==self.seg){
        NSInteger idx=[sender selectedSegmentIndex];
        if(idx==0){
            [self.queue setSuspended:NO];

        }else if(idx==1){
            [self.queue setSuspended:YES];

        }
    }else if(self.timer==sender){
        [self.pv selectRow:arc4random()%100 inComponent:0 animated:YES];
        [self.pv selectRow:arc4random()%100 inComponent:1 animated:YES];
        [self.pv selectRow:arc4random()%100 inComponent:2 animated:YES];
        
    }

}
-(void)initUI{
    self.view.layer.contents=(__bridge id)[[UIImage imageNamed:@"1212312"]CGImage];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NLArenaNavBar64"] forBarMetrics:0];
    
    UISegmentedControl *seg=[[UISegmentedControl alloc] initWithItems:@[@"football",@"basketball"]];
    self.seg=seg;
    self.navigationItem.titleView=seg;
    [seg setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentSelectedBG"] forState:UIControlStateSelected barMetrics:0];
    [seg setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentBG"] forState:UIControlStateNormal barMetrics:0];
    [seg setTintColor:[UIColor clearColor]];
    
    [seg setSelectedSegmentIndex:0];
    
    [seg setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [seg setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    
    [seg addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventValueChanged];
    

    
    
    UIScrollView *sv=[[UIScrollView alloc] init];
    [self.view addSubview:sv];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.height.width.equalTo(self.view).offset(-100);
    }];
    UIView *view=[[UIView alloc] initWithFrame:(CGRect){100,100,100,100}];
    [view setBackgroundColor:[UIColor randomColor]];
    [sv addSubview:view];
    [sv setBackgroundColor:[UIColor whiteColor]];
    self.sv=sv;
    UIImageView *iv=[[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:iRes(@"guide2Background@2x.png")]];
    [sv addSubview:iv];
    [sv setContentSize:(CGSize){0,iv.h+200}];
    [sv setMinimumZoomScale:.2];
    [sv setMaximumZoomScale:3];
    sv.delegate=self;
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom);
        make.left.equalTo(@0);
    }];
    self.iv=iv;
    
    
    self.queue=[[NSOperationQueue alloc] init];
    
}




-(void)asynDLImg:(UIImageView *)iv{
    NSInteger tag=iv.tag;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *img=[UIImage imageWithData:[NSData dataWithContentsOfFile:iRes(@"guide4Background568h@2x.png")]];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(tag==iv.tag)
                iv.image=img;
        });
    });
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
        //dispatch_group_t group=dispatch_group_create();
    
//   dispatch_group_enter(group);
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"1----%@",[NSThread currentThread]);
//         dispatch_group_leave(group);
//    });
//    dispatch_group_enter(group);
//    dispatch_async( dispatch_get_global_queue(0, 0), ^{
//        
//         NSLog(@"2----%@",[NSThread currentThread]);
//        dispatch_group_leave(group);
//    });
//    
//    
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//         NSLog(@"3----%@",[NSThread currentThread]);
//    });
    
    
   

//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"file://%@",iRes(@"guide2Background@2x.png")]]]];
//         NSLog(@"%@",[NSThread currentThread]);
//        
//        dispatch_queue_t qu=dispatch_get_main_queue();
//        for(int i=0;i<20;i++){
//            dispatch_sync(qu, ^{
//                printf("%s--%d\n",[[[NSThread currentThread]description] UTF8String],i);
//    //            self.view.layer.contents=(__bridge id)[image CGImage];
//            });
//        }
//    
//    });

//    NSLog(@"%ld",self.queue.maxConcurrentOperationCount);
//    [self.queue addOperationWithBlock:^{
//        while(![self.queue isSuspended]){
//            [NSThread sleepForTimeInterval:.2];
//            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                [self.pv selectRow:arc4random()%100 inComponent:0 animated:YES];
//                [self.pv selectRow:arc4random()%100 inComponent:1 animated:YES];
//                [self.pv selectRow:arc4random()%100 inComponent:2 animated:YES];
//            }];
//            NSLog(@"%ld",self.queue.maxConcurrentOperationCount);
//            
//        }
//    }];
//    
// NSLog(@"%ld",self.queue.maxConcurrentOperationCount);
 
    
//    NSLog(@"%ld",[self.queue operationCount]);
//    [self.queue addOperationWithBlock:^{
//        for(;![self.queue isSuspended];){
//            [NSThread sleepForTimeInterval:.3];
//            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                [self.pv selectRow:arc4random()%100 inComponent:0 animated:YES];
//                [self.pv selectRow:arc4random()%100 inComponent:1 animated:YES];
//                [self.pv selectRow:arc4random()%100 inComponent:2 animated:YES];
//            }];
//            
//        }
//    }];
//    NSLog(@"%ld",[self.queue operationCount]);
//    NSBlockOperation *bo=[NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"%@",[NSThread currentThread]);
//    }];
    
    NSBlockOperation *bo1=[NSBlockOperation blockOperationWithBlock:^{
        NSLog(@" \nAAAA  %@",[NSThread currentThread]);
    }];
    NSBlockOperation *bo2=[NSBlockOperation blockOperationWithBlock:^{
        NSLog(@" \nBBB  %@",[NSThread currentThread]);
    }];
    NSBlockOperation *bo3=[NSBlockOperation blockOperationWithBlock:^{
        NSLog(@" \nCCC  %@",[NSThread currentThread]);
    }];
    NSBlockOperation *bo4=[NSBlockOperation blockOperationWithBlock:^{
        NSLog(@" \nDDD  %@",[NSThread currentThread]);
    }];
    [bo2 addDependency:bo1];
    [bo3 addDependency:bo2];
    [bo3 addDependency:bo4];
    [self.queue addOperations:@[bo1,bo2,bo3] waitUntilFinished:NO];
    [[NSOperationQueue mainQueue] addOperation:bo4];

    NSLog(@"-----------");

}


-(void)initUI2{
    UIView *view=[[UIView alloc] init];
    view.tag=11;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.height.equalTo(self.view).multipliedBy(.8);
        make.width.equalTo(self.view).multipliedBy(.8);
    }];
    [view setBackgroundColor:[UIColor randomColor]];
    NSMutableArray *ary=[NSMutableArray array];
    for(int i=0;i<3;i++){
        UIView *v=[[UIView alloc] initWithFrame:(CGRect){0,0,60,60}];
        [ary addObject:v];
        [v setBackgroundColor:[UIColor randomColor]];
    }
    layoutView(view, ary, 3,0);
    
}

-(void)initUI3{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIPickerView *pv=[[UIPickerView alloc] init];
    [pv setBackgroundColor:[UIColor randomColor]];
    [self.view addSubview:pv];
    [pv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
    [pv setDelegate:self];
    self .pv=pv;
    
    
    
    self.view.layer.contents=(__bridge id)[[UIImage imageNamed:@"1212312"]CGImage];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NLArenaNavBar64"] forBarMetrics:0];
    UISegmentedControl *seg=[[UISegmentedControl alloc] initWithItems:@[@"football",@"basketball"]];
    self.seg=seg;
    self.navigationItem.titleView=seg;
    [seg setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentSelectedBG"] forState:UIControlStateSelected barMetrics:0];
    [seg setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentBG"] forState:UIControlStateNormal barMetrics:0];
    [seg setTintColor:[UIColor clearColor]];
    
    [seg setSelectedSegmentIndex:0];
    
    [seg setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [seg setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    
    [seg addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventValueChanged];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 100;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [NSString stringWithFormat:@"%ld",row%10 ];
}

-(NSOperationQueue *)queue2{
    if(!_queue2){
        _queue2=[[NSOperationQueue alloc] init];

        [_queue setQualityOfService:NSQualityOfServiceBackground];
    }
    return _queue2;
}

-(NSOperationQueue *)queue{
    if(!_queue){
        _queue=[[NSOperationQueue alloc] init];
        [_queue setQualityOfService:NSQualityOfServiceUserInteractive];
    }
    return _queue;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI3];
}
@end
