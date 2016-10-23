//
//  ZLLrcLine.h
//  ZLQQMusic
//
//  Created by sword on 16/10/22.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLLrcLine : NSObject
@property(nonatomic, copy)NSString * text;
@property(nonatomic, assign)NSTimeInterval time;

-(instancetype)initWithLrcLineString:(NSString *)lrcLineString;
+(instancetype)initWithLrcLineString:(NSString*)lrcLineString;

@end
