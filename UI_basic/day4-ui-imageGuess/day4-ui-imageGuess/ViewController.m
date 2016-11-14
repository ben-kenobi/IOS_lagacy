//
//  ViewController.m
//  day4-ui-imageGuess
//
//  Created by apple on 15/9/15.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "HMGussMod.h"
#import "OptionsView.h"
#import "HMAnswerView.h"

#define WIDTHA 40

@interface ViewController ()<OptionsViewDelegate,AnserViewDelegate>
@property (weak, nonatomic)  UILabel *page;
@property (weak, nonatomic)  UILabel *comment;
@property (weak, nonatomic)  UIButton *img;

@property (weak, nonatomic)  UIButton *tip;
@property (weak, nonatomic)  UIButton *enlarge;
@property (weak, nonatomic)  UIButton *next;
@property (weak, nonatomic)  HMAnswerView *ansV;
@property (weak, nonatomic)  OptionsView *optionsV;
@property (weak, nonatomic)  UIButton *point;

@property (weak, nonatomic)  UIButton *help;
@property (strong ,nonatomic) NSMutableArray *dataAry;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,assign) NSInteger score;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self initState];
    [self initListeners];
    
}

-(void)initState{
    _score=5000;
    [self updateUI:0];
}

-(void)initListeners{
    [self.next addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.tip addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.enlarge addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.img addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

    
}



-(void)updateUI:(NSInteger)index{
    if(index+1>self.dataAry.count)
        return ;
    _index=index ;
     HMGussMod *mod = self.dataAry[_index];
    [self.ansV updateAnserWithMod:mod];
    [self.optionsV updateOptsWithMod:mod];
    [self updateScore:0];
    self.page.text=[NSString stringWithFormat:@"%ld/%ld",_index+1,_dataAry.count ] ;
    self.comment.text=mod.title;
    [self.img setImage:[UIImage imageNamed:mod.icon] forState:UIControlStateNormal];

    self.next.enabled=_index<self.dataAry.count-1;
    [self updateUIByComplete:NO];
}


-(void)updateUIByComplete:(BOOL)complete{
    [_optionsV setUserInteractionEnabled:!complete];
    [self.tip setEnabled:!complete];
    if(complete){
        HMGussMod *mod = _dataAry[_index];
        NSMutableString *answer=[NSMutableString string];
        [[self.ansV subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [answer appendString:((UIButton *)obj).currentTitle];
        }];
       
        if([answer isEqualToString:mod.answer]){
            [self updateScore:100];
           
            [self.ansV updateAnswerColor:[UIColor greenColor]];
            if(_index+1>_dataAry.count-1){
                [self startOver];
            }else{
              [self performSelector:@selector(onBtnClicked:) withObject:self.next afterDelay:2];
            }
            
            
        }else{
            [self.ansV updateAnswerColor:[UIColor redColor]];
            [self updateScore:-1000];
            
        }
    }else{
        [self.ansV updateAnswerColor:[UIColor blackColor]];
    }
}




-(void)updateScore:(NSInteger)n{
    NSInteger score = _score+n;
    if(score<0){
        [self getCover:.6];
        [[[UIAlertView alloc] initWithTitle:@"note" message:@"You Are Out of Gold" delegate:nil cancelButtonTitle:@"充值" otherButtonTitles:@"退出", nil] show];
    }else {
        _score=score;
        [self.point setTitle:[NSString stringWithFormat:@"%ld",_score] forState:UIControlStateNormal];
    }
    
}




-(void)onBtnClicked:(UIButton *)sender{
    if(sender==self.next){
        [self updateUI:_index+1];
    }else if(sender ==self.tip){
        [self updateScore:-1000];
        HMGussMod *mod=[_dataAry objectAtIndex:_index];
        NSString *replacement,*rep;
        BOOL complete=NO;
        rep=[self.ansV tipByMod:mod replaced:&replacement complete:&complete];
        [self.optionsV hideOpt:rep show:replacement];
        [self updateUIByComplete:complete];
    }else if(sender.superview==self.ansV){
       
        [self.optionsV hideOpt:nil show:[sender currentTitle]];
        [self updateUIByComplete:![sender currentTitle]];
      
    }else if(sender==self.enlarge){
        [self.view bringSubviewToFront:self.img];
        UIView *cover = [self getCover:0];
        [UIView animateWithDuration:.5 animations:^{
            self.img.transform=CGAffineTransformMakeScale(1.3, 1.3);
            cover.alpha=.6;
        }];
        [self.view bringSubviewToFront:self.img];
    }else if(sender ==self.img){
        
        if(CGAffineTransformEqualToTransform(self.img.transform, CGAffineTransformIdentity) ){
            [self onBtnClicked:self.enlarge];
        }else {
            [UIView animateWithDuration:.3 animations:^{
                self.img.transform=CGAffineTransformIdentity;
                [[self.view viewWithTag:101] setAlpha:0];
            }];
        }
    }else if(sender.superview==self.optionsV){
        BOOL complete;
        if([self.ansV addTitle:[sender currentTitle] complete:&complete ])
            sender.hidden=YES;
        [self updateUIByComplete:complete];
        
    }
}










-(void)startOver{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"note" message:@"mission complete" preferredStyle:UIAlertControllerStyleAlert];
    [ac addAction:[UIAlertAction actionWithTitle:@"重新开始" style:0 handler:^(UIAlertAction *action) {
        [self initState];
    }]];
    [ac addAction:[UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self getCover:.6];
    }]];
    [self presentViewController:ac animated:YES completion:nil];
}


