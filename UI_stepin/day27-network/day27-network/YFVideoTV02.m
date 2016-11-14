//
//  YFVideoTV02.m
//  day27-network
//
//  Created by apple on 15/10/30.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFVideoTV02.h"
#import "UIImageView+WebCache.h"
#import "MediaPlayer/MediaPlayer.h"
#import "AVFoundation/AVFoundation.h"
#import "AVKit/AVKit.h"
#import "GDataXMLNode.h"
@interface YFVideoTV02 ()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation YFVideoTV02
@synthesize datas=_datas;
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if(self=[super initWithFrame:frame style:style]){
        self.delegate=self;
        self.dataSource=self;
    }
    return self;
}

-(void)setDatas:(NSMutableArray *)datas{
    
    _datas=datas;
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self reloadData];
    });
}

-(void)setXMLData:(NSData *)data{
    
    [self domParse:data];

    [self setDatas:self.datas];

}

-(void)domParse:(NSData *)data{
    GDataXMLDocument *dom=[[GDataXMLDocument alloc] initWithData:data options:0 error:0];
    GDataXMLElement *ele=  dom.rootElement;
    [ele.children enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        GDataXMLElement *ele=obj;
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        [ele.attributes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            GDataXMLNode *node=obj;
            [dict setObject:node.stringValue forKey:node.name];

        }];
        [self.datas addObject:dict];

    }];
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
    }];
    
    cell.textLabel.text=dict[@"name"];
    
    cell.detailTextLabel.text=[NSString stringWithFormat:@"length:%@ min",dict[@"length"]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict=self.datas[indexPath.row];

    
    AVPlayerViewController *ac=[[AVPlayerViewController alloc] init];
    AVPlayer *player=[AVPlayer playerWithURL:iURL(dict[@"url"])];
    
    ac.player=player;
    
    [self.con presentViewController:ac animated:YES completion:0];
    [player play];
    
}


iLazy4Ary(datas, _datas)

@end
