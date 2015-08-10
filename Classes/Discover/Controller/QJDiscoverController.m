//
//  QJDiscoverController.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/7/31.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJDiscoverController.h"
#import "QJSearchBar.h"
#import "QJCommonGroup.h"
#import "QJCommonItem.h"
#import "QJCommonCell.h"
#import "QJArrowItem.h"
#import "QJSwitchItem.h"
#import "QJLabelItem.h"


@interface QJDiscoverController ()

@end

@implementation QJDiscoverController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    UITextField *searchBar = [QJSearchBar searchBar];
    searchBar.width = [UIScreen mainScreen].bounds.size.width - 20;
    searchBar.height = 30;
   
    self.navigationItem.titleView = searchBar;
    
    // 初始化模型
    [self setupGroups];
    
}

- (void)setupGroups {
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
}

- (void)setupGroup0 {
    // 创建组
    QJCommonGroup *group = [QJCommonGroup group];
    [self.groups addObject:group];
    
    // 设置组的所有行数据
    QJArrowItem *hotStatus = [QJArrowItem itemWithTitle:@"热门微博" icon:@"hot_status"];
    hotStatus.subtitle = @"笑话，娱乐，神最右都搬到这啦";
    
    QJArrowItem *findPeople = [QJArrowItem itemWithTitle:@"找人" icon:@"find_people"];
    findPeople.subtitle = @"名人、有意思的人尽在这里";
    
    group.items = @[hotStatus, findPeople];
}

- (void)setupGroup1 {
    // 1.创建组
    QJCommonGroup *group = [QJCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    QJSwitchItem *gameCenter = [QJSwitchItem itemWithTitle:@"游戏中心" icon:@"game_center"];
    QJSwitchItem *near = [QJSwitchItem itemWithTitle:@"周边" icon:@"near"];
    QJSwitchItem *app = [QJSwitchItem itemWithTitle:@"应用" icon:@"app"];
    
    group.items = @[gameCenter, near, app];
}

- (void)setupGroup2 {
    // 1.创建组
    QJCommonGroup *group = [QJCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    QJLabelItem *video = [QJLabelItem itemWithTitle:@"视频" icon:@"video"];
    video.labelTitle = @"更多详情咨询";
    QJCommonItem *music = [QJCommonItem itemWithTitle:@"音乐" icon:@"music"];
    music.badgeValue = @"8";
    QJCommonItem *movie = [QJCommonItem itemWithTitle:@"电影" icon:@"movie"];
    movie.badgeValue = @"99+";
    QJCommonItem *cast = [QJCommonItem itemWithTitle:@"播客" icon:@"cast"];
    QJCommonItem *more = [QJCommonItem itemWithTitle:@"更多" icon:@"more"];
    
    group.items = @[video, music, movie, cast, more];
}

@end
