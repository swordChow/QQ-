//
//  ZLLrcLine.m
//  ZLQQMusic
//
//  Created by sword on 16/10/22.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

#import "ZLLrcLine.h"

@implementation ZLLrcLine

-(instancetype)initWithLrcLineString:(NSString *)lrcLineString {
    if (self = [super init]) {
        NSArray *lrcArray = [lrcLineString componentsSeparatedByString:@"]"];
        _text = lrcArray[1];
        _time = [self timeWithString: [lrcArray[0] substringFromIndex:1]];
    }
    return self;
}
//01:23.08
-(NSTimeInterval)timeWithString :(NSString*)timeString {
    NSInteger min = [[timeString componentsSeparatedByString:@":"][0] integerValue];
    NSInteger sec = [[timeString substringWithRange:NSMakeRange(3, 2)] integerValue];
    NSInteger hs = [[timeString componentsSeparatedByString:@"."][1] integerValue ];
    return min * 60 + sec + hs * 0.01;
    
}

+(instancetype)initWithLrcLineString:(NSString *)lrcLineString {
    
    return [[self alloc]initWithLrcLineString:lrcLineString];
}

@end
