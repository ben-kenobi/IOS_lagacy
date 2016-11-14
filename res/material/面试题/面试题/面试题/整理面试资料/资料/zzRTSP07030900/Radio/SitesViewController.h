//
//  SitesViewController.h
//  Radio
//
//  Created by Planet1107 on 1/28/12.
//

#import <UIKit/UIKit.h>
#import "PlayerViewController.h"
@class SitesViewController;
@class CategoryViewController;
@protocol SitesViewControllerDelegate <NSObject>

- (void)sitesViewSomeOneDidPlay:(SitesViewController *)sitesView;

@end
@interface SitesViewController : UIViewController<PlayViewControllerDelegate> {
    NSMutableArray *sites;
}

@property(nonatomic, retain) IBOutlet UITableView *tableView;
@property(nonatomic, retain) PlayerViewController *currentPlayerVC;
@property(nonatomic, retain) CategoryViewController *currentCategoryVC;
@property (nonatomic,assign) int identifier;
@property(nonatomic, retain) id<SitesViewControllerDelegate> delegate;

- (void)setSitesFromCategory:(NSDictionary*)category;

@end
