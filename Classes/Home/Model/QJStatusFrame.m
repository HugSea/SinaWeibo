//
//  QJStatusFrame.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/6.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJStatusFrame.h"
#import "QJStatusDetailFrame.h"
#import "QJStatus.h"

@implementation QJStatusFrame

-(void)setStatus:(QJStatus *)status {
    
    _status = status;
    
    // 计算详情微博Frame
    [self setupDetailFrame];
    
    // 计算微博工具栏Frame
    [self setupToolBarFrame];
    
    // 计算Cell高度
    self.cellHeight = CGRectGetMaxY(self.toolBarFrame);
}

/**
 *  计算详情微博Frame
 */
- (void)setupDetailFrame {
    self.detailFrame = [[QJStatusDetailFrame alloc] init];
    self.detailFrame.status = self.status;
}

/**
 *  计算微博工具栏Frame
 */
- (void)setupToolBarFrame {
    CGFloat toolbarX = 0;
    CGFloat toolbarY = CGRectGetMaxY(self.detailFrame.frame);
    CGFloat toolbarW = QJScreenW;
    CGFloat toolbarH = 35;
    self.toolBarFrame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
}

@end
