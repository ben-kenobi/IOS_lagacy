//
//  RecentViewController.m
//  Radio
//
//  Created by Planet1107 on 1/28/12.
//

#import "RecentViewController.h"
#import "PlayerViewController.h"
#import "SiteCell.h"
#define kRecentsPlistName @"recentSites"

@implementation RecentViewController

@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"记录";
        recents = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc {
    [recents release];
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
    [self performSelector:@selector(loadRecentsFromPlistNamed:) withObject:kRecentsPlistName];
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
    return 45.0f;
}

//Called when user selects one of the cells in table, presents player for chosen streaming site.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    PlayerViewController *playerViewController = [[PlayerViewController alloc] initWithNibName:@"PlayerViewController" bundle:nil];
    [playerViewController setTitle:[[recents objectAtIndex:indexPath.row] objectForKey:@"siteName"]];
    [playerViewController setSiteLink:[[recents objectAtIndex:indexPath.row] objectForKey:@"siteLink"]];
    NSString *siteLogoImageName = [[recents objectAtIndex:indexPath.row] objectForKey:@"siteLogoName"];
    if (![siteLogoImageName isEqualToString:@""]) {
        [playerViewController setSiteLogo:[UIImage imageNamed:siteLogoImageName]];
    }
    [self.navigationController pushViewController:playerViewController animated:YES];
    [playerViewController release];
}

//Called when user tries to delete a cell, updates the table and plist.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self performSelector:@selector(removeSite: fromPlistNamed:) withObject:[recents objectAtIndex:indexPath.row] withObject:kRecentsPlistName];
        [recents removeObjectAtIndex:indexPath.row];
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
    [cell.titleLabel setText:[[recents objectAtIndex:indexPath.row] objectForKey:@"siteName"]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [recents count];
}

#pragma mark - private methods

//Loads streaming sites from plist with given name.
- (void)loadRecentsFromPlistNamed:(NSString*)plistName {
    [recents removeAllObjects];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSMutableString *filePath = [NSMutableString stringWithString:[paths objectAtIndex:0]];
    [filePath appendString:@"/"];
    [filePath appendString:plistName];
    [filePath appendString:@".plist"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSDictionary *recentSites = [NSDictionary dictionaryWithContentsOfFile:filePath];
        for (int i = [recentSites count]-1; i > -1 ; i--) {
            [recents addObject:[recentSites objectForKey:[NSString stringWithFormat:@"Site%d", i]]];
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
        NSMutableDictionary *recentSites = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
        for (int i = 0; i < [recentSites count]; i++) {
            NSDictionary *currentSite = [recentSites objectForKey:[NSString stringWithFormat:@"Site%d", i]];
            //When site is found it is overwritten by decrementing index of other sites that come after it.
            if ([currentSite isEqualToDictionary:site]) {
                int j = i;
                for (; j < [recentSites count]-1; j++) {
                    [recentSites setValue:[recentSites objectForKey:[NSString stringWithFormat:@"Site%d", j+1]] forKey:[NSString stringWithFormat:@"Site%d", j]];
                }
                [recentSites removeObjectForKey:[NSString stringWithFormat:@"Site%d", j]];
                break;
            }
        }
        [recentSites writeToFile:filePath atomically:YES];
    }
}

@end
