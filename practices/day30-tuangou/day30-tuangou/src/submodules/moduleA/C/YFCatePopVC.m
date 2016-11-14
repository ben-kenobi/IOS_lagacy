//
//  YFCatePopVC.m
//  day30-tuangou
//
//  Created by apple on 15/11/8.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFCatePopVC.h"
#import "YFHomePop.h"
#import "YFMetaTool.h"
#import "YFCategory.h"

@interface YFCatePopVC ()<YFHomePopDS>

@end

@implementation YFCatePopVC

-(void)loadView{
    self.view=[[YFHomePop alloc] initWithFrame:(CGRect){0,0,400,409}];
    self.preferredContentSize=(CGSize){400,409};
    [(YFHomePop *)self.view setDelegate:self];
}

-(void)viewDidLoad{
    [super viewDidLoad];
}


- (NSInteger)numberOfRows:(YFHomePop *)pop{
    return [YFMetaTool categories].count;
}

- (void)pop:(YFHomePop *)pop updateCell:(UITableViewCell *)cell atRow:(NSInteger)row{
    YFCategory *cate=[YFMetaTool categories][row];
    
    cell.textLabel.text=cate.name;
    
    cell.imageView.image=img(cate.small_icon);
    cell.imageView.highlightedImage=img(cate.small_highlighted_icon);
    if(cate.subcategories.count){
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.accessoryType=UITableViewCellAccessoryNone;
    }

   
}

- (NSArray *)pop:(YFHomePop *)pop subdataForRow:(NSInteger)row{
    return [(YFCategory *)[YFMetaTool categories] [row] subcategories];
}





- (void)pop:(YFHomePop *)pop didSelectRow:(NSInteger)row{
    YFCategory *cate=[YFMetaTool categories][row];
    if(cate.subcategories.count==0){
        self.onchange(cate,0);
    }
}
- (void)pop:(YFHomePop *)pop didSelectSubRow:(NSInteger)subrow row:(NSInteger)row{
     YFCategory *cate=[YFMetaTool categories][row];
    self.onchange(cate,subrow);
}

@end
