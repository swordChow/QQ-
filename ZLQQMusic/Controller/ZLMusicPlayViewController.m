//
//  ZLMusicPlayViewController.m
//  ZLQQMusic
//
//  Created by sword on 16/10/22.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

#import "ZLMusicPlayViewController.h"
#import "ZLAudioTool.h"
#import "ZLMusicTool.h"
#import "CALayer+PauseAnimate.h"
#import "NSString+Time.h"
#import "ZLLrcLabel.h"
#import "ZLLrcView.h"
#import "ZLMusicModel.h"
#import <AVFoundation/AVFoundation.h>

@interface ZLMusicPlayViewController ()<UIScrollViewDelegate>
/*歌曲名*/
@property (weak, nonatomic) IBOutlet UILabel *songLabel;
/*歌手名*/
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;
/*当前播放时间*/
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
/*总时间*/
@property (weak, nonatomic) IBOutlet UILabel *allTimeLabel;
/*背景图片*/
@property (weak, nonatomic) IBOutlet UIImageView *albumImageView;
/*歌手图片*/
@property (weak, nonatomic) IBOutlet UIImageView *singerImageView;
/*歌词*/
@property (weak, nonatomic) IBOutlet ZLLrcLabel *lrcLabel;


/*scrollView*/
@property (weak, nonatomic) IBOutlet ZLLrcView *lrcScrollView;
/*进度条*/
@property (weak, nonatomic) IBOutlet UISlider *playProgressSlider;

/*播放按钮*/
@property (weak, nonatomic) IBOutlet UIButton *playButton;

/*当前播放器*/
@property(nonatomic,strong) AVAudioPlayer *currentPlayer;

/*进度条时间*/
@property(nonatomic, strong)NSTimer *progressTimer;

/*歌词的定时器*/
@property(nonatomic, strong)CADisplayLink * lrcTimer;






@end

@implementation ZLMusicPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置滑条图片
    [self.playProgressSlider setThumbImage:[UIImage imageNamed:@"player_slider_playback_thumb"] forState:UIControlStateNormal];
    //歌词属性
    NSLog(@"%@",[self.lrcScrollView class]);
    self.lrcScrollView.lrcLabel = self.lrcLabel;
    //scrollView contentsize
    self.lrcScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 2, 0);
    [self startPlayingMusic];
    self.lrcScrollView.showsHorizontalScrollIndicator = NO;
    self.lrcScrollView.pagingEnabled = YES;
    
    self.lrcScrollView.delegate = self;
}


#pragma mark 播放音乐
-(void)startPlayingMusic {
    ZLMusicModel * currentMusic = [ZLMusicTool playingMusic];
    //界面信息
    self.albumImageView.image = [UIImage imageNamed:currentMusic.icon];
    self.singerImageView.image = [UIImage imageNamed:currentMusic.icon];
    self.songLabel.text = currentMusic.name;
    self.singerLabel.text = currentMusic.singer;
    
    //获取播放器播放音乐
    AVAudioPlayer *currentPlayer = [ZLAudioTool playMusicWithFileName:currentMusic.filename];
    self.currentTimeLabel.text = [NSString stringWithTime:currentPlayer.currentTime];
    self.allTimeLabel.text = [NSString stringWithTime:currentPlayer.duration];
    self.currentPlayer = currentPlayer;
    
    self.playButton.selected = currentPlayer.isPlaying;
    //歌词名字
    self.lrcScrollView.lrcName = currentMusic.lrcname;
    //歌曲时间
    self.lrcScrollView.durationTime = currentPlayer.duration;
    
    //旋转动画
    [self addRotateAnimation];
    
    //播放进度条
    [self removeProgressTimer];
    
    [self addProgressTimer];
    
    [self removeLrcTimer];
    
    [self addLrcTimer];
    
    
    
}

#pragma mark -播放时间进度条
-(void)removeProgressTimer {
    [self.progressTimer invalidate];
    self.progressTimer = nil;
    
}
-(void)addProgressTimer {
    [self updateProgressInfo];
    self.progressTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateProgressInfo) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
    
}



