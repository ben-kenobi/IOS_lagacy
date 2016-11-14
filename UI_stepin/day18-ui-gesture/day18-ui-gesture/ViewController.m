//
//  ViewController.m
//  day18-ui-gesture
//
//  Created by apple on 15/10/13.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"

#import "Masonry.h"
#import "UIColor+Extension.h"
#import "UIImage+Ex.h"
#import "YFV.h"
#import "YFDrawPad.h"
#import "Aoo.h"
#import "YFToolPad.h"
#import "YFLockPad.h"

@interface ViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong)UIImageView *iv;
@property (nonatomic,strong)UIImageView *iv2;
@property (nonatomic,strong)UIImageView *iv3;
@property (nonatomic,weak)CALayer *layer;
@property (nonatomic,weak)CALayer *hour;
@property (nonatomic,weak)CALayer *minute;

//UI5
@property (nonatomic,weak) UIToolbar *tb;
@property (nonatomic,weak) YFDrawPad *drawp;
@property (nonatomic,weak) YFToolPad *tp;


//UI7
@property (nonatomic,weak)YFLockPad *lockp;
@end

@implementation ViewController


-(void)loadView{
    self.view=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI7];

    
}


-(void)initUI7{
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Home_refresh_bg"]]];
    
    YFLockPad *lockp=[[YFLockPad alloc] init];
    [self.view addSubview:lockp];
    self.lockp=lockp;
    [lockp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(self.view.mas_width).multipliedBy(.9);
        make.center.equalTo(self.view);
    }];
    [lockp setBackgroundColor:[UIColor clearColor]];
    
    [lockp setOnfinish:^BOOL(NSString *str) {
        BOOL b=0;
        
        if ([@"012" isEqualToString:str]) {
            b=YES;
            UIAlertController *aler=[UIAlertController alertControllerWithTitle:@"alert" message:@"success" preferredStyle:1];
            [aler addAction:[UIAlertAction actionWithTitle:@"OK" style:1 handler:0]];
            [self presentViewController:aler animated:YES completion:0];
        }else{
            
        }
        return b;
    } complete:^{
        [self saveV:self.lockp];
    }];
    
    
    
    UIImageView *iv=[[UIImageView alloc] init];
    [self.view addSubview:iv];
    self.iv=iv;
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.width.height.equalTo(lockp).multipliedBy(.3);
        make.top.equalTo(@10);
    }];
    
    
}
-(void)saveV:(UIView *)v{
    UIGraphicsBeginImageContextWithOptions(v.bounds.size, 0, 0);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    self.iv.image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)initUI5{
    [self.view setBackgroundColor:[UIColor grayColor]];
    UIToolbar *tb=[[UIToolbar alloc] init];
    self.tb=tb;
    [self.view addSubview:tb];
    [tb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.height.equalTo(@40);
    }];
    
    NSString *titles[]={@"clear",@"eraser",@"undo",@"redo",@"save"};
    UIBarButtonItem *items[5];
    
    for(int i=0;i<5;i++){
        items[i]=[[UIBarButtonItem alloc] initWithTitle:titles[i] style:0 target:self action:@selector(onItemBtnClicked:)];
        items[i].tag=i+1;
    }
    UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:@selector(onItemBtnClicked:)];
    tb.items=[NSArray arrayWithObjects:items[0],items[1],items[2],items[3],item,items[4],nil];
    
    YFToolPad *tp=[[YFToolPad alloc] init];
    self.tp=tp;
    [self.view addSubview:tp];
    [tp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@100);
    }];
    [tp setBackgroundColor:[UIColor orangeColor]];
    
    [tp setColorChange:^{
        [self.drawp setEs:0];
    }];
    
    YFDrawPad *drawp=[[YFDrawPad alloc] init];
    [self.view addSubview:drawp];
    self.drawp=drawp;
    self.drawp.window.layer.backgroundColor=[[UIColor clearColor] CGColor];
    self.drawp.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [drawp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(tb.mas_bottom);
        make.bottom.equalTo(tp.mas_top);
    }];
    
    [drawp setGetWid:^CGFloat{
        return self.tp.slider.value*30+.1;
    }];
    [drawp setGetColor:^UIColor *{
        return self.tp.curBtn.backgroundColor;
    }];
    
}



