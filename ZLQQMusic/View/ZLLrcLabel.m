//
//  ZLLrcLabel.m
//  ZLQQMusic
//
//  Created by sword on 16/10/22.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

#import "ZLLrcLabel.h"

@implementation ZLLrcLabel

-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    
    [self setNeedsDisplay];
    
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [[UIColor greenColor] set];
    
    CGRect fillRect = CGRectMake(0, 0, self.bounds.size.width * self.progress, self.bounds.size.height);
    UIRectFillUsingBlendMode(fillRect, kCGBlendModeSourceIn);
    
}


@end
