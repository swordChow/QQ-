//
//  ZLAudioTool.h
//  ZLQQMusic
//
//  Created by sword on 16/10/22.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface ZLAudioTool : NSObject
+(AVAudioPlayer *)playMusicWithFileName :(NSString*)fileName;

+(void)pausePlayMusicWithFileName:(NSString*)fileName;

+(void)stopPlayMusicWithFileName:(NSString*)fileName;

@end