-(void)onItemBtnClicked:(id)sender{
    if([sender respondsToSelector:@selector(backgroundColor)]){
        [self.drawp setEs:0];
        UIColor *color=[sender backgroundColor];
        self.drawp.linecolor=color;
    }else{
        NSInteger tag=((UIBarButtonItem *)sender).tag;
        switch (tag) {
            case 1:
                [self.drawp clear];
                break;
            case 2:
//                [self.drawp setLinecolor:[UIColor blackColor]];
                [self.drawp setEs:1];
                break;
            case 3:
                [self.drawp undo];
                break;
            case 4:
                [self.drawp redo];
                break;
            case 5:
                [self saveLayer:self.drawp.layer];
                break;
            
        }
    }
    
}


-(void)saveLayer:(CALayer *)layer{
    UIGraphicsBeginImageContextWithOptions(layer.bounds.size, 0, 0);
    CGContextRef con=UIGraphicsGetCurrentContext();
    [layer renderInContext:con];
    UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(img, 0, 0, 0);
}




-(void)initUI6{
    CALayer *layer=[[CALayer alloc] init];
    layer.bounds=(CGRect){0,0,100,100};
    layer.position=self.view.center;
    layer.backgroundColor=[[UIColor blueColor]CGColor];
    self.layer=layer;
    
    CALayer *hour=[[CALayer alloc] init];
    hour.bounds=(CGRect){0,0,200,200};
    hour.position=(CGPoint){100,400};
    self.hour=hour;
    hour.backgroundColor=[[UIColor orangeColor] CGColor];
    
    
    self.view.layer.backgroundColor =[[UIColor colorWithPatternImage:[UIImage imageNamed:@"scene"]] CGColor];
    [self.view.layer addSublayer:self.layer];
    [self.view.layer addSublayer:self.hour];
    
    UIImageView *ivs[3];
    for (int i=0; i<3; i++) {
        ivs[i]=[[UIImageView alloc] initWithFrame:(CGRect){100,100,200,200}];
        UIImageView *prev;
        ivs[i].layer.borderWidth=5;
        ivs[i].layer.borderColor=[[UIColor yellowColor] CGColor];
        [ivs[i] setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:ivs[i]];
        
        if(i)
            prev=ivs[i-1];
        [ivs[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(self.view).multipliedBy(.25);
            if(!i){
                make.leading.equalTo(@20);
            }else{
                make.leading.equalTo(prev.mas_right).offset(20);
            }
            make.bottom.equalTo(@-10);
        }];
    }
    self.iv=ivs[0];
    self.iv2=ivs[1];
    self.iv3=ivs[2];
    [self.layer addSublayer:self.iv3.layer];
    
    
    NSLog(@"%ld",self.view.layer.sublayers.count);
    
    
}


-(void)initUI3{
    UIImageView *iv=[[UIImageView alloc] init];
    [self.view addSubview:iv];
    self.iv=iv;
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.equalTo(@0);
        make.height.width.equalTo(@200);
    }];
    [iv setBackgroundColor:[UIColor cyanColor]];
    [iv setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture:)];
    [iv addGestureRecognizer:tap];
    [self.iv setImage:[UIImage imageNamed:@"scene"]];
    
    UISwipeGestureRecognizer *swip=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gesture:)];
    UISwipeGestureRecognizer *swip2=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gesture:)];
    swip2.direction=2;
    UISwipeGestureRecognizer *swip3=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gesture:)];
    swip3.direction=4;
    UISwipeGestureRecognizer *swip4=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gesture:)];
    swip4.direction=8;
    [iv addGestureRecognizer:swip];
    [iv addGestureRecognizer:swip2];
    [iv addGestureRecognizer:swip3];
    [iv addGestureRecognizer:swip4];
    
    CALayer *layer=[[CALayer alloc] init];
    self.layer=layer;
    [self.view.layer addSublayer:layer];
    layer.bounds=(CGRect){0,0,100,100};
    layer.position=self.view.layer.position;
    layer.backgroundColor=[[UIColor redColor] CGColor];
    layer.contents=(__bridge id)[[UIImage imageNamed:@"scene"] CGImage];
    
}

