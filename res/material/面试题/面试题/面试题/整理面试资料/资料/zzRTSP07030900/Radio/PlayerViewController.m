

//知音无 q确认无
//常州电台交通无
//陕西电台故事崩/无崩
//复兴电台2无
//霍山电台崩/无崩
//台南知音无
//recent:白80
//favortite :白20
//set:白44
//cater ok
//版本说明:白 64
//  PlayerVie/Volumes/AAA/sourceCode/源码ios/收音机总资料/收音机正在修改/zzRTSP0625_2142/Radio/PlayerViewController.mwController.m
//  Radio

//  Created by Planet1107 on 1/28/12.
//
#warning 注释---加载播放界面慢解决
//#import"ViewController.h"
#define KAnimationWandH  320
//#import "UIImageView+WebCache.h"
#import "PlayerViewController.h"
#import "MBProgressHUD+MJ.h"
#define kFavoritesPlistName @"favoriteSites"
//动画效果
#import "LYBgImageView.h"
#import "LYMovePathView.h"
#import "LYFireworksView.h"


//---------------^------------------
BOOL isPlayBlock = NO;
BOOL isRestartAudio=NO;


//ViewController *g_viewController;显示蒙板

typedef enum {
    kTCP = 0,
    kUDP
}kNetworkWay;
//--------------------------------


//---------------------------------
@interface PlayerViewController ()
{
    AVFormatContext *pFormatCtx;
    AVCodecContext *pAudioCodeCtx;
    int    audioStream;
    //AudioPlayer *aPlayer;
    /** 停止播放视频*/
    BOOL  isStop;
    BOOL  isLocalFile;
}
@end
//---------------------------------


@implementation PlayerViewController

@synthesize siteLink;
@synthesize siteLogo;
@synthesize logoImageView;
@synthesize favoriteButton;
@synthesize playButton;





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





//开始点击按钮调用此处
- (void)stopPlayAudio
{
    //停止播放流
    [self stopFFmpegAudioStream];
   
    [_aPlayer stop:YES];

    
    //销毁播放流
    [self destroyFFmpegAudioStream];
}

/** 初始化播放流*/
#pragma mark - FFmpeg processing
- (BOOL)initFFmpegAudioStream:(NSString *)filePath withTransferWay:(kNetworkWay)network
{
    NSString *pAudioInPath;
    AVCodec  *pAudioCodec;
    
    // Parse header
    uint8_t pInput[] = {0x0ff,0x0f9,0x058,0x80,0,0x1f,0xfc};
    tAACADTSHeaderInfo vxADTSHeader={0};
    [AudioUtilities parseAACADTSHeader:pInput toHeader:(tAACADTSHeaderInfo *) &vxADTSHeader];
    
    // Compare the file path
    if (strncmp([filePath UTF8String], "rtsp", 4) == 0) {
        pAudioInPath = filePath;
        isLocalFile = NO;
    } else if (strncmp([filePath UTF8String], "mms:", 4) == 0) {
        pAudioInPath = [filePath stringByReplacingOccurrencesOfString:@"mms:" withString:@"rtsp:"];
        NSLog(@"Audio path %@", pAudioInPath);
        

        
        isLocalFile = NO;
    } else if (strncmp([filePath UTF8String], "mmsh:", 4) == 0) {
        pAudioInPath = filePath;
        isLocalFile = NO;
    } else {
        pAudioInPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingString:filePath];
        isLocalFile = YES;
    }
    
    // Register FFmpeg
    avcodec_register_all();
    av_register_all();
    if (isLocalFile == NO) {
        avformat_network_init();
    }
    
    @synchronized(self) {
        pFormatCtx = avformat_alloc_context();
        //zzzili
        //pFormatCtx->interrupt_callback.callback = interrupt_cb;//--------注册回调函数
        //pFormatCtx->interrupt_callback.opaque = pFormatCtx;
    }
    
    // Set network path
    switch (network) {
        case kTCP:
        {
            AVDictionary *option = 0;
            av_dict_set(&option, "rtsp_transport", "tcp", 0);
            // Open video file
            if (avformat_open_input(&pFormatCtx, [pAudioInPath cStringUsingEncoding:NSASCIIStringEncoding], NULL, &option) != 0) {



                NSLog(@"Could not open connection");
                return NO;
            }
            av_dict_free(&option);
        }
            break;
        case kUDP:
        {
            if (avformat_open_input(&pFormatCtx, [pAudioInPath cStringUsingEncoding:NSASCIIStringEncoding], NULL, NULL) != 0) {


                NSLog(@"Could not open connection");
                return NO;
            }
        }
            break;
    }
    
    pAudioInPath = nil;
    
    // Retrieve stream information
    if (avformat_find_stream_info(pFormatCtx, NULL) < 0) {
        NSLog(@"Could not find streaming information");
        return NO;
    }
    
    // Dump Streaming information
    av_dump_format(pFormatCtx, 0, [pAudioInPath UTF8String], 0);
    
    // Find the first audio stream
    if ((audioStream = av_find_best_stream(pFormatCtx, AVMEDIA_TYPE_AUDIO, -1, -1, &pAudioCodec, 0)) < 0) {
        NSLog(@"Could not find a audio streaming information");
        return NO;
    } else {
        // Succeed to get streaming information
        //        NSLog(@"== Audio pCodec Information");
        //        NSLog(@"name = %s",pAudioCodec->name);
        //        NSLog(@"sample_fmts = %d",*(pAudioCodec->sample_fmts));
        
        if (pAudioCodec->profiles) {
            NSLog(@"Profile names = %@", pAudioCodec->profiles);
        } else {
            //            NSLog(@"Profile is Null");
        }
        
        // Get a pointer to the codec context for the video stream
        pAudioCodeCtx = pFormatCtx->streams[audioStream]->codec;
        
        // Find out the decoder
        pAudioCodec = avcodec_find_decoder(pAudioCodeCtx->codec_id);
        
        // Open codec
        if (avcodec_open2(pAudioCodeCtx, pAudioCodec, NULL) < 0) {
            return NO;
        }
    }
    
    isStop = NO;
    
    return YES;
}

