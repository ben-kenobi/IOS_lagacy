//
//  YFDetailVC.m
//  day30-tuangou
//
//  Created by apple on 15/11/9.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFDetailVC.h"
#import "TFDeal.h"
#import "YFMTUtil.h"
#import "YFDealTool.h"
#import "MBProgressHUD+MJ.h"
#import "MJExtension.h"
#import "YFRestrictions.h"
#import "AlixLibService.h"
#import "AlixPayOrder.h"
#import "PartnerConfig.h"
#import "DataSigner.h"
#import "YFConst.h"

@interface YFDetailVC ()<UIWebViewDelegate>
@property (nonatomic,strong)UIWebView *wv;
@property (nonatomic,strong)UIActivityIndicatorView *roll;
@property (nonatomic,weak)UIButton *back;
@property (nonatomic,weak)UILabel *titleLab;
@property (nonatomic,weak)UILabel *descLab;
@property (nonatomic,weak)UIButton *buy;
@property (nonatomic,weak)UIButton *share;
@property (nonatomic,weak)UIButton *collect;
@property (nonatomic,weak)UIButton *refund1;
@property (nonatomic,weak)UIButton *refund2;
@property (nonatomic,weak)UIButton *refund3;
@property (nonatomic,weak)UIButton *refund4;
@end

@implementation YFDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initUI2];
}
-(void)initUI2{
    [self.view setBackgroundColor:iGlobalBG];
//    self.wv.hidden=YES;
//    [self.wv loadRequest:[NSURLRequest requestWithURL:iURL(self.deal.deal_h5_url)]];

    [self.wv loadRequest:[NSURLRequest requestWithURL:iURL(([NSString stringWithFormat:@"file://%@",iRes(@"detail.html")]))]];
   

    
//    self.titleLab.text=self.deal.title;
//    self.descLab.text=self.deal.desc;
//    
//    NSDate *to=[NSDate dateFromStr:self.deal.purchase_deadline];
//    to=[to dateByAddingTimeInterval:24*60*60];
//    NSDate *now=[NSDate date];
//    NSCalendarUnit unit= NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
//    NSDateComponents *cmps=[[NSCalendar currentCalendar] components:unit fromDate:now toDate:to options:0];
//    if(cmps.day>365){
//        [self.refund2 setTitle:@"一年内不过期" forState:UIControlStateNormal];
//    }else{
//        [self.refund2 setTitle:[NSString stringWithFormat:@"%ld天%ld小时%ld分钟",cmps.day,cmps.hour,cmps.minute] forState:UIControlStateNormal];
//    }
//    
////    self.collect.selected=[YFDealTool isCollected:self.deal];
//    
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//
//    params[@"deal_id"] = self.deal.deal_id;
//    [YFMTUtil dpget:@"v1/deal/get_single_deal" dict:params cache:1 callBack:^(NSData *data, NSURLResponse *response, NSError *error) {
//        if(data&&!error){
//             NSDictionary *dict=[[NSJSONSerialization JSONObjectWithData:data options:0 error:0][@"deals"] firstObject];
//            self.deal=[TFDeal objectWithKeyValues:dict];
//            self.refund1.selected=self.deal.restrictions.is_refundable;
//            self.refund3.selected=self.deal.restrictions.is_refundable;
//        }else{
//            [MBProgressHUD showError:@"网络繁忙,稍后再试"];
//        }
//    }];
// 
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    if([webView.request.URL.absoluteString isEqualToString:self.deal.deal_h5_url]){
        NSString *url=[self.deal.deal_id substringFromIndex:[self.deal.deal_id rangeOfString:@"-"].location+1];
        url=[NSString stringWithFormat:@"http://lite.m.dianping.com/group/deal/moreinfo/%@",url];
        [self.wv loadRequest:[NSURLRequest requestWithURL:iURL(url)]];
    }else{
        [self.roll stopAnimating];
        webView.hidden=NO;
        NSMutableString *js=[NSMutableString string];
        [js appendString:@"var header=document.getElementsByTagName('header')[0];"
         "header.parentNode.removeChild(header);"
         "var box=document.getElementsByClassName('cost-box')[0];"
         "box.parentNode.removeChild(box);"
         "var buyNow=document.getElementsByClassName('buy-now')[0];"
         "buyNow.parentNode.removeChild(buyNow);"
         ];
        
//        [webView stringByEvaluatingJavaScriptFromString:js];
    }
}



