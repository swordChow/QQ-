//
//  ZLLrcTableViewCell.m
//  ZLQQMusic
//
//  Created by sword on 16/10/22.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

#import "ZLLrcTableViewCell.h"
#import "ZLLrcLabel.h"

@implementation ZLLrcTableViewCell

+(ZLLrcTableViewCell *)initLrcTableViewCellWithTableView:(UITableView *)tableView {
    static NSString * ID = @"Cell";
    ZLLrcTableViewCell * lrcCell = [[ZLLrcTableViewCell alloc]init];
    if (!lrcCell) {
        lrcCell = [[ZLLrcTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return lrcCell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        ZLLrcLabel *lrcLabel = [[ZLLrcLabel alloc]init];
        lrcLabel.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.contentView.frame.size.height);
        lrcLabel.textColor = [UIColor whiteColor];
        lrcLabel.textAlignment = NSTextAlignmentCenter;
        lrcLabel.font = [UIFont systemFontOfSize:14];
        self.lrcLabel = lrcLabel;
        [self.contentView addSubview:lrcLabel];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

@end
