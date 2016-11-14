//
//  ViewController.h
//  AnimatedPathsTest
//
//  Created by the world on 15/12/7.
//  Copyright © 2015年 赵繁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface ViewController : UIViewController

{
    CALayer *_animationLayer;
    CAShapeLayer *_pathLayer;
    CALayer *_penLayer;
}


@property (nonatomic, retain) CALayer *animationLayer;
@property (nonatomic, retain) CAShapeLayer *pathLayer;
@property (nonatomic, retain) CALayer *penLayer;

- (IBAction) replayButtonTapped:(id)sender;
- (IBAction) drawingTypeSelectorTapped:(id)sender;
@end