-(void)onBtnClicked:(id)sender{
    if(sender==self.back){
        [self dismissViewControllerAnimated:YES completion:0];
    }else if(sender==self.buy){
//        [iApp openURL:iURL(self.deal.deal_url)];
        AlixPayOrder *order=[[AlixPayOrder alloc] init];
        order.productName=self.deal.title;
        order.productDescription=self.deal.desc;
        order.partner=PartnerID;
        order.seller=SellerID;
        order.amount=[self.deal.current_price description];
//        id<DataSigner>signer=CreateRSADataSigner(PartnerPrivKey);
//        NSString *signedStr=[signer signString:[order description]];
//        NSString *orderstr=[NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",[order description],signedStr,@"RSA"];
//        [AlixLibService payOrder:orderstr AndScheme:@"tuangou" seletor:@selector(payCb:) target:self];
        
    }else if(sender==self.collect){
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        dict[CollectDeal]=self.deal;
        if(self.collect.isSelected){
            [YFDealTool removeCollectDeal:self.deal];
            [MBProgressHUD showSuccess:@"取消收藏成功" toView:self.view];
            dict[IsCollected]=@NO;
        }else{
            [YFDealTool addCollectDeal:self.deal];
            [MBProgressHUD showSuccess:@"收藏成功" toView:self.view];
            dict[IsCollected]=@YES;
        }
        self.collect.selected=!self.collect.isSelected;
        if(self.onCollectChange)
            self.onCollectChange(dict);
        
        
    }else if(sender==self.share){
        
    }else{
//        [sender setSelected:![sender isSelected]];
    }
}

-(void)payCb:(id)result{
    NSLog(@"%@",result);
}




-(UIView *)initbanner{
    UIView *banner=[[UIView alloc] init];
    UIImageView *iv=[[UIImageView alloc] initWithImage:img(@"bg_navigationBar_normal")];
    [banner addSubview:iv];
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    UIButton *btn=[[UIButton alloc] init];
    [btn setImage:img(@"icon_back") forState:UIControlStateNormal];
    [btn setImage:img(@"icon_back_highlighted") forState:UIControlStateNormal];
    [banner addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(@0);
        make.height.width.equalTo(@44);
    }];
    self.back=btn;
    [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lab=[[UILabel alloc] init];
    [banner addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@44);
    }];
    [lab setTextAlignment:NSTextAlignmentCenter];
    lab.text=@"团购详情";
    lab.font=[UIFont boldSystemFontOfSize:20];
    
    return banner;
}
-(UIView *)initmainv{
    UIView *mainv=[[UIView alloc] init];
    UIImageView *iv=[[UIImageView alloc] initWithImage:img(@"placeholder_deal")];
    [mainv addSubview:iv];
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@180);
        make.top.left.right.equalTo(@0);
    }];
    UILabel *title=[[UILabel alloc]init];
    [mainv addSubview:title];
    self.titleLab=title;
    title.text=@"title";
    title.font=[UIFont systemFontOfSize:17];
    [title setNumberOfLines:0];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(iv.mas_bottom).offset(10);
    }];
    
    UILabel *desc=[[UILabel alloc] init];
    [mainv addSubview:desc];
    self.descLab=desc;
    desc.text=@"描述";
    [desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(title.mas_bottom).offset(10);
    }];
    desc.font=[UIFont systemFontOfSize:17];
    [desc setNumberOfLines:0];
    
    UIView *midv=[self initmidv];
    [mainv addSubview:midv];
    [midv setBackgroundColor:[UIColor clearColor]];
    [midv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(desc.mas_bottom);
        make.left.right.equalTo(@0);
        make.height.equalTo(@60);
    }];
    
    UIView *botv=[self initbotv];
    [mainv addSubview:botv];
    [botv setBackgroundColor:[UIColor clearColor]];
    [botv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(midv.mas_bottom);
        make.height.equalTo(@80);
    }];
    
    
    return mainv;
}

