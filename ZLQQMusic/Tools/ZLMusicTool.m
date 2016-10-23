//
//  ZLMusicTool.m
//  ZLQQMusic
//
//  Created by sword on 16/10/22.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

#import "ZLMusicTool.h"
#import "ZLMusicModel.h"
#import <MJExtension.h>



@implementation ZLMusicTool

static NSArray * _musics;
static ZLMusicModel * _playMusic;

+(void)initialize {
    if (_musics == nil) {
        _musics = [ZLMusicModel mj_objectArrayWithFilename:@"Musics.plist"];
    }
    if (_playMusic == nil) {
        _playMusic = _musics[3];
    }
}

+(NSArray *)Musics {
    
    return  _musics;
}

+(void)setDefaultPlayingMusic:(ZLMusicModel *)playingMusic {
    
    _playMusic = playingMusic;
}
+(ZLMusicModel *)playingMusic {
    
    return _playMusic;
}
//返回上一首
+(ZLMusicModel *)playingPreviousMusic {
    NSInteger index = [_musics indexOfObject:_playMusic];
    if (index == 0 ) {
        index = _musics.count - 1;
    }
    else{
        index = index - 1;
    }
    ZLMusicModel *previousMusic = _musics[index];
    return previousMusic;
}

//播放下一首
+(ZLMusicModel*)palyingNextMusic {
    NSInteger index = [_musics indexOfObject:_playMusic];
    if (index == _musics.count - 1) {
        index = 0;
    } else {
        index = index + 1;
    }
    ZLMusicModel *nextMusic = _musics[index];
    return nextMusic;
}




@end
