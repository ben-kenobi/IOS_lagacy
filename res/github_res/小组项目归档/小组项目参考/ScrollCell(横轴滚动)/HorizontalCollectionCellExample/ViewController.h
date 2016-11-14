//
//  ViewController.h
//  HorizontalCollectionCellExample
//
//  Created by Muratcan Celayir on 1.02.2015.
//  Copyright (c) 2015 Muratcan Celayir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collection;

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com