//
//  QJCommonViewController.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/7/31.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJCommonViewController.h"
#import "QJSearchBar.h"
#import "QJCommonGroup.h"
#import "QJCommonItem.h"
#import "QJCommonCell.h"
#import "QJArrowItem.h"
#import "QJSwitchItem.h"
#import "QJLabelItem.h"

@interface QJCommonViewController ()

@property (nonatomic, strong) NSMutableArray *groups;

@end

@implementation QJCommonViewController

-(NSMutableArray *)groups {
    if (!_groups) {
        _groups = [[NSMutableArray alloc] init];
    }
    return _groups;
}

-(instancetype)init {
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tableView属性
    self.tableView.backgroundColor = QJColor(211, 211, 211);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.sectionHeaderHeight = QJStatusCellInset;
    self.tableView.contentInset = UIEdgeInsetsMake(QJStatusCellInset - 35, 0, 0, 0);
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    QJCommonGroup *group = self.groups[section];
    return group.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QJCommonCell *cell = [QJCommonCell cellWithTableView:tableView];
    
    QJCommonGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    [cell setIndexPath:indexPath rowsInSection:(int)group.items.count];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取出当前行的模型
    QJCommonGroup *group = self.groups[indexPath.section];
    QJCommonItem *item = group.items[indexPath.row];
    
    // 跳转控制器
    if (item.destVcClass) {
        UIViewController *vc = [[item.destVcClass alloc] init];
        vc.title = item.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    // block操作
    if (item.operation) {
        item.operation();
    }
}

@end
