//
//  CALayer+PauseAnimate.m
//  ZLQQMusic
//
//  Created by sword on 16/10/22.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

#import "CALayer+PauseAnimate.h"

@implementation CALayer (PauseAnimate)

-(void)pauseAnimate {
    
    CFTimeInterval pauseTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    self.speed = 0.0;
    
    self.timeOffset = pauseTime;
    
}
-(void)resumeAnimate {
    
    CFTimeInterval pauseTime = [self timeOffset];
    self.speed = 1.0;
    self.beginTime = 0.0;
    self.timeOffset = 0.0;
    CFTimeInterval timeSincePause = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pauseTime;
    self.beginTime = timeSincePause;
}

@end
