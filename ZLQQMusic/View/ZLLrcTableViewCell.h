//
//  ZLLrcTableViewCell.h
//  ZLQQMusic
//
//  Created by sword on 16/10/22.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZLLrcLabel;
@interface ZLLrcTableViewCell : UITableViewCell

@property(nonatomic, weak)  ZLLrcLabel* lrcLabel;

+(ZLLrcTableViewCell*)initLrcTableViewCellWithTableView:(UITableView*)tableView;

@end
