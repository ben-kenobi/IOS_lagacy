//
//  PlayerViewController.h
//  Radio
//
//  Created by Planet1107 on 1/28/12.
//


//---------------------------------
#import <UIKit/UIKit.h>
#include "libavformat/avformat.h"
#include "libswscale/swscale.h"
#import "AudioPacketQueue.h"
#import "AudioPlayer.h"
#import "AudioUtilities.h"
//---------------------------------




//#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
//#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
@class PlayerViewController;
@protocol PlayViewControllerDelegate <NSObject>

- (void)PlayViewStratBtnDidClicked:(PlayerViewController *)PlayView ;
- (void)PlayViewStopBtnDidClicked:(PlayerViewController *)PlayView ;

@end

@interface PlayerViewController : UIViewController<AudioPlayerDelegate> {
    NSString *siteLink;
    UIImage *siteLogo;
    MPMoviePlayerController *player;

    
//---------------------------------
/**   电台网址 */
NSString *channelAddr;
//---------------------------------
    
}


@property (retain, nonatomic) IBOutlet UILabel *currentPlayingTitle;

//  显示标题
@property(nonatomic,retain) UILabel *lable;
/**  网址链接  */
@property(nonatomic, retain) NSString *siteLink;
/** 网址图片   */
@property(nonatomic, retain) UIImage *siteLogo;
/** 播放图片   */
@property(nonatomic, retain) IBOutlet UIImageView *logoImageView;
/** 喜爱按钮   */
@property(nonatomic, retain) IBOutlet UIButton *favoriteButton;
/**  播放按钮  */
@property(nonatomic, retain) IBOutlet UIButton *playButton;
/**  序号  */
@property (nonatomic,assign) int identifier;
/**  代理  */
@property(nonatomic, retain) id<PlayViewControllerDelegate> delegate;
/**  播放器  */
@property(nonatomic, retain) AudioPlayer *aPlayer;
/**  当前正在播放记录  */
@property(nonatomic, retain) PlayerViewController *currentPlayingVc;
//放弃使用系统player
//- (IBAction)playOrPauseButtonPressed;

- (IBAction)addOrRemoveFromFavoritesButtonPressed;
- (BOOL)isSite:(NSDictionary*)site storedInPlistNamed:(NSString*)plistName;
- (void)stopPlayAudio;
- (IBAction)startBtnClicked;


@property (retain, nonatomic) MBProgressHUD *waitView;
/**   播放按钮 */
//- (IBAction)touchPlay:(id)sender;
/**   停止按钮 */
//- (IBAction)touchStop:(id)sender;
//---------------------------------


@end
