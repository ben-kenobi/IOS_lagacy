

//
//  LoadView.m
//  day43-shoppingcart
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 yf. All rights reserved.
//

#import "LoadView.h"

@implementation LoadView


+(NSArray *)datas{
    
    NSMutableArray *_dockArray =[NSMutableArray array];
    for ( int i=0; i<7; i++) {
        if (i==0) {
            NSMutableDictionary *dic =[NSMutableDictionary dictionary];
            
            NSMutableArray *array =[NSMutableArray array];
            
            
            
            for (int i=0; i<7; i++) {
                if (i==0) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"1.jpg",@"name":@"德国OETTINGER奥丁格大麦啤酒500ml*4罐/组",@"money":@"39",@"OriginalPrice":@"56",@"Quantity":@"0",@"ProductID":@"q",@"Discount":@"7折"} mutableCopy];
                    [array addObject:dic1];
                }
                if (i==1) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"2.jpg",@"name":@"德拉克（Durlacher） 黑啤酒 330ml*6听",@"money":@"40",@"OriginalPrice":@"67",@"Quantity":@"0",@"ProductID":@"w",@"Discount":@"6折"} mutableCopy];
                    [array addObject:dic1];
                }
                if (i==2) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"3.jpg",@"name":@"奥塔利金爵 啤酒500ml*12 匈牙利原装低度进口啤酒酒水饮品",@"money":@"109",@"OriginalPrice":@"218",@"Quantity":@"0",@"ProductID":@"e",@"Discount":@"5折"} mutableCopy];
                    [array addObject:dic1];
                }
                if (i==3) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"4.jpg",@"name":@"德国啤酒 原装进口啤酒 flensburger/弗伦斯堡啤酒 土豪金啤 5L 桶装啤酒",@"money":@"158",@"OriginalPrice":@"226",@"Quantity":@"0",@"ProductID":@"r",@"Discount":@"7折"} mutableCopy];
                    [array addObject:dic1];
                }
                if (i==4) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"5.jpg",@"name":@"青岛啤酒 经典 醇厚 啤酒500ml*12听/箱 国产 整箱",@"money":@"66",@"OriginalPrice":@"110",@"Quantity":@"0",@"ProductID":@"t",@"Discount":@"6折"} mutableCopy];
                    [array addObject:dic1];
                }
                if (i==5) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"6.jpg",@"name":@"京姿 百威罐装330ml*24 啤酒",@"money":@"140",@"OriginalPrice":@"200",@"Quantity":@"0",@"ProductID":@"y",@"Discount":@"7折"} mutableCopy];
                    [array addObject:dic1];
                }
                if (i==6) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"7.jpg",@"name":@"德国OETTINGER奥丁格自然浑浊型小麦啤酒500ml*4罐/组",@"money":@"58",@"OriginalPrice":@"129",@"Quantity":@"0",@"ProductID":@"u",@"Discount":@"4.5折"} mutableCopy];
                    [array addObject:dic1];
                }
                
                
            }
            dic =[@{@"dockName":@"啤酒",@"right":array} mutableCopy];
            [_dockArray addObject:dic];
            
        }
        if (i==1) {
            NSMutableDictionary *dic =[NSMutableDictionary dictionary];
            
            NSMutableArray *array =[NSMutableArray array];
            
            
            
            for (int i=0; i<8; i++) {
                if (i==0) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"8.jpg",@"name":@"Martell马爹利名士1000ML 进口洋酒 名仕干邑白兰地1L",@"money":@"695",@"Quantity":@"0",@"ProductID":@"a"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==1) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"9.jpg",@"name":@"奥美加银龙舌兰【OLMECA TEQUILA】38% 750ml",@"money":@"108",@"Quantity":@"0",@"ProductID":@"s"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==2) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"10.jpg",@"name":@"人头马天醇XO特优香槟干邑白兰地700ml",@"money":@"1386",@"Quantity":@"0",@"ProductID":@"d"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==3) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"11.jpg",@"name":@"40°法国马爹利蓝带干邑白兰地700ml",@"money":@"1080",@"Quantity":@"0",@"ProductID":@"f"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==4) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"12.jpg",@"name":@"沙皇伏特加塞珞700ml限量版",@"money":@"598",@"Quantity":@"0",@"ProductID":@"g"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==5) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"13.jpg",@"name":@"百加得黑朗姆酒 烈酒 750ml",@"money":@"92",@"Quantity":@"0",@"ProductID":@"h"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==6) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"14.jpg",@"name":@"Seagrams Gin 750ML 40度",@"money":@"99",@"Quantity":@"0",@"ProductID":@"j"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==7) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"15.jpg",@"name":@"马爹利蓝带干邑白兰地 700ml",@"money":@"1060",@"Quantity":@"0",@"ProductID":@"k"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                
                
            }
            dic =[@{@"dockName":@"洋酒",@"right":array} mutableCopy];
            [_dockArray addObject:dic];
            
        }
        if (i==2) {
            NSMutableDictionary *dic =[NSMutableDictionary dictionary];
            
            NSMutableArray *array =[NSMutableArray array];
            
            
            
            for (int i=0; i<8; i++) {
                if (i==0) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"16.jpg",@"name":@"张裕解百纳干红葡萄酒双支礼盒 750ml*2",@"money":@"158",@"Quantity":@"0",@"ProductID":@"z"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==1) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"17.jpg",@"name":@"爱之湾+兰贵人组合",@"money":@"1230",@"Quantity":@"0",@"ProductID":@"x"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==2) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"18.jpg",@"name":@"菲卡珍藏莎当妮葡萄酒750ml",@"money":@"138",@"Quantity":@"0",@"ProductID":@"c"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==3) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"19.jpg",@"name":@"拉图嘉利庄园干红葡萄酒",@"money":@"1580",@"Quantity":@"0",@"ProductID":@"v"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==4) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"20.jpg",@"name":@"报恩城堡干红葡萄酒 六支装",@"money":@"1890",@"Quantity":@"0",@"ProductID":@"b"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==5) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"21.jpg",@"name":@"豪克玛歌庄园干红葡萄酒 750ml 1支装",@"money":@"2360",@"Quantity":@"0",@"ProductID":@"h"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==6) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"22.jpg",@"name":@"白浪莎庄园干红葡萄酒 750ml",@"money":@"98",@"Quantity":@"0",@"ProductID":@"n"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==7) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"23.jpg",@"name":@"布兰多庄园干红葡萄酒 750ml 1支装",@"money":@"3690",@"Quantity":@"0",@"ProductID":@"m"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                
                
            }
            dic =[@{@"dockName":@"红酒",@"right":array} mutableCopy];
            [_dockArray addObject:dic];
            
        }
        if (i==3) {
            NSMutableDictionary *dic =[NSMutableDictionary dictionary];
            
            NSMutableArray *array =[NSMutableArray array];
            
            for (int i=0; i<8; i++) {
                if (i==0) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"24.jpg",@"name":@"白俄罗斯鸡尾酒",@"money":@"238",@"Quantity":@"0",@"ProductID":@"z"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==1) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"25.jpg",@"name":@"莫吉托",@"money":@"233",@"Quantity":@"0",@"ProductID":@"x"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==2) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"26.jpg",@"name":@"绝对柚惑",@"money":@"115",@"Quantity":@"0",@"ProductID":@"c"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==3) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"27.jpg",@"name":@"马蒂尼里",@"money":@"1580",@"Quantity":@"0",@"ProductID":@"v"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==4) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"28.jpg",@"name":@"绝对甜蜜",@"money":@"138",@"Quantity":@"0",@"ProductID":@"b"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==5) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"29.jpg",@"name":@"精致女士",@"money":@"138",@"Quantity":@"0",@"ProductID":@"h"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==6) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"30.jpg",@"name":@"绝对柠檬",@"money":@"138",@"Quantity":@"0",@"ProductID":@"n"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                if (i==7) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"31.jpg",@"name":@"绝对野趣",@"money":@"138",@"Quantity":@"0",@"ProductID":@"m"} mutableCopy];
                    [array addObject:dic1]; ;
                }
                
                
            }            dic =[@{@"dockName":@"特色酒",@"right":array} mutableCopy];
            [_dockArray addObject:dic];
        }
        
        if (i==4) {
            NSMutableDictionary *dic =[NSMutableDictionary dictionary];
            
            NSMutableArray *array =[NSMutableArray array];
            
            for (int i=0; i<2; i++) {
                if (i==0) {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"32.jpg",@"name":@"苹果、火龙果、西瓜、哈密瓜、杨桃（大）",@"money":@"89",@"Quantity":@"0",@"ProductID":@"ww"} mutableCopy];
                    [array addObject:dic1];
                }
                if(i==1)
                {
                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
                    dic1=[@{@"image":@"32.jpg",@"name":@"苹果、火龙果、西瓜、哈密瓜、杨桃（小）",@"money":@"89",@"Quantity":@"0",@"ProductID":@"ww"} mutableCopy];
                    [array addObject:dic1];
                }
            }
            dic =[@{@"dockName":@"果盘",@"right":array} mutableCopy];
            [_dockArray addObject:dic];
            
        }
        //        if (i==5) {
        //            NSMutableDictionary *dic =[NSMutableDictionary dictionary];
        //
        //            NSMutableArray *array =[NSMutableArray array];
        //
        //            for (int i=0; i<2; i++) {
        //                if (i==0) {
        //                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
        //                    dic1=[@{@"image":@"32.jpg",@"name":@"瓜子（大）",@"money":@"89",@"Quantity":@"0",@"ProductID":@"ww"} mutableCopy];
        //                    [array addObject:dic1];
        //                }
        //                if(i==1)
        //                {
        //                    NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
        //                    dic1=[@{@"image":@"32.jpg",@"name":@"瓜子（小）",@"money":@"89",@"Quantity":@"0",@"ProductID":@"ww"} mutableCopy];
        //                    [array addObject:dic1];
        //                }
        //            dic =[@{@"dockName":@"休闲食品",@"right":array} mutableCopy];
        //            [_dockArray addObject:dic];
        //
        //        }
        //        if (i==6) {
        //            NSMutableDictionary *dic =[NSMutableDictionary dictionary];
        //
        //            NSMutableArray *array =[NSMutableArray array];
        //
        //            for (int i=0; i<20; i++) {
        //                NSMutableDictionary *dic1 =[NSMutableDictionary dictionary];
        //                dic1=[@{@"image":@"0000000.jpg",@"name":@"大缤纷",@"money":@"56",@"Quantity":@"0",@"ProductID":@"rr"} mutableCopy];
        //                [array addObject:dic1]; ;
        //            }
        //            dic =[@{@"dockName":@"软饮",@"right":array} mutableCopy];
        //            [_dockArray addObject:dic];
        //
        //        }
        
        
    }
    return _dockArray;
}

@end
