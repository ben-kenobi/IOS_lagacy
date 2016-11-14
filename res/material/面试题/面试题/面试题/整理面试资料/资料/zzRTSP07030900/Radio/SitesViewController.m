//
//  SitesViewController.m
//  Radio
//
//  Created by Planet1107 on 1/28/12.
//

#import "SitesViewController.h"
#import "SiteCell.h"
#import "PlayerViewController.h"
#define kRecentsPlistName @"recentSites"
#define kMaxNumberOfRecents 20
#import "ViewController.h"
@implementation SitesViewController

@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        sites = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc {
    self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
    [sites release];
    [super dealloc];
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
//          self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 44, 0);
//    }
//
    // Do any additional setup after loading the view from its nib.
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
    return 44.0f;
}

//Called when user selects one of the cells in table, presents player for chosen streaming site and adds it to recents.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *site = [[sites objectAtIndex:indexPath.row] retain];
    
    [self performSelector:@selector(addSite: toPlistWithName:) withObject:site withObject:kRecentsPlistName];
    
    //Present player with selected site/stream.
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
#warning
//    ViewController*vc = [[ViewController alloc] init];
 
#warning 注释
//    PlayerViewController *playerViewController = [[PlayerViewController alloc] initWithNibName:@"PlayerViewController" bundle:nil];
    PlayerViewController *playerViewController = [[PlayerViewController alloc] init];
    
    //如果当前选中的是正在播放的那个
    if (self.currentPlayerVC.identifier == (indexPath.row + 1))
    {
        playerViewController = self.currentPlayerVC;
        //self.currentPlayerVC = playerViewController;
//        playerViewController.currentPlayingVc = self.currentPlayerVC;

        
    }else{
        
        playerViewController = [[PlayerViewController alloc] initWithNibName:@"PlayerViewController" bundle:nil];

    }
    playerViewController.currentPlayingVc = self.currentPlayerVC;

    
    //创建标识
    playerViewController.identifier = indexPath.row + 1;
    
    
    playerViewController.delegate = self;
    
    
    [playerViewController setTitle:[site objectForKey:@"siteName"]];
    [playerViewController setSiteLink:[site objectForKey:@"siteLink"]];
    NSString *siteLogoImageName = [site objectForKey:@"siteLogoName"];
    if (![siteLogoImageName isEqualToString:@""]) {
        [playerViewController setSiteLogo:[UIImage imageNamed:siteLogoImageName]];
    }
    
//    playerViewController.tabBarController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:playerViewController animated:YES];
    [playerViewController release];
    
    [site release];
}

#pragma mark - UITableView data source methods

//Configures cells for each row.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"SiteCell";
    
    SiteCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[[SiteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    [cell.titleLabel setText:[[sites objectAtIndex:indexPath.row] objectForKey:@"siteName"]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [sites count];
}
#pragma mark - PlayViewControllerDelegate 代理方法
- (void)PlayViewStratBtnDidClicked:(PlayerViewController *)PlayView
{
    if ([self.currentPlayerVC.aPlayer getStatus] == eAudioRunning) {
        [self.currentPlayerVC stopPlayAudio];
    }
    self.currentPlayerVC = PlayView;
    
    [self.delegate sitesViewSomeOneDidPlay:self];
    
}

- (void)PlayViewStopBtnDidClicked:(PlayerViewController *)PlayView
{
    //[self.currentPlayerVC retain];
}

#pragma mark - private methods

//Writes given site to plist with given name.
- (void)addSite:(NSDictionary*)site toPlistWithName:(NSString*)plistName {
    [site retain];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSMutableString *filePath = [NSMutableString stringWithString:[paths objectAtIndex:0]];
    [filePath appendString:@"/"];
    [filePath appendString:plistName];
    [filePath appendString:@".plist"];
    
    NSMutableDictionary *recents = [[NSMutableDictionary alloc] init];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        [recents setDictionary:[NSMutableDictionary dictionaryWithContentsOfFile:filePath]];
    }
    
    //Check if site is already in recents.
    for (int i = 0; i < [recents count]; i++) {
        NSDictionary *currentSite = [recents objectForKey:[NSString stringWithFormat:@"Site%d", i]];
        if ([currentSite isEqualToDictionary:site]) {
            [recents release];
            [site release];
            return;
        }
    }
    
    //If recents is full delete the oldest one, and rearrange others.
    if ([recents count] == kMaxNumberOfRecents) {
        for (int i = 0; i < kMaxNumberOfRecents-1; i++) {
            [recents setValue:[recents objectForKey:[NSString stringWithFormat:@"Site%d", i+1]] forKey:[NSString stringWithFormat:@"Site%d", i]];
        }
    }
    
    //Write site to recents.
    [recents setValue:site forKey:[NSString stringWithFormat:@"Site%d", [recents count]]];
    [recents writeToFile:filePath atomically:YES];
    [recents release];
}

#pragma mark - public methods

//Uses given category to get streaming sites that will be presented in table view.
- (void)setSitesFromCategory:(NSDictionary*)category {
    [category retain];
    for (int i = 0; i < [category count]-1; i++) {
        [sites addObject:[category objectForKey:[NSString stringWithFormat:@"Site%d", i]]];
    }
    [category release];
}


@end