-(void)doTimerall
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}


static int interrupt_cb(void *ctx)
{
    // do something
    if(isPlayBlock==YES)
    {
        return 1;
    }
    return 0;
}

/** 获取取播放流并解码*/
- (void)readFFmpegAudioFrameAndDecode
{
    int error;
    AVPacket aPacket;
    av_init_packet(&aPacket);
    
    
    {
        
        // Remote File playing
        while (isStop == NO) {
            //            NSLog(@"%@--putAVPacket------%d",aPlayer,aPlayer->audioPacketQueue.count);
            // Read frame
            error = av_read_frame(pFormatCtx, &aPacket);
            if(isPlayBlock == YES)
            {
                //zzzili
                [self RestartAudio];
                return;
            }
            if (error == AVERROR_EOF) {
                // End of playing music
                isStop = YES;
            } else if (error == 0) {
                // During playing..
                if (aPacket.stream_index == audioStream) {
                    if ([_aPlayer putAVPacket:&aPacket] <=0 ) {
                        NSLog(@"Put Audio packet error");
                    }
                } else {
                    av_free_packet(&aPacket);
                }
            } else {
                // Error occurs
                NSLog(@"av_read_frame error :%s", av_err2str(error));
                isStop = YES;
            }
        }
    }
    NSLog(@"End of playing ffmpeg");
}

/** 播放视屏,是否清除内存*/
-(void)PlayAudioAll:(BOOL)isClearMem
{
    
    
    
    //
//    [self.waitView show:YES];
    
    // 成功播放视频
    /// TODO: determine if this streaming support ffmpeg
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        if ([self initFFmpegAudioStream:channelAddr withTransferWay:kTCP] == NO)
        {
#warning 注释---网络连接失败,请更换电台
            [self doTimerall];
#warning 注释---2
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self doTimerall];
//                NSTimer *timer;
//                [MBProgressHUD showError:@"加载失败" toView:self.view ];
//                timer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(doTimerall) userInfo:nil repeats:NO];
//            });
            
            NSLog(@"Init ffmpeg failed");

            return;
        }