-(void)updateProgressInfo {
    self.currentTimeLabel.text =[ NSString stringWithTime:self.currentPlayer.currentTime];
    self.playProgressSlider.value = self.currentPlayer.currentTime / self.currentPlayer.duration;
    
}

#pragma mark -歌词定时器
-(void)addLrcTimer{
    self.lrcTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateLrcInfo)];
    [self.lrcTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
}
-(void)removeLrcTimer {
    [self.lrcTimer invalidate];
    self.lrcTimer = nil;
    
}
-(void)updateLrcInfo {
    
    self.lrcScrollView.currentTime = self.currentPlayer.currentTime;
    
}
#pragma mark - 添加动画
-(void)addRotateAnimation {
    CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotate.fromValue = @(0);
    rotate.toValue = @(M_PI * 2);
    rotate.repeatCount = NSIntegerMax;
    rotate.duration = 36;
    [self.singerImageView.layer addAnimation:rotate forKey:nil];
    
}
#pragma mark - 添加圆角
-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.singerImageView.layer.cornerRadius = self.singerImageView.bounds.size.width * 0.5;
    self.singerImageView.layer.masksToBounds = YES;
    self.singerImageView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.singerImageView.layer.borderWidth = 5;
    
}

#pragma mark - 进度条操作

- (IBAction)startTouchSlider:(id)sender {
    
    [self removeProgressTimer];
}
- (IBAction)endTouchSlider:(id)sender {
    
    self.currentPlayer.currentTime = self.playProgressSlider.value * self.currentPlayer.duration;
    [self addProgressTimer];
}

/**/
- (IBAction)sliderValueChanged:(id)sender {
    NSString * string = [NSString stringWithTime:self.playProgressSlider.value * self.currentPlayer.duration];
    self.currentTimeLabel.text = string;
}
/*手势事件*/
- (IBAction)sliderTap:(UITapGestureRecognizer *)sender {
    
    CGPoint point = [sender locationInView:sender.view];
    
    CGFloat num = point.x / self.playProgressSlider.bounds.size.width;
    
    self.currentPlayer.currentTime = num * self.currentPlayer.duration;
    
    [self updateProgressInfo];
}


#pragma mark - 按钮点击事件
/*播放按钮*/
- (IBAction)playButtonClicked:(id)sender {
    UIButton *btn = sender;
    btn.selected = !btn.selected;
    if ([self.currentPlayer isPlaying]) {
        
        
        [self.currentPlayer pause];
        
        [self removeProgressTimer];
        
        [self.singerImageView.layer pauseAnimate];

        
    }else {
        
        [self.currentPlayer play];
        
        [self addProgressTimer];
        
        [self.singerImageView.layer resumeAnimate];
    }
    
}
/*上一首*/
- (IBAction)playPreviousSong:(id)sender {
    
    ZLMusicModel *previousMusic = [ZLMusicTool playingPreviousMusic];
    
    [self playMusicWithMusic:previousMusic];
}

/*下一首*/

- (IBAction)playNextSong:(id)sender {
    
    ZLMusicModel *nextMusic = [ZLMusicTool palyingNextMusic];
    
    [self playMusicWithMusic:nextMusic];
    
}

-(void)playMusicWithMusic:(ZLMusicModel*)music {
    
    //获取当前播放的音乐并停止
    ZLMusicModel *playingMusic = [ZLMusicTool playingMusic];
    
    [ZLAudioTool stopPlayMusicWithFileName:playingMusic.filename];
    
    //设置上一首或下一首播放
    [ZLMusicTool setDefaultPlayingMusic:music];
    
    //更新界面
    [self startPlayingMusic];
    
}

#pragma mark - scrollView代理事件

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGPoint offsetPoint = scrollView.contentOffset;
    
    CGFloat alpha = 1 - offsetPoint.x /self.view.frame.size.width;
    
    self.singerImageView.alpha = alpha;
    
    self.lrcLabel.alpha = alpha;
}

#pragma mark - 处理状态栏

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}



@end
