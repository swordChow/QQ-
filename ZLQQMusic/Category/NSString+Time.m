//
//  NSString+Time.m
//  ZLQQMusic
//
//  Created by sword on 16/10/22.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

#import "NSString+Time.h"

@implementation NSString (Time)

+(NSString *)stringWithTime:(NSTimeInterval)time {
    NSInteger min = time/60;
    NSInteger sec = (int) round(time) % 60;
    return [NSString stringWithFormat:@"%02ld:%02ld",min,sec
            ];
}

@end