#warning 注释---正在加载中

        if(isClearMem==NO&&_aPlayer != nil&&_aPlayer->audioPacketQueue.count>5)
        {
            [MBProgressHUD hideHUDForView:self.view];
            
            _aPlayer = [[AudioPlayer alloc] initAuido:_aPlayer->audioPacketQueue withCodecCtx:(AVCodecContext *)pAudioCodeCtx];
            
        }
        else
        {
            _aPlayer = [[AudioPlayer alloc] initAuido:nil withCodecCtx:(AVCodecContext *)pAudioCodeCtx];
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if(_aPlayer->audioPacketQueue.count<50||isClearMem == YES)
            {
               
                
               sleep(5);
                [self doTimerall];
#warning 注释---3
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    NSTimer *timer;
//                    [MBProgressHUD showSuccess:@"开始播放" toView:self.view ];
//                    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(doTimerall) userInfo:nil repeats:NO];
//                });
//
//                [self doTimerall];
                NSLog(@"播放");

            }
            

            isRestartAudio = NO;
            if ([_aPlayer getStatus] != eAudioRunning) {
                [_aPlayer play];
            }
        });
        
        // Read Packet in another thread
        [self readFFmpegAudioFrameAndDecode];
        
    });
    // Read ffmpeg audio packet in another thread
    
}

////实现时候将label移除


/** 重新播放视频*/
-(void)RestartAudio
{
    if(isRestartAudio == NO)
    {
        isRestartAudio = YES;
        NSLog(@"重启播放线程------");
        [self stopFFmpegAudioStream];
        [_aPlayer stop:YES];
        [self stopPlayAudio];
        
        [self PlayAudioAll:NO];
        isPlayBlock = NO;
    }
}


- (void)stopFFmpegAudioStream
{
    isStop = YES;
}

/** 销毁视频播放流*/
- (void)destroyFFmpegAudioStream
{
    avformat_network_deinit();
    //清除内存缓存
//    [[SDWebImageManager  sharedManager].imageCache  clearMemory];
}

//---------------------------------


//加载xib
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      player = [[MPMoviePlayerController alloc] init];
//        [player setMovieSourceType:MPMovieSourceTypeStreaming];
//        [player setControlStyle:MPMovieControlStyleNone];
    }
    return self;
}


//- (void)dealloc {
////    [player stop];    放弃使用自带player系统的方法
//    [self.delegate PlayViewStopBtnDidClicked:self];
//    
//#warning 注释---去掉release
////    [player release];  // 放弃使用系统player的方法
////    [siteLink release];
////   
////    [siteLogo release];
//    [self stopPlayAudio];
//    
//    
//    [super dealloc];
//}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

//    self.navigationController.navigationBar.t;
    _aPlayer.delegate = self;
    self.currentPlayingTitle.text = [NSString stringWithFormat:@"正在播放:%@",self.currentPlayingVc.title];
    self.currentPlayingTitle.numberOfLines = 0;
    self.currentPlayingTitle.textColor = [UIColor whiteColor];
//1
    //添加动画
    [self setupAnimation];
//    //隐藏导航栏
//    [self.navigationController setNavigationBarHidden:YES];
//    //隐藏tabbar 工具栏
//    self.tabBarController.hidesBottomBarWhenPushed = YES;
    
    [self makeVisibleSiteName];

}

//
//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//}

-(void)viewWillLayoutSubviews
{
    self.lable.frame = CGRectMake(0, 95, 230, 35);
}

- (void)makeVisibleSiteName
{
    UILabel *lable = [[UILabel alloc] init];
    
    lable.text = self.title;
    lable.font = [UIFont systemFontOfSize:16];
    lable.textColor = [UIColor purpleColor];
    lable.textAlignment = NSTextAlignmentCenter;
    [self.logoImageView addSubview:lable];
}


-(void)setupAnimation
{
    //---------------------animation------------------------
    // 背景梦幻星空
    do {
        LYBgImageView *animationView = [[LYBgImageView alloc] initWithFrame:CGRectMake(0, 0, KAnimationWandH, KAnimationWandH)];
        [self.view addSubview:animationView];
    } while (0);
    
    // 第一条移动星星闪烁动画
    do {
        CGMutablePathRef path = CGPathCreateMutable();
        
        CGPathMoveToPoint(path, NULL, 0, 0);
        CGPathAddCurveToPoint(path, NULL, 50.0, 100.0, 50.0, 170.0, 50.0, KAnimationWandH -20);
        CGPathAddCurveToPoint(path, NULL, 50.0, 190, 250.0, 100, 120.0, 160.0);
        
        LYMovePathView *animationView = [[LYMovePathView alloc] initWithFrame:CGRectMake(0, 0, KAnimationWandH, KAnimationWandH) movePath:path];
        [self.view addSubview:animationView];
    } while (0);
    
    // 第二条移动星星闪烁动画
    do {
        CGMutablePathRef path = CGPathCreateMutable();
        
        CGPathMoveToPoint(path, NULL, KAnimationWandH - 20, KAnimationWandH -60);
        CGPathAddCurveToPoint(path, NULL, KAnimationWandH - 50.0, KAnimationWandH - 60.0, KAnimationWandH - 50.0, KAnimationWandH - 120.0, KAnimationWandH - 50.0, KAnimationWandH - 200.0);
        CGPathAddCurveToPoint(path, NULL, KAnimationWandH - 50.0, KAnimationWandH - 200.0, KAnimationWandH - 150.0, KAnimationWandH - 185.0, 110.0, 120.0);
        
        LYMovePathView *animationView = [[LYMovePathView alloc] initWithFrame:CGRectMake(0, 0, KAnimationWandH, KAnimationWandH) movePath:path];
        [self.view addSubview:animationView];
    } while (0);
    
    // 祝贺花筒，彩色炮竹
    do {
        LYFireworksView *animationView = [[LYFireworksView alloc] initWithFrame:CGRectMake(0, 0, KAnimationWandH, KAnimationWandH)];
        [self.view addSubview:animationView];
    } while (0);
    
    //--------------------------animation------------------
    
}