-(UIView *)initmidv{
    UIView *view=[[UIView alloc] init];
    UIButton *buy=[[UIButton alloc] init];
    [view addSubview:buy];
    [buy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.equalTo(@-8);
        make.width.equalTo(@150);
        make.height.equalTo(@35);
    }];
    self.buy=buy;
    [buy setTitle:@"立即购买" forState:UIControlStateNormal];
    [buy setBackgroundImage:img(@"bg_deal_purchaseButton") forState:UIControlStateNormal];
    [buy setBackgroundImage:img(@"bg_deal_purchaseButton_highlighted") forState:UIControlStateHighlighted];
    [buy addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *share=[UIButton buttonWithType:UIButtonTypeSystem];
    [view addSubview:share];
    [share addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [share mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@40);
        make.right.equalTo(@-40);
        make.centerY.equalTo(@0);
    }];
    share.titleLabel.font=[UIFont systemFontOfSize:15];
    [share setTitle:@"分享" forState:UIControlStateNormal];
    [share setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    self.share=share;
    
    UIButton *collec=[[UIButton alloc] init];
    [collec addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.collect=collec;
    [view addSubview:collec];
    [collec mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@60);
        make.right.equalTo(share.mas_leading).offset(-30);
        make.bottom.equalTo(@0);
    }];
    [collec setBackgroundImage:img(@"icon_collect") forState:UIControlStateNormal];
    [collec setBackgroundImage:img(@"icon_collect_highlighted") forState:UIControlStateHighlighted];
    
    
    return view;
}
-(UIView *)initbotv{
    UIView *view=[[UIView alloc] init];
    
    UIButton *(^newb)(NSString *)=^(NSString *title){
        UIButton *b=[[UIButton alloc] init];
        [b setTitle:title forState:UIControlStateNormal];
        [view addSubview:b];
        b.titleLabel.font=[UIFont systemFontOfSize:13];
        [b setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [b setImage:img(@"icon_order_unrefundable") forState:UIControlStateNormal];
        [b setImage:img(@"icon_order_refundable") forState:UIControlStateSelected];
        [b setContentEdgeInsets:(UIEdgeInsets){0,15,0,0}];
        [b setTitleEdgeInsets:(UIEdgeInsets){0,10,0,0}];
        [b addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        return b;
    };
    self.refund1=newb(@"支持随时退");
    self.refund2=newb(@"支持过期退");
    self.refund3=newb(@"支持过期退");
    self.refund4=newb(@"支持过期退");
    [self.refund1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.equalTo(@0);
        make.width.height.equalTo(view).multipliedBy(.5);
    }];
    [self.refund2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(@0);
        make.width.height.equalTo(view).multipliedBy(.5);
    }];
    [self.refund3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.equalTo(@0);
        make.width.height.equalTo(view).multipliedBy(.5);
    }];
    [self.refund4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(@0);
        make.width.height.equalTo(view).multipliedBy(.5);
    }];
    
    return view;
}

-(void)initUI{
    UIView *view=[[UIView alloc] init];
    [view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(@0);
        make.width.equalTo(@400);
    }];
    UIView *banner=[self initbanner];
    [view addSubview:banner];
    [banner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.height.equalTo(@64);
    }];
    [banner setBackgroundColor:[UIColor clearColor]];
    
    UIView *mainv=[self initmainv];
    [view addSubview:mainv];
    [mainv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(banner.mas_bottom).offset(15);
        make.right.equalTo(@-15);
        make.bottom.equalTo(@-15);
    }];
    [mainv setBackgroundColor:[UIColor clearColor]];
    
    
    
    self.wv=[[UIWebView alloc] init];
    self.wv.delegate=self;
    [self.view addSubview:self.wv];
    [self.wv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(@0);
        make.left.equalTo(view.mas_right).offset(20);
    }];
    [self.wv setBackgroundColor:[UIColor clearColor]];
    
    self.roll=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.roll.color=[UIColor grayColor];
    [self.view addSubview:self.roll];
    [self.roll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.wv);
    }];
    [self.roll setHidesWhenStopped:YES];
    [self.roll startAnimating];
    
    
}






@end
