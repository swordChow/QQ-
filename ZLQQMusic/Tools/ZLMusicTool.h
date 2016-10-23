//
//  ZLMusicTool.h
//  ZLQQMusic
//
//  Created by sword on 16/10/22.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZLMusicModel;
@interface ZLMusicTool : NSObject
+(NSArray*)Musics;

//获取正在播放的音乐
+(ZLMusicModel*) playingMusic;

//设置默认播放的音乐
+(void)setDefaultPlayingMusic:(ZLMusicModel*)playingMusic;

//播放上一首
+(ZLMusicModel*)playingPreviousMusic;

//播放下一首
+(ZLMusicModel*)palyingNextMusic;

@end