//刷新喜爱按钮的最新状态
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (siteLink && self.title) {
        NSDictionary *site = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:self.title, siteLink, nil] forKeys:[NSArray arrayWithObjects:@"siteName", @"siteLink", nil]];
        BOOL inFavorites = [self isSite:site storedInPlistNamed:kFavoritesPlistName];
        [favoriteButton setSelected:inFavorites];
//        [site release];       
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // e.g. self.myOutlet = nil;
}

- (void)viewWillDisappear:(BOOL)animated {
//    [player pause];//放弃使用系统player
//    [playButton setSelected:YES];
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - 代理方法

- (void)audioPlayerDidStop:(AudioPlayer *)audioPlayer{
//    audioPlayer.delegate = self;
    [self stopPlayAudio];
}

#pragma mark - buttons methods
- (IBAction)startBtnClicked {


    
    if ([self.delegate respondsToSelector:@selector(PlayViewStratBtnDidClicked:)]) {
        
        [self.delegate PlayViewStratBtnDidClicked:self];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{   //----  1
        NSTimer *timer;
        [MBProgressHUD showMessage:@"正在加载中...." toView:self.view ];
        timer = [NSTimer scheduledTimerWithTimeInterval:8.0 target:self selector:@selector(doTimerall) userInfo:nil repeats:NO];
    });
    

 
//    [self.view addSubview:self.waitView];
    
    if (siteLink && ![self.title isEqualToString:@""]) {
        //        //加载网址
        //        [player setContentURL:[NSURL URLWithString:siteLink]];  放弃使用系统player
        //---------------------------------
        /** 通过地址播放视屏*/
        //channelAddr = @"mms://218.28.9.99/Hxinwen";
// 北京电台       mms://alive.bjradio.com.cn/fm1006
        

        
        NSLog(@"电台名称   == %@\n",  self.title );
       channelAddr = siteLink;
        NSLog(@" mms 网址  channelAddr== ||%@||\n", channelAddr  );
        

        
        /** 播放视频 */
        [self PlayAudioAll:YES];    //----  2
        
        //加载电台logo
//        [logoImageView setImage:siteLogo];
        NSLog(@"  siteLogo == %@ \n",siteLogo   );
        
        
        //---------------------------------

    }

    
}

-(void)doTimer1
{
    [MBProgressHUD hideHUD];
}

//停止播放流媒体视屏
- (IBAction)stopBtnClicked {
#warning 不符合内存管理
//    [self retain];
#warning 注释---暂停播放
    [self.currentPlayingVc stopPlayAudio];
    [MBProgressHUD showSuccess:@"暂停播放" toView:nil];
    NSTimer *timer;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.65 target:self selector:@selector(doTimer1) userInfo:nil repeats:NO];


    [self stopPlayAudio];
 
    isStop = YES;
    NSLog(@"   stopBtnClicked== \n"   );
}

//ok-------
//Called when user taps on favoriteButton.
//喜爱的按钮点击就会调用
- (IBAction)addOrRemoveFromFavoritesButtonPressed {

#warning 注释---成功收藏蒙版
    if (favoriteButton.selected==YES) {
        [MBProgressHUD showSuccess:@"取消收藏" toView:nil];
    }else
    {
        [MBProgressHUD showSuccess:@"成功收藏" toView:nil];

    }
    NSTimer *timer;  //后面有doTimer1
    timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(doTimer1) userInfo:nil repeats:NO];
    [favoriteButton setSelected:![favoriteButton isSelected]];

    
    NSDictionary *site = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:self.title, siteLink, nil] forKeys:[NSArray arrayWithObjects:@"siteName", @"siteLink", nil]];
    [self performSelector:@selector(addOrRemoveSite: inPlistNamed:) withObject:site withObject:kFavoritesPlistName];
