//
//  HMNavCollection.h
//  gradViewTest
//
//  Created by 1 on 15/11/11.
//  Copyright © 2015年 stdio dollar. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HMNavCollection : UICollectionView

@property(nonatomic,strong)NSArray *NavDatas;

@property(nonatomic,assign)NSIndexPath  *cuttentIndex;

@property(nonatomic,copy)void(^Myblock)();

@end
