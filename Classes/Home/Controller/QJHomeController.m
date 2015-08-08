//
//  QJHomeController.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/7/31.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJHomeController.h"
#import "QJTitleButton.h"
#import "QJHttpTool.h"
#import "QJAccountTool.h"
#import "QJAccount.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "QJStatus.h"
#import "QJUser.h"
#import "QJStatusTool.h"
#import "QJUserTool.h"
#import "QJStatusFrame.h"
#import "QJStatusCell.h"

@interface QJHomeController ()

@property (nonatomic, strong) NSMutableArray *statusFrames;
@property (nonatomic, strong) QJTitleButton *titleBtn;
@property (nonatomic, weak) UIRefreshControl *refreshControl;

@end

@implementation QJHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏状态
    [self setupNavBar];
    
    // 集成刷新控件
    [self setupRefresh];
    
    // 获取用户昵称
    [self setupUserInfo];
    
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.959 alpha:1.000];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

/**
 *  获得用户信息
 */
- (void)setupUserInfo
{
    // 封装请求参数
    QJUserInfoParam *params = [[QJUserInfoParam alloc] init];
    params.access_token = [QJAccountTool account].access_token;
    params.uid = @([[QJAccountTool account].uid longLongValue]);
    
    // 发送GET请求
    [QJUserTool userInfoWithParams:params success:^(QJUserInfoResult *user) {
        // 设置用户的昵称为标题
        [self.titleBtn setTitle:user.name forState:UIControlStateNormal];
        
        // 存储帐号信息
        QJAccount *account = [QJAccountTool account];
        account.name = user.name;
        [QJAccountTool save:account];
    } failure:^(NSError *error) {
        NSLog(@"error = %@", error);
    }];
}

-(NSMutableArray *)statusFrames {
    if (!_statusFrames) {
        _statusFrames = [[NSMutableArray alloc] init];
    }
    return _statusFrames;
}

- (void)setupNavBar {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_friendsearch" highlightedImageName:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendsearch)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_pop" highlightedImageName:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    QJTitleButton *titleBtn = [QJTitleButton buttonWithType:UIButtonTypeCustom];
    titleBtn.height = 35;
    NSString *name = [QJAccountTool account].name;
    [titleBtn setTitle:name ? name : @"首页" forState:UIControlStateNormal];
    [titleBtn addTarget:self action:@selector(titleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    self.titleBtn = titleBtn;
    
    self.navigationItem.titleView = titleBtn;
}
/**
 *  集成刷新控件
 */
- (void)setupRefresh {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:refreshControl];
    self.refreshControl = refreshControl;
    
    [refreshControl addTarget:self action:@selector(refreshControlStateChange:) forControlEvents:UIControlEventValueChanged];
    
    // 第一次进入页面开始刷新
    [refreshControl beginRefreshing];
    [self refreshControlStateChange:refreshControl];
}

/**
 *  根据微博模型数组 转成 微博frame模型数据
 *
 *  @param statuses 微博模型数组
 *
 */
- (NSArray *)statusFramesWithStatuses:(NSArray *)statuses {
    NSMutableArray *frames = [NSMutableArray array];
    for (QJStatus *status in statuses) {
        QJStatusFrame *frame = [[QJStatusFrame alloc] init];
        // 传递微博模型数据，计算所有子控件的frame
        frame.status = status;
        [frames addObject:frame];
    }
    return frames;
}

/**
 *  刷新控件状态发生改变时调用
 */
- (void)refreshControlStateChange:(UIRefreshControl *)refreshControl {
    
    // 创建请求参数
    QJHomeStatusesParam *params = [[QJHomeStatusesParam alloc] init];
    params.access_token = [QJAccountTool account].access_token;
    // 如果存在微博状态信息,设置since_id属性
    QJStatusFrame *firstStatusFrame = [self.statusFrames firstObject];
    QJStatus *firstStatus = firstStatusFrame.status;
    if (firstStatus) {
        params.since_id = @([firstStatus.idstr longLongValue]);
    }
    
    // 发送GET请求
    [QJStatusTool homeStatusesWithParams:params success:^(QJHomeStatusesResult *result) {
        // 获得最新的微博frame数组
        NSArray *newFrames = [self statusFramesWithStatuses:result.statuses];
        // 插入最新状态信息
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:newFrames atIndexes:indexSet];
        // 刷新tableView
        [self.tableView reloadData];
        // 结束刷新控件
        [refreshControl endRefreshing];
        // 提示用户最新微博数据数量
        [self showNewStatusCount:(int)newFrames.count];
    } failure:^(NSError *error) {
        NSLog(@"error = %@", error);
        [refreshControl endRefreshing];
    }];
}

/**
 *  点击home标签刷新控件
 */
-(void)refresh:(BOOL)fromSelf {
    if (self.tabBarItem.badgeValue) {
        // 如果有数字
        [self.refreshControl beginRefreshing];
        // 刷新控件
        [self refreshControlStateChange:self.refreshControl];
    } else if (fromSelf) {
        // 没有数字,滚动到顶部
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

/**
 *  提示用户最新微博数据数量
 *
 *  @param count 最新微博数据数量
 */
- (void)showNewStatusCount:(int)count {
    // 创建提示框
    UILabel *label = [[UILabel alloc] init];
    if (count == 0) {
        label.text = @"没有最新微博数据";
    } else {
        label.text = [NSString stringWithFormat:@"共有%d条最新微博", count];
    }
    // 设置提示框属性
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.x = 0;
    label.width = QJScreenW;
    label.height = 35;
    label.y = 64 - label.height;
    // 添加提示框到导航控制器view
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    // 动画
    NSTimeInterval duration = 1.0;
    [UIView animateWithDuration:duration animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        [UIView animateKeyframesWithDuration:duration delay:1.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

- (void)titleBtnClicked:(QJTitleButton *)btn {
    if (!btn.selected) {
        [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    } else {
        [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    }
    btn.selected = !btn.selected;
}

- (void)friendsearch {
    NSLog(@"------friendsearch");
}

- (void)pop {
    NSLog(@"-------pop");
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QJStatusCell *cell = [QJStatusCell cellWithTableView:tableView];
    
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    QJStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}

@end