//    [site release];
}

//----ok


//放弃使用系统player
////播放按钮点击
//- (IBAction)playOrPauseButtonPressed {
//    [playButton setSelected:![playButton isSelected]];
//    if ([playButton isSelected]) {
//        //停止播放
//        [player pause];
//    }
//    else {
//        //开始播放
//        [player play];
//    }
//}

#pragma mark - private and methods intended for internal use

//plist中是否存储电台使用给定的名字
//Checks if given site is stored in given plist with given name.
- (BOOL)isSite:(NSDictionary*)site storedInPlistNamed:(NSString*)plistName {
//    [site retain];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSMutableString *filePath = [NSMutableString stringWithString:[paths objectAtIndex:0]];
    [filePath appendString:@"/"];
    [filePath appendString:plistName];
    [filePath appendString:@".plist"];
    
    NSMutableDictionary *favorites;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        favorites = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    }
    else {
        return NO;
    }
    
    BOOL inFavorties = NO;
    for (int i = 0; i < [favorites count]; i++) {
        NSDictionary *currentSite = [favorites objectForKey:[NSString stringWithFormat:@"Site%d", i]];
        if ([currentSite isEqualToDictionary:site]) {
            inFavorties = YES;
            break;
        }
    }
//    [site release];
    return inFavorties;
}

//Removes given site from plist with given name, or adds the site if it is not in plist.

//添加或删除电台
- (void)addOrRemoveSite:(NSDictionary*)site inPlistNamed:(NSString*)plistName {
    
//    [site retain];
    
    BOOL inFavorites = [self isSite:site storedInPlistNamed:plistName];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSMutableString *filePath = [NSMutableString stringWithString:[paths objectAtIndex:0]];
    [filePath appendString:@"/"];
    [filePath appendString:plistName];
    [filePath appendString:@".plist"];
    
    NSMutableDictionary *favorites = [[NSMutableDictionary alloc] init];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        [favorites setDictionary:[NSMutableDictionary dictionaryWithContentsOfFile:filePath]];
    }
    
    //If site is in favorites remove it and rearrange favorites
    if (inFavorites) {
        for (int i = 0; i < [favorites count]; i++) {
            NSDictionary *currentSite = [favorites objectForKey:[NSString stringWithFormat:@"Site%d", i]];
            //When site is found it is overwritten by decrementing index of other sites that come after it.
            if ([currentSite isEqualToDictionary:site]) {
                int j = i;
                for (; j < [favorites count]-1; j++) {
                    [favorites setValue:[favorites objectForKey:[NSString stringWithFormat:@"Site%d", j+1]] forKey:[NSString stringWithFormat:@"Site%d", j]];
                }
                [favorites removeObjectForKey:[NSString stringWithFormat:@"Site%d", j]];
                break;
            }
        }
    }
    //If site is not in favorites add it as last.
    else {
        [favorites setValue:site forKey:[NSString stringWithFormat:@"Site%d", [favorites count]]];
    }
    [favorites writeToFile:filePath atomically:YES];
//    [favorites release];
//    [site release];
}


//放弃使用系统player   去掉蒙版  去掉通知

////缓冲完毕,隐藏蒙板,可以点击播放按钮
- (void)playerLoadStateDidChange {
    //视屏缓冲到可以播放
    if (([player loadState] == MPMovieLoadStatePlaythroughOK)||[player loadState] == MPMovieLoadStatePlayable) {
//        [HUD hide:YES];       
        [playButton setEnabled:YES];
    }
}
//
////
//- (void)playerPlaybackStateDidChange {
//    //正在播放
//    if ([player playbackState] == MPMoviePlaybackStatePlaying) {
//        [HUD hide:YES];
//        [playButton setEnabled:YES];
//        [playButton setSelected:NO];
//    }
//    //播放中断
//    else if ([player playbackState] == MPMoviePlaybackStateInterrupted) {
//        [playButton setEnabled:NO];
//        [HUD show:YES];
//    }
//}

//- (void)dealloc {
//    [_currentPlayingTitle release];
//    [super dealloc];
//}
@end
