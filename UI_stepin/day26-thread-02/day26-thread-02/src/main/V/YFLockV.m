//
//  YFLockV.m
//  day21-ui-lottery03
//
//  Created by apple on 15/10/20.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFLockV.h"
#define COUNT 9
#define COL 3

@interface YFLockV ()

@property (nonatomic,strong)NSMutableArray *btns;
@property (nonatomic,strong)NSMutableArray *selBtns;
@property (nonatomic,assign)CGPoint curp;
@property (nonatomic,weak) UIView *last;

@end

@implementation YFLockV


-(void)drawRect:(CGRect)rect{
    
}


-(void)selBtnBy:(NSSet *)touches{
    UITouch *touch=[touches anyObject];
    CGPoint p=[touch locationInView:touch.view];
    self.curp=p;
    for(NSInteger i=self.btns.count-1;i>=0;i--){
        UIButton *btn=self.btns[i];
        if([self.selBtns containsObject:btn])
            break;
        if(CGRectContainsPoint(btn.frame, p)){
            [self.selBtns addObject:btn];
            [btn setHighlighted:YES];
        }
    }
    [self setNeedsDisplay];
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self selBtnBy:touches];

}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self initState];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [self selBtnBy:touches];
}

-(NSMutableArray *)selBtns{
    if(!_selBtns){
        _selBtns=[NSMutableArray array];
    }
    return _selBtns;
}


-(NSMutableArray *)btns{
    if(!_btns){
        _btns=[NSMutableArray array];
        
        UIImage *img[3]={[UIImage imageNamed:@"gesture_node_normal"],[UIImage imageNamed:@"gesture_node_highlighted"],[UIImage imageNamed:@"gesture_node_error"]};
        int state[3]={ UIControlStateNormal, UIControlStateHighlighted ,UIControlStateSelected};
        
        int ary[3]={3,3,2};
        int i,j;
        UIView *lastspaceV=0;
        UIView *lastbtn=0;
        UIView *lastspaceH=0;
        NSMutableArray *firstline=[NSMutableArray arrayWithCapacity:3];
        for( i=0;i<3;i++){
            
            if(lastspaceV){
                [lastspaceV mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(lastspaceH.mas_width);
                }];
                 UIView *cur=[[UIView alloc] init];
                [self addSubview:cur];
                [cur mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(lastbtn.mas_bottom);
                    make.height.equalTo(lastspaceH.mas_width);
                }];
                lastspaceV=cur;
            }else{
                lastspaceV=[[UIView alloc] init];
                [self addSubview:lastspaceV];
                [lastspaceV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(@0);
                    
                }];
            }
            
            UIView *lastspace=0;
            for( j=0;j<ary[i];j++){
                if(lastspace){
                    UIView *cur=[[UIView alloc] init];
                    [self addSubview:cur];
                    [cur mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(lastbtn.mas_right);
                        make.width.equalTo(lastspace.mas_width);
                    }];
                    lastspace=cur;lastspaceH=cur;
                }else{
                    lastspace=[[UIView alloc] init];
                    [self addSubview:lastspace];
                    [lastspace mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(@0);
                    }];
                }
                
                
                
                UIButton *btn=[[UIButton alloc] init];
                [self addSubview:btn];
                [self.btns addObject:btn];
                btn.tag=i;
                [btn setUserInteractionEnabled:NO];
                for(int i=0;i<3;i++){
                    [btn setImage:img[i] forState:state[i]];
                }
                if(firstline.count<3){
                    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(lastspace.mas_right);
                        make.top.equalTo(lastspaceV.mas_bottom);
                    }];
                    [firstline addObject:btn];
                }else{
                    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo([firstline[j] mas_left]);
                        make.top.equalTo(lastspaceV.mas_bottom);
                    }];
                }
                [btn setBackgroundColor:[UIColor randomColor]];
                lastbtn=btn;
            }
            UIView *cur=[[UIView alloc] init];
            
            [self addSubview:cur];
            [cur mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastbtn.mas_right);
                make.width.equalTo(lastspace.mas_width);
                make.right.equalTo(@0);
            }];
        }
        
        UIView *cur=[[UIView alloc] init];
        [self addSubview:cur];
        self.last=cur;
        [cur setBackgroundColor:[UIColor randomColor]];
        [cur mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastbtn.mas_bottom);

            make.height.equalTo(lastspaceH.mas_width);
        }];
        
        
        
        
        
//        for(int i=0;i<COUNT;i++){
//            if(last){
//                
//            }else{
//                spacs[i]
//            }
//            UIButton *btn=[[UIButton alloc] init];
//            [self addSubview:btn];
//            [self.btns addObject:btn];
//            btn.tag=i;
//            [btn setUserInteractionEnabled:NO];
//            for(int i=0;i<3;i++){
//                [btn setImage:img[i] forState:state[i]];
//            }
//            [btn sizeToFit];
        
            
//        }
    }
    return _btns;
}


-(void)initState{
    [self.selBtns enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj setSelected:NO];
        [obj setHighlighted:NO];
    }];
    
    [self.selBtns removeAllObjects];
    [self setUserInteractionEnabled:YES];
    [self setNeedsDisplay];
}




@end
