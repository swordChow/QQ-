//
//  ZLAudioTool.m
//  ZLQQMusic
//
//  Created by sword on 16/10/22.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

#import "ZLAudioTool.h"
#import <AVFoundation/AVFoundation.h>

@implementation ZLAudioTool
static NSMutableDictionary * _players;
+(void)initialize {
    _players = [NSMutableDictionary dictionary];
    
}
+(AVAudioPlayer *)playMusicWithFileName:(NSString *)fileName {
    AVAudioPlayer *player = nil;
    player = _players[fileName];
    if (player == nil ) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
        if (url == nil) {
            return nil;
        }
        player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
        
        [player prepareToPlay];

        [_players setObject:player forKey:fileName];
    }
    [player play];
    
    return player;
}

+(void)pausePlayMusicWithFileName:(NSString *)fileName {
    
    AVAudioPlayer * player = _players[fileName];
    if (player) {
         [player stop];
    }
   
}

+(void)stopPlayMusicWithFileName:(NSString *)fileName {
    AVAudioPlayer *player = _players[fileName];
    if (player) {
        [player stop];
        [_players removeObjectForKey:fileName];
        player = nil;
    }
    
}


@end
