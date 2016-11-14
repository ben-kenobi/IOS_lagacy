//
//  RecentViewController.h
//  Radio
//
//  Created by Planet1107 on 1/28/12.
//

#import <UIKit/UIKit.h>

@interface RecentViewController : UIViewController {
    NSMutableArray *recents;
}

@property(nonatomic, retain) IBOutlet UITableView *tableView;

@end
