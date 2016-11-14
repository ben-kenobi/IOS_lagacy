//
//  CategoryViewController.m
//  Radio
//
//  Created by Planet1107 on 1/28/12.
//

#import "CategoryViewController.h"
#import "CategoryCell.h"
#import "SitesViewController.h"
#define kPlistName @"categorizedSites"

@implementation CategoryViewController

@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"分类";
        self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
        categories = [[self categoriesFromPlistNamed:kPlistName] retain];
    }
    return self;
}
-(void)turnPlay
{
        //    图片的宽
    CGFloat imageW = self.scrollview.frame.size.width;
    //    CGFloat imageW = 300;
    //    图片高
    CGFloat imageH = self.scrollview.frame.size.height;
    //    图片的Y
    CGFloat imageY = 0;
    //    图片中数
    NSInteger totalCount = 5;
    //   1.添加5张图片
    for (int i = 0; i < totalCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        //        图片X
        CGFloat imageX = i * imageW;
        
        //        设置frame
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        
        //        设置图片
        NSString *name = [NSString stringWithFormat:@"img_0%d", i + 1];
        imageView.image = [UIImage imageNamed:name];
        //        隐藏指示条
        self.scrollview.showsHorizontalScrollIndicator = NO;
        
        [self.scrollview addSubview:imageView];
    }
    
    //    2.设置scrollview的滚动范围
    CGFloat contentW = totalCount *imageW;
    self.scrollview.contentSize = CGSizeMake(contentW, 0);
    
    //    3.设置分页
    self.scrollview.pagingEnabled = YES;
    
    //    self.pageControl.currentPage = 3;
    
    //    4.监听scrollview的滚动
    self.scrollview.delegate = self;
    
    
    //    NSTimer // 定时器 适合用来隔一段时间做一些间隔比较长的操作
    /*
     NSTimeInterval:多长多件操作一次
     target :操作谁
     selector : 要操作的方法
     userInfo: 传递参数
     repeats: 是否重复
     */
    //   self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [self addTimer];
}


#pragma mark-图片轮播
- (void)nextImage
{
    //    NSLog(@"切换图片");
    //    1.获取页码
    /*
     if (self.pageControl.currentPage == 4) {
     self.pageControl.currentPage = 0;
     }else
     {
     //        假设当前是第0页   变成第一页,就会立刻把小红点变成第一页
     self.pageControl.currentPage++;
     }
     */
    
    int page = self.pageControl.currentPage;
    if (page == 4) {
        page = 0;
    }else
    {
        page++;
    }
    
    
    //    2.滚动scrollview
    //    CGFloat x = self.pageControl.currentPage * self.scrollview.frame.size.width;
    CGFloat x = page * self.scrollview.frame.size.width;
    
    self.scrollview.contentOffset = CGPointMake(x, 0);
}

// scrollview滚动的时候调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
//    NSLog(@"滚动中");
    //    计算页码
    //    页码 = (contentoffset.x + scrollView一半宽度)/scrollView宽度
    CGFloat scrollviewW =  scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollviewW / 2) /  scrollviewW;
    self.pageControl.currentPage = page;
}

// 开始拖拽的时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //    关闭定时器(注意点; 定时器一旦被关闭,无法再开启)
    //    [self.timer invalidate];
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //    开启定时器
    [self addTimer];
}

/**
 *  开启定时器
 */
- (void)addTimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
/**
 *  关闭定时器
 */
- (void)removeTimer
{
    [self.timer invalidate];
}




- (void)dealloc {
    [categories release];
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
//    self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
//    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    UIBarButtonItem *backItem=[[UIBarButtonItem alloc]init];
    
    backItem.title=@"后退";
    
    backItem.tintColor=[UIColor blackColor];
    
    self.navigationItem.backBarButtonItem = backItem;
    
    [backItem release];
    //图片轮播
    [self turnPlay];
    if (FourInch) {
//      CGFloat  margin =   ([UIScreen mainScreen].bounds.size.height -self.scrollview.frame.size.width- 60*5-64-44 )/2;
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    }
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
    return 61.0f;
}

