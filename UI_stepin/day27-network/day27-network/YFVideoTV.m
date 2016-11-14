//
//  YFVideoTV.m
//  day27-network
//
//  Created by apple on 15/10/30.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFVideoTV.h"
#import "UIImageView+WebCache.h"
#import "MediaPlayer/MediaPlayer.h"
#import "AVFoundation/AVFoundation.h"
#import "AVKit/AVKit.h"

@interface YFVideoTV ()<UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate>
@property (nonatomic,strong)NSMutableDictionary *dict;
@property (nonatomic,strong)NSMutableString *mstr;

@end

@implementation YFVideoTV
@synthesize datas=_datas ;

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if(self=[super initWithFrame:frame style:style]){
        self.delegate=self;
        self.dataSource=self;
    }
    return self;
}
-(NSMutableString *)mstr{
    if(!_mstr){
        _mstr=[NSMutableString string];
    }
    return _mstr;
}

-(void)setDatas:(NSMutableArray *)datas{

    _datas=datas;
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self reloadData];
    });
}

-(void)setXMLData:(NSData *)data{
    NSXMLParser *parser=[[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
    [parser parse];
    [self setDatas:self.datas];
    NSLog(@"%@",self.datas);

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden=@"celliden";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
    if(!cell){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
    }
    NSDictionary *dict=self.datas[indexPath.row];
    [cell.imageView sd_setImageWithURL:iURL(dict[@"image"]) placeholderImage:img(@"minion_01.png") options:0 progress:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:0];
    }];
    
    cell.textLabel.text=dict[@"name"];
    
    cell.detailTextLabel.text=[NSString stringWithFormat:@"length:%@ min",dict[@"length"]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict=self.datas[indexPath.row];
    //    MPMoviePlayerViewController *mc=[[MPMoviePlayerViewController alloc] initWithContentURL:iURL(dict[@"url"])];
    //    [self presentMoviePlayerViewControllerAnimated:mc];
    
    AVPlayerViewController *ac=[[AVPlayerViewController alloc] init];
    AVPlayer *player=[AVPlayer playerWithURL:iURL(dict[@"url"])];
    
    ac.player=player;
    
    [self.con presentViewController:ac animated:YES completion:0];
    [player play];
    
}






- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    if([elementName isEqualToString:@"vedio"]){
        self.dict=[NSMutableDictionary dictionary];
    }
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [self.mstr setString:string];
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"vedio"]){
        [self.datas addObject:self.dict];
        self.dict=0;
    }else{
        [self.dict setObject:[self.mstr copy] forKey:elementName];
    }
    
}



iLazy4Ary(datas, _datas)

@end