-(void)initUI2{
    [self.view.layer setBackgroundColor:[[UIColor randomColor] CGColor]];
    
    CALayer *clock=[[CALayer alloc] init];
    UIImage *img=[UIImage imageNamed:@"clock"];
    clock.bounds=(CGRect){0,0,200,200};
    clock.cornerRadius=100;
    clock.masksToBounds=YES;
    clock.position=self.view.center;
    clock.contents=(__bridge id)[img CGImage];
    
    [self.view.layer addSublayer:clock];
    
    
    CALayer *layer=[[CALayer alloc] init];
    self.layer=layer;
    layer.bounds=(CGRect) {0,0,2,80};
    layer.position=self.view.center;
    layer.anchorPoint=(CGPoint){.5,.75};
    layer.backgroundColor=[[UIColor redColor]CGColor];
    layer.cornerRadius=2;
    
    CALayer *minute=[[CALayer alloc]init];
    self.minute=minute;
    minute.bounds=(CGRect){0,0,5,75};
    minute.position=self.view.center;
    minute.anchorPoint=(CGPoint){.5,.75};
    minute.backgroundColor=[[UIColor blackColor]CGColor];
    minute.cornerRadius=3;
    
    CALayer *hour=[[CALayer alloc] init];
    self.hour=hour;
    hour.bounds=(CGRect){0,0,5,60};
    hour.position=self.view.center;
    hour.anchorPoint=(CGPoint){.5,.75};
    hour.backgroundColor=[[UIColor blackColor]CGColor];
    hour.cornerRadius=3;
    
    CALayer *cp=[[CALayer alloc] init];
    cp.bounds=(CGRect){0,0,4,4};
    cp.position=self.view.center;
    cp.backgroundColor=[[UIColor orangeColor] CGColor];
    cp.cornerRadius=2;
    
    [self.view.layer addSublayer:hour];
    [self.view.layer addSublayer:minute];
    [self.view.layer addSublayer:layer];
    [self.view.layer addSublayer:cp];
    
    [self runSecond];
    
    
    CADisplayLink *dl=[CADisplayLink displayLinkWithTarget:self selector:@selector(runSecond)];
    [dl addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}
-(void)runSecond{
    
    NSInteger count=(NSInteger)([NSDate timeIntervalSinceReferenceDate]*10);
    NSInteger sec= count%600;
    NSInteger minute= count%(60*600)/600;
    NSInteger hour= (count%(12*60*600)/(60*600)+8)%12;
   
//    NSInteger sec=[can component:NSCalendarUnitSecond fromDate:[NSDate date]];
    
    self.layer.affineTransform=CGAffineTransformMakeRotation( 2*M_PI/600*sec);
    self.minute.affineTransform=CGAffineTransformMakeRotation( 2*M_PI/(60*600)*(minute*600+sec));
    self.hour.affineTransform=CGAffineTransformMakeRotation( 2*M_PI/(12*600*60)*((hour*60+minute)*600+sec));
//    [self performSelector:@selector(runSecond) withObject:0 afterDelay:.1];
    
}
-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIImageView *iv=[[UIImageView alloc] init];
    [self.view addSubview:iv];
    self.iv=iv;
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(@0);
//        make.width.height.equalTo(@200);
    }];
    [iv setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture:)];
    [tap setNumberOfTapsRequired:2];
    [tap setNumberOfTouchesRequired:2];
    [iv addGestureRecognizer:tap];
    
    
    UILongPressGestureRecognizer *lp=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(gesture:)];
    [lp setNumberOfTouchesRequired:2];
    [lp setMinimumPressDuration:2];
    [iv addGestureRecognizer:lp];
    
    UISwipeGestureRecognizer *swip=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gesture:)];
    swip.direction=(1<<0)|(1<<1)|(1<<2)|(1<<3);
    [iv addGestureRecognizer:swip];
    
    
    UIRotationGestureRecognizer *rotation=[[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(gesture:)];
    [iv addGestureRecognizer:rotation];
    rotation.delegate=self;
    
    UIPinchGestureRecognizer *pinch=[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(gesture:)];
    [iv addGestureRecognizer:pinch];
    
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gesture:)];
    [iv addGestureRecognizer:pan];
    pan.delegate=self;
    
    
    self.iv.layer.borderColor =[[UIColor orangeColor] CGColor];
    self.iv.layer.borderWidth=10;
    self.iv.layer.shadowColor=[[UIColor blackColor] CGColor];
    self.iv.layer.shadowOffset=(CGSize){10,10};
    self.iv.layer.shadowOpacity=1;
    self.iv.layer.shadowRadius=10;
    self.iv.layer.cornerRadius=100;
    self.iv.layer.masksToBounds=YES;
    
    self.iv.layer.bounds=(CGRect){0,0,200,200};
    self.iv.layer.position=self.view.layer.position;
    self.iv.layer.contents =(__bridge id)[[UIImage imageNamed:@"scene"] CGImage];
  
    
    CALayer *layer=[[CALayer alloc] init];
    layer.bounds=(CGRect) {0,0,100,100};
    layer.position=(CGPoint){100,100};
    layer.backgroundColor=[[UIColor redColor]CGColor];
    layer.opacity=1;
    layer.cornerRadius=50;
    [self.view.layer addSublayer:layer];
    layer.contents=(__bridge id)[[UIImage imageNamed:@"scene"] CGImage];
    self.layer=layer;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint p=[[touches anyObject] locationInView:self.view];
 
