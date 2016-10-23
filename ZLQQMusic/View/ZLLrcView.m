//
//  ZLLrcView.m
//  ZLQQMusic
//
//  Created by sword on 16/10/22.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

#import "ZLLrcView.h"
#import "ZLLrcLabel.h"
#import "ZLLrcLine.h"
#import "ZLLrcTool.h"
#import "ZLLrcTableViewCell.h"
@interface ZLLrcView ()<UITableViewDataSource>
@property (nonatomic,weak) UITableView * tableView;
@property (nonatomic,copy) NSArray * lrcList;
@property (nonatomic, assign) NSInteger currentIndex ;

@end
@implementation ZLLrcView
-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupTableView];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupTableView];
    }
    return self;
}

#pragma mark 设置tableView
-(void)setupTableView {
    UITableView *tableView = [[UITableView alloc]init];
    [self addSubview:tableView];
    self.tableView = tableView;
    tableView.dataSource = self;
    
}
-(void)layoutSubviews {
    [super layoutSubviews];
    self.tableView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 100 - 150);
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.rowHeight = 40;
    self.tableView.contentInset = UIEdgeInsetsMake(self.tableView.bounds.size.height * 0.5, 0, self.tableView.bounds.size.height * 0.5, 0);
    
}
#pragma mark tableViewDataSource 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  self.lrcList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZLLrcTableViewCell *cell = [ZLLrcTableViewCell initLrcTableViewCellWithTableView:tableView];
    if (self.currentIndex == indexPath.row) {
        self.lrcLabel.font = [UIFont systemFontOfSize:20];
    }
    else {
        self.lrcLabel.font = [UIFont systemFontOfSize:14];
        self.lrcLabel.progress = 0;
    }
    //当前播放的歌曲的歌词模型
    ZLLrcLine *lrcLine = self.lrcList[indexPath.row];
    cell.lrcLabel.text = lrcLine.text;
    return cell;
}
-(void)setLrcName:(NSString *)lrcName {
    
    self.currentIndex = 0;
    _lrcName = lrcName;
    //解析歌词
    self.lrcList = [ZLLrcTool lrcToolWithLrcName:lrcName];
    ZLLrcLine *lrcLine = self.lrcList[0];
    self.lrcLabel.text = lrcLine.text;
    
    [self.tableView reloadData];
}

-(void)setCurrentTime:(NSTimeInterval)currentTime {
    
    _currentTime = currentTime;
    
    NSInteger count = self.lrcList.count;
    for (int i = 0; i< count; i++) {
       //当前歌词
        ZLLrcLine *currentLrcLine = self.lrcList[i];
        
        NSInteger nextIndex = i + 1;
        
        ZLLrcLine *nextLrcLine = nil ;
        if (nextIndex < count ) {
            nextLrcLine = self.lrcList[nextIndex];
        }
        
        if (self.currentIndex != i && currentTime > currentLrcLine.time && currentTime < nextLrcLine.time) {
            //设置主页上的歌词
            self.lrcLabel.text = currentLrcLine.text;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            //将当前播放的歌词放在中间
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
            
            //记录上一句位置，当移动到下一句，上一句和当前句子都需要更新
            NSIndexPath *previousIndexPath = [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
            
            [self.tableView reloadRowsAtIndexPaths:@[indexPath, previousIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            //下一次进来时，当前歌词下标就是i；
            self.currentIndex = i ;
            
        }
        if (self.currentIndex == i) {
            //获取播放进度
            CGFloat progress = (currentTime - currentLrcLine.time)/ (nextLrcLine.time - currentLrcLine.time);
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            ZLLrcTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            cell.lrcLabel.progress = progress;
            
            self.lrcLabel.progress = progress;
        
        }
        
        
    }
    
    
    
}





@end