//Called when user selects one of the cells in table, presents sites from chosen category in next table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    SitesViewController *sitesViewController = [[SitesViewController alloc] initWithNibName:@"SitesViewController" bundle:nil];
    //创建控制器
    SitesViewController *sitesViewController = [[SitesViewController alloc] init];
    NSLog(@"cur%d======%d",self.currentSitesViewController.identifier,indexPath.row + 1);
    
    //如果当前选中的是正在播放的那个
    if (self.currentSitesViewController.identifier == (indexPath.row + 1))
    {
        sitesViewController = self.currentSitesViewController;
        //self.currentPlayerVC = playerViewController;
        
    }else{
        
        sitesViewController = [[SitesViewController alloc] initWithNibName:@"SitesViewController" bundle:nil];
        NSLog(@"sitesViewController的地址------%p",sitesViewController);
    }
    
    //创建标识
    sitesViewController.identifier = indexPath.row + 1;
    
    NSLog(@"sit%d======%d",sitesViewController.identifier,indexPath.row + 1);
    sitesViewController.delegate = self;
    
    [sitesViewController setTitle:[[categories objectAtIndex:indexPath.row] objectForKey:@"categoryName"]];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [sitesViewController setSitesFromCategory:[categories objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:sitesViewController animated:YES];
    [sitesViewController release];
}

#pragma mark - SitesViewControllerDelegate代理方法

- (void)sitesViewSomeOneDidPlay:(SitesViewController *)sitesView
{
    if ([self.currentSitesViewController.currentPlayerVC.aPlayer getStatus] == eAudioRunning) {
        [self.currentSitesViewController.currentPlayerVC stopPlayAudio];
    }
    self.currentSitesViewController = sitesView;
    
}

#pragma mark - UITableView data source methods

//Configures cells for each row.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    
    
    CategoryCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
       
        cell = [[[CategoryCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell-normal-no-speaker"]] autorelease];
    }
    [cell.titleLabel setText:[[categories objectAtIndex:indexPath.row] objectForKey:@"categoryName"]];
    
    //    //---------------------------------------------
    //    // 1.显示名称
    //    self.textLabel.text = friendData.name;
    //    self.textLabel.textColor = friendData.vip ? [UIColor redColor] : [UIColor blackColor];
    //
    //    // 2.显示签名
    //    self.detailTextLabel.text = friendData.intro;
    //
    //    // 3.显示头像
    //    self.imageView.image = [UIImage imageNamed:friendData.icon];
    //    //---------------------------------------------
    
    //#warning 注释---cell背景
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    if (indexPath.row == 0) {
        
        cell.imageView.image = [UIImage imageNamed:@"xwCell"];
        cell.detailTextLabel.text = @"在这里你可以知晓最热门的新闻";
        
        
        
    }else if (indexPath.row == 1){
        cell.imageView.image = [UIImage imageNamed:@"ylCell"];
        cell.detailTextLabel.text = @"精彩的娱乐信息等着你";
        
    }else if (indexPath.row == 2){
        cell.imageView.image = [UIImage imageNamed:@"jtCell"];
        cell.detailTextLabel.text = @"你可以了解全面的经济,交通信息";
    }else if (indexPath.row == 3){
        cell.imageView.image = [UIImage imageNamed:@"zhCell"];
        cell.detailTextLabel.text = @"综合频道,信息综合,不容错过";
    }else if (indexPath.row == 4){
        cell.imageView.image = [UIImage imageNamed:@"tjCell"];
        cell.detailTextLabel.text = @"为你准备了很多精彩的电台";
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [categories count];
}

//Reads all available categories, sites are stored in each category for later use.
- (NSArray*)categoriesFromPlistNamed:(NSString*)plistName {
    NSMutableArray *newCategories = [[NSMutableArray alloc] init];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    
    if (plistPath) {
        
        NSDictionary *categorizedSites = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        
        for (int i = 0; i < [categorizedSites count]; i++) {
            NSDictionary *category = [categorizedSites objectForKey:[NSString stringWithFormat:@"Item%d", i]];
            [newCategories addObject:category];
        }
    }
    return [newCategories autorelease];
}

@end