//    [CATransaction begin];
//    [CATransaction setDisableActions:NO];
//    [CATransaction setAnimationDuration:.5];
    
//    self.layer.position=p;
//    self.layer.bounds=(CGRect){0,0,p.x,p.x};
//    self.layer.opacity=(arc4random()%10)/10.0;

//    self.layer.transform=CATransform3DRotate(self.layer.transform, M_PI_4*.5,1, 1, 1);
//    self.layer.transform=CATransform3DScale(self.layer.transform, 1, 1, .8);
//    self.layer.transform=CATransform3DTranslate(self.layer.transform, 0, 0, 30);
    
    
//    [CATransaction commit];
    
//    NSLog(@"%@,,%@",NSStringFromCGPoint(self.view.center),NSStringFromCGPoint(self.layer.position));
  
    CABasicAnimation *pa=[[CABasicAnimation alloc] init];
    pa.keyPath=@"position.x";
    pa.byValue=@140;
//    [pa setFillMode:kCAFillModeForwards];
//    [pa setRemovedOnCompletion:NO];
    
    [self.layer setMasksToBounds:NO];
//    [self.layer addAnimation:pa forKey:nil];
    
    
    CAKeyframeAnimation *fa=[[CAKeyframeAnimation alloc] init];
    fa.keyPath=@"position";
    [fa setFillMode:kCAFillModeForwards];
    [fa setRemovedOnCompletion:NO];
    
    fa.duration=3;
    [fa setRepeatCount:10];
    
    [fa setValues:@[[NSValue valueWithCGPoint:(CGPoint){0,0}],[NSValue valueWithCGPoint:(CGPoint){0,300}],[NSValue valueWithCGPoint:(CGPoint){300,0}],[NSValue valueWithCGPoint:(CGPoint){300,300}],]];
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathAddArc(path, 0, self.view.center.x, self.view.center.y, 100, 0, 2*M_PI, 0);
//    [((YFV *)self.view) setPath:path];
    [fa setPath:path];
    
