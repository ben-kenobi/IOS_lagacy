//
//  YFVC.m
//  day52-sensorNUIDynamic
//
//  Created by apple on 15/12/24.
//  Copyright © 2015年 yf. All rights reserved.
//

#import "DynamicViewVC.h"

@interface DynamicViewVC ()
@property (nonatomic,strong)UIDynamicAnimator *anim;
@property (nonatomic,strong)UIView *orangev;
@property (nonatomic,strong)UIView *cyanv;
@property (nonatomic,weak)UISnapBehavior *snap;
@end

@implementation DynamicViewVC


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  
    [self snapTest:[touches.anyObject locationInView:self.view]];

}





-(void)snapTest:(CGPoint)p{
    if(!_snap){
        UISnapBehavior *snap=[[UISnapBehavior alloc] initWithItem:self.orangev snapToPoint:p];
        snap.damping=1;
        [self.anim addBehavior:snap];
        _snap=snap;
        
    }
    _snap.snapPoint=p;
    
    
}

-(void)graNcolliTest{
    UIGravityBehavior *gra=[[UIGravityBehavior alloc] initWithItems:@[self.orangev,self.cyanv]];
    UICollisionBehavior *cli=[[UICollisionBehavior alloc] initWithItems:@[self.cyanv,self.orangev]];
    
    //    [cli addBoundaryWithIdentifier:@"iden" fromPoint:(CGPoint){0,self.view.h*.5} toPoint:(CGPoint){self.view.w*.8,self.view.h*.7}];
    //    UIBezierPath *bp=[UIBezierPath bezierPath];
    //    [bp addArcWithCenter:self.view.center radius:300 startAngle:0 endAngle:2*M_PI clockwise:YES];
    //    [cli addBoundaryWithIdentifier:@"iden" forPath:bp];
    
    
    //    [gra setAngle:M_PI_4 magnitude:5];
    gra.gravityDirection=CGVectorMake(0, 2);
    
    cli.translatesReferenceBoundsIntoBoundary=YES;
    [self.anim removeAllBehaviors];
    [self.anim addBehavior:gra];
    [self.anim addBehavior:cli];
}


-(UIView *)orangev{
    if (!_orangev) {
        _orangev=[[UIView alloc] initWithFrame:(CGRect){100,20,100,100}];
        _orangev.backgroundColor=[UIColor orangeColor];
        [self.view addSubview:_orangev];
    }
    return _orangev;
}
-(UIView *)cyanv{
    if (!_cyanv) {
        _cyanv=[[UIView alloc] initWithFrame:(CGRect){110,220,50 ,50}];
        _cyanv.backgroundColor=[UIColor cyanColor];
        [self.view addSubview:_cyanv];
    }
    return _cyanv;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor randColor];
    self.anim=[[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
}



@end
