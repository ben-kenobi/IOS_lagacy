//
//  YFColCell.h
//  day20-ui-loterry02
//
//  Created by apple on 15/10/18.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *celliden=@"collectioncelliden";
@interface YFColCell : UICollectionViewCell

+(instancetype)cellWith:(UICollectionView *)cv path:(NSIndexPath *)path dict:(NSDictionary *)dict;

@end
