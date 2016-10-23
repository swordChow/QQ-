//
//  ZLLrcTool.m
//  ZLQQMusic
//
//  Created by sword on 16/10/22.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

#import "ZLLrcTool.h"
#import "ZLLrcLine.h"

@implementation ZLLrcTool

+(NSArray *)lrcToolWithLrcName:(NSString *)lrcName {
    //歌词路径
    NSString *lrcFilePath = [[NSBundle mainBundle] pathForResource:lrcName ofType:nil];
    //歌词
    NSString *lrcString = [NSString stringWithContentsOfFile:lrcFilePath encoding:NSUTF8StringEncoding error:nil];
    //歌词转为数组
    NSArray *lrcArray = [lrcString componentsSeparatedByString:@"\n"];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSString *lrcString in lrcArray) {
        if ([lrcString hasPrefix:@"[ti:"]||[lrcString hasPrefix:@"[ar:"] ||[lrcString hasPrefix:@"[al:"] ||![lrcString hasPrefix:@"["] ) {
            continue;
        }
        ZLLrcLine *lrcLine = [ZLLrcLine initWithLrcLineString:lrcString];
        [tempArray addObject:lrcLine];
        
    }
    return tempArray;
    
}

@end
