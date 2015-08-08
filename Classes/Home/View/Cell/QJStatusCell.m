//
//  QJStatusCell.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/5.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJStatusCell.h"
#import "QJStatusDetailView.h"
#import "QJStatusToolBar.h"
#import "QJStatusFrame.h"

@interface QJStatusCell ()

@property (nonatomic, weak) QJStatusDetailView *detailView;
@property (nonatomic, weak) QJStatusToolBar *toolBar;

@end

@implementation QJStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    QJStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[QJStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 设置背景颜色
        self.backgroundColor = [UIColor clearColor];
        
        // 添加微博详情视图
        QJStatusDetailView *detailView = [[QJStatusDetailView alloc] init];
        [self.contentView addSubview:detailView];
        self.detailView = detailView;
        
        // 添加微博工具条
        QJStatusToolBar *toolBar = [[QJStatusToolBar alloc] init];
        [self.contentView addSubview:toolBar];
        self.toolBar = toolBar;
    }
    return self;
}

-(void)setStatusFrame:(QJStatusFrame *)statusFrame {
    _statusFrame = statusFrame;
    
    // 设置微博详情视图Frame
    self.detailView.detailFrame = statusFrame.detailFrame;
    
    // 设置微博tabar工具栏
    self.toolBar.frame = statusFrame.toolBarFrame;
    self.toolBar.status = statusFrame.status;
}

@end
