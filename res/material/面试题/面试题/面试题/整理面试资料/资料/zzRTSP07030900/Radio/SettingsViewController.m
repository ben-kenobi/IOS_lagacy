//
//  SettingsViewController.m
//  Radio
//
//  Created by Planet1107 on 1/28/12.
//

#import "SettingsViewController.h"
#import "CategoryCell.h"
#define kClearRecentsTitle @"清除播放记录"
#define kClearFavoritesTitle @"清除收藏电台"
#define kYesAnswer @"是"
#define kNoAnswer @"否"
#define kFavoritesPlistName @"favoriteSites"
#define kRecentsPlistName @"recentSites"
#define kaboutBaoDaoRadio @"关于宝岛电台"
#define kaboutVersion @"版本说明"

#import "AboutBaoDaoRadio.h"
#import "aboutVersionViewController.h"

@implementation SettingsViewController

@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"设置";
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
//    if (iOS7) {
//        self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 44, 0);
//    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UITableView delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45.0f;
}

//Called when user selects one of the cells in table, presents player for chosen streaming site.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *cellTitle = [[(CategoryCell*)[self.tableView cellForRowAtIndexPath:indexPath] titleLabel] text];
    if ([cellTitle isEqualToString:kClearRecentsTitle]) {
        [self performSelector:@selector(clearAllRecents)];
    }
    else if ([cellTitle isEqualToString:kClearFavoritesTitle]) {
        [self performSelector:@selector(clearAllFavorites)];
    }else if ([cellTitle isEqualToString:kaboutBaoDaoRadio]){
         [self performSelector:@selector(aboutBaoDaoRadio)];
    }else if ([cellTitle isEqualToString:kaboutVersion]){
        [self performSelector:@selector(aboutVersion)];
    }
}

#pragma mark - UITableView data source methods

//Configures cells for each row.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Class name CategoryCell may be disinformative, but it is actualy a reuse of class that was made for another purpose.
    static NSString *CellIdentifier = @"CategoryCell";
    
    CategoryCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[[CategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         cell.titleLabel.frame = CGRectMake(15, 20, 201, 21);
        
        cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell-normal-no-speaker44"]] autorelease];
    }
    if (indexPath.row == 0) {
        [cell.titleLabel setText:kClearRecentsTitle];
    }
    else if (indexPath.row == 1) {
        [cell.titleLabel setText:kClearFavoritesTitle];
    }else if (indexPath.row == 2)
    {
         [cell.titleLabel setText:kaboutBaoDaoRadio];
    }else if (indexPath.row == 3)
    {
        [cell.titleLabel setText:kaboutVersion];
    }
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

#pragma mark - button methods

//Called when user taps on clearAllFavoritesButton, presents confirmation alert.
- (void)clearAllRecents {
    UIAlertView *confirmationAlert = [[UIAlertView alloc] initWithTitle:kClearRecentsTitle message:@"是否清除最近的播放记录?" delegate:self cancelButtonTitle:kNoAnswer otherButtonTitles:kYesAnswer, nil];
    [confirmationAlert show];
    [confirmationAlert release];
}

//Called when user taps on clearAllRecentsButton, presents confirmation alert.
- (void)clearAllFavorites {
    UIAlertView *confirmationAlert = [[UIAlertView alloc] initWithTitle:kClearFavoritesTitle message:@"是否清除收藏的电台?" delegate:self cancelButtonTitle:kNoAnswer otherButtonTitles:kYesAnswer, nil];
    [confirmationAlert show];
    [confirmationAlert release];
}

- (void)aboutBaoDaoRadio {
    
    AboutBaoDaoRadio *aboutBaoDaoRadio = [[AboutBaoDaoRadio alloc] init];
    
 
    //弹出控制器
    [self  presentViewController:aboutBaoDaoRadio  animated:YES completion:nil];
    
}


- (void)aboutVersion {
    
    aboutVersionViewController *aboutVersion = [[aboutVersionViewController alloc] init];
    
    
    //弹出控制器
    [self  presentViewController:aboutVersion  animated:YES completion:nil];
    
}



#pragma mark - UIAlertView delegate methods

//Called when user answers to question provided in alert view.
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if ([[alertView title] isEqualToString:kClearRecentsTitle]) {
        if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:kYesAnswer]) {
            [self performSelector:@selector(removeAllItemsFromPlistNamed:) withObject:kRecentsPlistName];
        }
    }
    else if([[alertView title] isEqualToString:kClearFavoritesTitle]) {
        if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:kYesAnswer]) {
            [self performSelector:@selector(removeAllItemsFromPlistNamed:) withObject:kFavoritesPlistName];
        }
    }
}

#pragma mark - private methods

//Removes all items in plist with given name.
- (void)removeAllItemsFromPlistNamed:(NSString*)plistName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSMutableString *filePath = [NSMutableString stringWithString:[paths objectAtIndex:0]];
    [filePath appendString:@"/"];
    [filePath appendString:plistName];
    [filePath appendString:@".plist"];
    
    [[NSDictionary dictionary] writeToFile:filePath atomically:YES];
}


@end