//    [self.layer addAnimation:fa forKey:nil];
    if(!CGRectContainsPoint(self.iv.frame, p)){
//        [self.iv.layer addAnimation:pa forKey:nil];
    }
    
    
    
    CAAnimationGroup *group=[[CAAnimationGroup alloc] init];
    CABasicAnimation *basi=[[CABasicAnimation alloc] init];
    basi.keyPath=@"transform.rotation";
    basi.byValue=@(2*M_PI);
    CAKeyframeAnimation *keya=[[CAKeyframeAnimation alloc ]init];
    
    keya.keyPath=@"position";
    keya.path=path;
    
    group.animations=@[basi,keya];
    group.duration=3;
    group.repeatCount=10;
//    group.repeatDuration=5;
//    [self.layer addAnimation:group forKey:0];
    
   

//    UIGraphicsBeginImageContext(self.view.bounds.size);
//    CGContextRef con=UIGraphicsGetCurrentContext();
//    
//    [self.view.layer renderInContext:con];
//    self.iv.image=UIGraphicsGetImageFromCurrentImageContext();
//    
//    CGContextClearRect(con, CGContextGetClipBoundingBox(con));
//    [self.layer renderInContext:con];
//    self.iv2.image=UIGraphicsGetImageFromCurrentImageContext();
//    
//    CGContextClearRect(con, CGContextGetClipBoundingBox(con));
//    [self.hour renderInContext:con];
//    self.iv3.image=UIGraphicsGetImageFromCurrentImageContext();
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

-(void)startCurlAniWithDirect:(int)dire{
    NSString *str[]={@"",@"fromLeft",@"fromRight",@"",@"fromTop",@"",@"",@"",@"fromBottom"};
    
    CATransition *transi=[[CATransition alloc] init];
    transi.type=@"cube";
    transi.subtype=str[dire];
    
    
    
    [self.iv.layer addAnimation:transi forKey:0];
}


-(void)gesture:(UIGestureRecognizer *)sender{
    if([sender isKindOfClass:[UITapGestureRecognizer class]]){
        NSLog(@"%@ be tapped",[sender class ]);
    }else if([sender isKindOfClass:[UILongPressGestureRecognizer class]]){
        if(sender.state==1){
            
        }
    }else if([sender isKindOfClass:[UISwipeGestureRecognizer class]]){
        UISwipeGestureRecognizer *reg=(UISwipeGestureRecognizer *)sender;
        
        [self startCurlAniWithDirect:reg.direction];
        
    }else if([sender isKindOfClass:[UIRotationGestureRecognizer class]]){
        CGFloat rotation=[(UIRotationGestureRecognizer *)sender rotation];
        self.iv.transform=CGAffineTransformRotate(self.iv.transform,rotation);
        ((UIRotationGestureRecognizer *)sender).rotation=0;
    }else if([sender isKindOfClass:[UIPinchGestureRecognizer class]]){
        UIPinchGestureRecognizer *pinch=(UIPinchGestureRecognizer *)sender;
        self.iv.transform=CGAffineTransformScale(self.iv.transform, pinch.scale, pinch.scale);
        NSLog(@"%f",pinch.scale);
        pinch.scale=1;
    }else if([sender isKindOfClass:[UIPanGestureRecognizer class]]){
        UIPanGestureRecognizer *pan=(UIPanGestureRecognizer *)sender;
        CGPoint p= [pan translationInView:sender.view];
        [pan setTranslation:(CGPoint){0,0} inView:sender.view];
        self.iv.transform=CGAffineTransformTranslate(self.iv.transform,p.x, p.y);
        
    }
}


-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
