//
//  ViewController.m
//  gradViewTest
//
//  Created by 1 on 15/11/11.
//  Copyright © 2015年 stdio dollar. All rights reserved.
//

#import "ViewController.h"
#import "HMCollectionCell.h"
#import "HMCollectionViewModel.h"
#import "HMNavCollection.h"
#import "UIView+HMFrame.h"
#define TAG 88
#define KWIDTH [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)NSMutableArray *cellModels;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property(nonatomic,weak)UIButton *navButton1;
@property(nonatomic,weak)UIButton *navButton2;

@property(nonatomic,weak)HMNavCollection *navCollection;

@property(nonatomic,strong)HMCollectionCell *currentCell;


@end

@implementation ViewController
{
    NSInteger cellSection;
    NSIndexPath *currentIndex;
}



-(NSMutableArray *)cellModels{

    if (!_cellModels) {
        _cellModels = [NSMutableArray array];
    }
    return _cellModels;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];

    self.collectionView.pagingEnabled = YES;
    
    currentIndex = 0;

    [self loadDataWithURLString:@"http://localhost/resources/vedios.json"];
    
    UIButton *navButton1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 45, 60, 60)];
    
    [navButton1 setImage:[UIImage imageNamed:@"1_10"] forState:UIControlStateNormal];
    
    [self.view addSubview:navButton1];
    self.navButton1 = navButton1;
    
    [navButton1 addTarget:self action:@selector(didClickNavButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(scrollCollectionToIndexToNotifi:) name:@"collectionScrollToIndex" object:nil];

    
}

-(void)scrollCollectionToIndexToNotifi:(NSNotification *)notifi{

    NSIndexPath *indexPath = notifi.object;
    
    HMCollectionViewModel *model = self.cellModels[indexPath.item];
    
    self.currentCell.model = model;
    
    
}

-(void)cancelNavButton:(UIButton *)sender{
    
    self.navButton1.x = - 60;
    
    [UIView animateWithDuration:1 animations:^{
        
    
        self.navCollection.x = KWIDTH;
        self.navButton2.x = KWIDTH;
        
    }completion:^(BOOL finished) {
        
        [self.navCollection removeFromSuperview];
        
        [UIView animateWithDuration:0.5 animations:^{
            self.navButton1.x = 0;
        }];
    }];

}

- (void)didClickNavButton:(UIButton *)sender {
    
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    
    HMNavCollection *navCollection = [[HMNavCollection alloc]initWithFrame:CGRectMake(0, 20, 0, 35) collectionViewLayout:layout];

    navCollection.cuttentIndex = currentIndex;
    
    navCollection.NavDatas = self.cellModels;
    
    [navCollection setMyblock:^{
       
        [self cancelNavButton:nil];
        
    }];
    
    [self.view addSubview:navCollection];
    self.navCollection = navCollection;
    
    [UIView animateWithDuration:1 animations:^{
        
        sender.x = KWIDTH;
        
        navCollection.w = KWIDTH;
        
        
    }completion:^(BOOL finished) {
        
        UIButton *navButton2 = [[UIButton alloc]initWithFrame:CGRectMake(-60, 45, 60, 60)];
        
        [navButton2 setImage:[UIImage imageNamed:@"1_10"] forState:UIControlStateNormal];
        
        [self.view addSubview:navButton2];
        [navButton2 addTarget:self action:@selector(cancelNavButton:) forControlEvents:UIControlEventTouchUpInside];
        self.navButton2 = navButton2;
        
        [UIView animateWithDuration:0.5 animations:^{
            self.navButton2.x = 0;
            
        }];
        
    }];
    
    
    
    
}

-(void)loadDataWithURLString:(NSString *)urlString{

    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [[[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        if (data && !error) {
            

            
        NSArray *videosArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            
        [videosArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            
            NSDictionary *dict = obj;
            
            HMCollectionViewModel *model = [HMCollectionViewModel collectionViewModelWithDict:dict];
            
            [self.cellModels addObject:model];
            
        }];
            
            dispatch_async(dispatch_get_main_queue(), ^{
               
                
            });
            
        }
        
        
    }]resume];
    

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 1;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{


    return self.cellModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    HMCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"resume" forIndexPath:indexPath];
    
    
    HMCollectionViewModel *model = self.cellModels[indexPath.section];
    
    cellSection = indexPath.section;
    
    cell.model = model;
    
    currentIndex = indexPath;
    
    cell.VC = self;
    
    self.currentCell = cell;


    
    return cell;

}









@end
