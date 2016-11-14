//
//  CategoryViewController.h
//  Radio
//
//  Created by Planet1107 on 1/28/12.
//

#import <UIKit/UIKit.h>
#import "SitesViewController.h"
@interface CategoryViewController : UIViewController<SitesViewControllerDelegate,UIScrollViewDelegate> {
    NSArray *categories;
}

@property(nonatomic, retain) IBOutlet UITableView *tableView;
@property(nonatomic, retain) SitesViewController *currentSitesViewController;

- (NSArray*)categoriesFromPlistNamed:(NSString*)plistName;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;
/**
 *  页码
 */
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic, strong) NSTimer *timer;


@end