-(UIView *)getCover:(CGFloat)alpha{
    UIView *cover=[self.view viewWithTag:101];
    if(!cover){
        cover=[[UIView alloc] initWithFrame:self.view.frame];
        cover.backgroundColor=[UIColor blackColor];
        cover.tag=101;
        [self.view addSubview:cover];
    }
    [self.view bringSubviewToFront:cover];
    [cover setAlpha:alpha];
    return cover;
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}
-(NSMutableArray *)dataAry{
    if(nil==_dataAry ){
        _dataAry=[NSMutableArray array];
        NSArray *ary =[NSArray arrayWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"questions" ofType:@"plist"]];
        for(NSDictionary *dict in ary){
            [_dataAry addObject:[HMGussMod modWithDict:dict]];
        }
    }
    return _dataAry;
}





-(void)initUI{
    CGSize size = self.view.frame.size;
    CGPoint center = self.view.center;
    UIImageView *bg=[[UIImageView alloc] initWithFrame:self.view.frame];
    [bg setImage:[UIImage imageNamed:@"bj"]];
    [self.view addSubview:bg];
    
    UILabel *page=[[UILabel alloc] initWithFrame:CGRectMake(0, 40, size.width,30 )];
    [page setTextAlignment:NSTextAlignmentCenter];
    [page setTextColor:[UIColor whiteColor]];
    [page setFont:[UIFont boldSystemFontOfSize:14]];
    [self.view addSubview:page];
    self.page=page;
    
    UILabel *comment=[[UILabel alloc] initWithFrame:(CGRect){0,CGRectGetMaxY(self.page.frame)+10,size.width,40}];
    [comment setFont:[UIFont systemFontOfSize:17]];
    [comment setTextColor:[UIColor whiteColor]];
    [comment setTextAlignment:NSTextAlignmentCenter];
    [comment setNumberOfLines:0];
    [self.view addSubview:comment];
    self.comment=comment;
    
    UIButton *gold=[[UIButton alloc] initWithFrame:(CGRect){size.width-100,20,80,20}];
    [gold setImage:[UIImage imageNamed:@"coin"] forState:UIControlStateNormal];
    [gold setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    gold.titleLabel.font=[UIFont boldSystemFontOfSize:14];
    [gold.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [gold setUserInteractionEnabled:NO];
    [self.view addSubview:gold];
    self.point=gold;
    
    UIButton *img=[[UIButton alloc] initWithFrame:(CGRect){center.x-100,CGRectGetMaxY(self.comment.frame)+25,200,200}];
    [img setBackgroundColor:[UIColor whiteColor]];
    [img setImageEdgeInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
    [img setContentEdgeInsets:(UIEdgeInsets){3,3,3,3}];
    [img setBackgroundImage:[UIImage imageNamed:@"center_img"] forState:UIControlStateNormal];
    [self.view addSubview:img];
    self.img=img;
    
    HMAnswerView *answer= [HMAnswerView viewWithFrame:(CGRect){0,CGRectGetMaxY(self.img.frame)+30,size.width,WIDTHA}];
    [self.view addSubview:answer];
    self.ansV=answer;
    self.ansV.delegate=self;
    
    OptionsView *options=[OptionsView viewWithFrame:(CGRect){0,CGRectGetMaxY(self.ansV.frame)+30,size.width,size.height-CGRectGetMaxY(self.ansV.frame)-30} count:((NSArray *)[self.dataAry[0] valueForKeyPath:@"options"]).count];
    [self.view addSubview:options];
    self.optionsV=options;
    self.optionsV.delegate=self;
    
    CGSize btnsize={50,22};
    UIFont *font=[UIFont systemFontOfSize:13];
    CGFloat left=CGRectGetMinX(self.img.frame)-btnsize.width-20,
    top=CGRectGetMinY(self.img.frame),
    bottom=CGRectGetMaxY(self.img.frame)-btnsize.height,
    right= CGRectGetMaxX(self.img.frame)+20;
    UIImage *leftimg=[UIImage imageNamed:@"btn_left"],
    *rightimg=[UIImage imageNamed:@"btn_right"];
    
    
    UIButton * (^createBtn)(CGRect,NSString *,UIImage *,UIImage*)=^(CGRect frame,NSString *title,UIImage *iconimg,UIImage *bgimg){
        UIButton *btn = [[UIButton alloc] initWithFrame:frame];
        [btn setBackgroundImage:bgimg forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateNormal];
        btn.titleLabel.font=font;
        [btn setImage:iconimg forState:UIControlStateNormal];
        [self.view addSubview:btn];
        return btn;
    };
    
   
    self.tip= createBtn((CGRect){left,top,btnsize},@"提示",[UIImage imageNamed:@"icon_tip"],leftimg);
    self.help= createBtn((CGRect){left,bottom,btnsize},@"帮助",[UIImage imageNamed:@"icon_help"],rightimg);
    self.enlarge= createBtn((CGRect){right,top,btnsize},@"放大",[UIImage imageNamed:@"icon_img"],leftimg);
    self.next= createBtn((CGRect){right,bottom,btnsize},@"下一题",nil,rightimg);
    
    
    
}

@end
