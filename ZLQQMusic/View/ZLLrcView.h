//
//  ZLLrcView.h
//  ZLQQMusic
//
//  Created by sword on 16/10/22.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZLLrcLabel;
@interface ZLLrcView : UIScrollView
/*歌词文件名*/
@property (nonatomic,copy) NSString * lrcName;
@property(nonatomic, weak) ZLLrcLabel* lrcLabel;
/*当前播放的时间*/
@property (nonatomic, assign) NSTimeInterval currentTime ;
/*歌曲的总时间*/
@property (nonatomic, assign) NSTimeInterval durationTime ;



@end
