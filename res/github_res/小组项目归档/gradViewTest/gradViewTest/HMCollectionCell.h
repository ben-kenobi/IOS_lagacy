//
//  HMCollectionCell.h
//  gradViewTest
//
//  Created by 1 on 15/11/11.
//  Copyright © 2015年 stdio dollar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMCollectionViewModel.h"
@class ViewController;

@interface HMCollectionCell : UICollectionViewCell

@property(nonatomic,strong)HMCollectionViewModel *model;

@property(nonatomic,strong)ViewController *VC;

@end
