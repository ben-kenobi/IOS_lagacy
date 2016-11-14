//
//  RootViewController.m
//  KVOTables
//
//  Created by jeff on 11/25/09.
//  Copyright 2009 Jeff LaMarche. All rights reserved.
//

#import "RootViewController.h"


//KVC----NSKeyValueCoding
//KVO----NSKeyValueObserving

@implementation RootViewController
@synthesize items;


- (void) getItems
{
	NSLog(@"aaaaaaa");
}

- (void)insertNewObject {
	
    NSDate *now = [NSDate date];
    [self willChangeValueForKey:@"items"];
    [self insertObject:[NSString stringWithFormat:@"%@", now] inItemsAtIndex:0];
	 
	//[self valueForKey:@"items"];

}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.items = [NSMutableArray array];
	
	//注册一个监听,监听items的变化,如果有变化则会触发
	//- (void)observeValueForKeyPath:(NSString *)keyPath
	//ofObject:(id)object
	//change:(NSDictionary *)change
	//context:(void *)context
	//这个方法
	
	NSString *contexStr = @"contexTest";
    [self addObserver:self
            forKeyPath:@"items"
               options:0
               context:contexStr];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject)];
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];
}
#pragma mark Array Accessors
- (NSUInteger)countOfItems
{
    return [items count];
}

- (id)objectInItemsAtIndex:(NSUInteger)idx
{
    return [items objectAtIndex:idx];
}

- (void)insertObject:(id)anObject inItemsAtIndex:(NSUInteger)idx
{
    [items insertObject:anObject atIndex:idx];
}

- (void)removeObjectFromItemsAtIndex:(NSUInteger)idx
{ 
    [items removeObjectAtIndex:idx];
}

#pragma mark KVO 
//用来监听注册的items变量发生变化，返回的一系列的信息
//keyPath返回的就是注册的变量名－－－这边这个值为items (因为KVO中可以注册多个监听)
//object 对应keyPath所在的对象,因为 keyPath(items)是在RootViewController中声明的所以object为RootViewController对象
//change 返回的dict纪录key值为	NSKeyValueChangeKindKey、NSKeyValueChangeNewKey、NSKeyValueChangeOldKey、NSKeyValueChangeIndexesKey、NSKeyValueChangeNotificationIsPriorKey
//context返回的值是在监听的时候设置的context

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
	//获取变化值
    NSIndexSet *indices = [change objectForKey:NSKeyValueChangeIndexesKey];
	
	NSLog(@"indexSet ==== %@",indices);
    if (indices == nil)
        return; // Nothing to do
    
    
    // Build index paths from index sets
    NSUInteger indexCount = [indices count];
    NSUInteger buffer[indexCount];
    [indices getIndexes:buffer maxCount:indexCount inIndexRange:nil];
    
    NSMutableArray *indexPathArray = [NSMutableArray array];
    for (int i = 0; i < indexCount; i++) {
        NSUInteger indexPathIndices[2];
        indexPathIndices[0] = 0;
        indexPathIndices[1] = buffer[i];
        NSIndexPath *newPath = [NSIndexPath indexPathWithIndexes:indexPathIndices length:2];
		
		NSLog(@"newPath ==== %d,=====%d",newPath.row,newPath.section);
        [indexPathArray addObject:newPath];
    }
    
	//判断值变化是insert、delete、replace
    NSNumber *kind = [change objectForKey:NSKeyValueChangeKindKey];
    if ([kind integerValue] == NSKeyValueChangeInsertion)  // Operations were added
        [self.tableView insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
    else if ([kind integerValue] == NSKeyValueChangeRemoval)  // Operations were removed
        [self.tableView deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
    
    
}


#pragma mark TableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	cell.textLabel.text = [self objectInItemsAtIndex:[indexPath row]];
    return cell;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
        [self removeObjectFromItemsAtIndex:[indexPath row]];
}


- (void)dealloc {
    [items release];
    [super dealloc];
}


@end

