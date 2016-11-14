//
//  FavoritesViewController.m
//  Radio
//
//  Created by Planet1107 on 1/28/12.
//

#import "FavoritesViewController.h"
#import "PlayerViewController.h"
#import "SiteCell.h"
#define kFavoritesPlistName @"favoriteSites"
#define kRecentsPlistName @"recentSites"
#define kMaxNumberOfRecents 20

@implementation FavoritesViewController

@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"喜欢";
        favorites = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc {
    [favorites release];
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
//        self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 44, 0);
//    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self performSelector:@selector(loadFavoritesFromPlistNamed:) withObject:kFavoritesPlistName];
    [tableView reloadData];
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
    
    NSDictionary *site = [[favorites objectAtIndex:indexPath.row] retain];
    
    [self performSelector:@selector(addSite: toPlistWithName:) withObject:site withObject:kRecentsPlistName];
    
    //Present player with selected site/stream.
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    PlayerViewController *playerViewController = [[PlayerViewController alloc] initWithNibName:@"PlayerViewController" bundle:nil];
    [playerViewController setTitle:[site objectForKey:@"siteName"]];
    [playerViewController setSiteLink:[site objectForKey:@"siteLink"]];
    NSString *siteLogoImageName = [site objectForKey:@"siteLogoName"];
    if (![siteLogoImageName isEqualToString:@""]) {
        [playerViewController setSiteLogo:[UIImage imageNamed:siteLogoImageName]];
    }
    [self.navigationController pushViewController:playerViewController animated:YES];
    [playerViewController release];
    
    [site release];
}

//Called when user tries to delete a cell, updates the table and plist.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self performSelector:@selector(removeSite: fromPlistNamed:) withObject:[favorites objectAtIndex:indexPath.row] withObject:kFavoritesPlistName];
        [favorites removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
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
    [cell.titleLabel setText:[[favorites objectAtIndex:indexPath.row] objectForKey:@"siteName"]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [favorites count];
}

#pragma mark - private methods

//Loads streaming sites from plist with given name.
- (void)loadFavoritesFromPlistNamed:(NSString*)plistName {
    [favorites removeAllObjects];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSMutableString *filePath = [NSMutableString stringWithString:[paths objectAtIndex:0]];
    [filePath appendString:@"/"];
    [filePath appendString:plistName];
    [filePath appendString:@".plist"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSDictionary *favoriteSites = [NSDictionary dictionaryWithContentsOfFile:filePath];
        for (int i = [favoriteSites count]-1; i > -1 ; i--) {
            [favorites addObject:[favoriteSites objectForKey:[NSString stringWithFormat:@"Site%d", i]]];
        }
    }
}

//Removes given site from plist with given name.
- (void)removeSite:(NSDictionary*)site fromPlistNamed:(NSString*)plistName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSMutableString *filePath = [NSMutableString stringWithString:[paths objectAtIndex:0]];
    [filePath appendString:@"/"];
    [filePath appendString:plistName];
    [filePath appendString:@".plist"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSMutableDictionary *favoriteSites = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
        for (int i = 0; i < [favoriteSites count]; i++) {
            NSDictionary *currentSite = [favoriteSites objectForKey:[NSString stringWithFormat:@"Site%d", i]];
            
            //When site is found it is overwritten by decrementing index of other sites that come after it.
            if ([currentSite isEqualToDictionary:site]) {
                int j = i;
                for (; j < [favoriteSites count]-1; j++) {
                    [favoriteSites setValue:[favoriteSites objectForKey:[NSString stringWithFormat:@"Site%d", j+1]] forKey:[NSString stringWithFormat:@"Site%d", j]];
                }
                [favoriteSites removeObjectForKey:[NSString stringWithFormat:@"Site%d", j]];
                break;
            }
        }
        [favoriteSites writeToFile:filePath atomically:YES];
    }
}

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

@end
