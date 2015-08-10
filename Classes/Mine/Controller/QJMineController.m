//
//  QJMineController.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/7/31.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJMineController.h"
#import "QJSearchBar.h"
#import "QJCommonGroup.h"
#import "QJCommonItem.h"
#import "QJCommonCell.h"
#import "QJArrowItem.h"
#import "QJSwitchItem.h"
#import "QJLabelItem.h"


@interface QJMineController ()

@end

@implementation QJMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化模型
    [self setupGroups];
    
}

- (void)setupGroups {
    [self setupGroup0];
    [self setupGroup1];
}

- (void)setupGroup0 {
    // 创建组
    QJCommonGroup *group = [QJCommonGroup group];
    [self.groups addObject:group];
    
    // 设置组的所有行数据
    QJArrowItem *newFriendsStatus = [QJArrowItem itemWithTitle:@"新的好友" icon:@"new_friend"];
    newFriendsStatus.destVcClass = [QJMineController class];
    
    group.items = @[newFriendsStatus];
}

- (void)setupGroup1 {
    // 1.创建组
    QJCommonGroup *group = [QJCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    QJArrowItem *album = [QJArrowItem itemWithTitle:@"我的相册" icon:@"album"];
    album.operation = ^() {
        NSLog(@"------我的相册------");
    };
    QJArrowItem *collect = [QJArrowItem itemWithTitle:@"我的收藏" icon:@"collect"];
    QJArrowItem *like = [QJArrowItem itemWithTitle:@"赞" icon:@"like"];
    
    group.items = @[album, collect, like];
}

@end
