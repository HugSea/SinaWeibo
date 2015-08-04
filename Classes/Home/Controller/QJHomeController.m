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

@interface QJHomeController ()

@property (nonatomic, strong) NSMutableArray *statuses;
@property (nonatomic, strong) QJTitleButton *titleBtn;

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
}

/**
 *  获得用户信息
 */
- (void)setupUserInfo
{
    // 封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [QJAccountTool account].access_token;
    params[@"uid"] = [QJAccountTool account].uid;
    
    // 发送GET请求
    [QJHttpTool get:@"https://api.weibo.com/2/users/show.json" params:params success:^(id responseObjt) {
        // 字典转模型
        QJUser *user = [QJUser objectWithKeyValues:responseObjt];
        
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

-(NSMutableArray *)statuses {
    if (!_statuses) {
        _statuses = [[NSMutableArray alloc] init];
    }
    return _statuses;
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
    
    [refreshControl addTarget:self action:@selector(refreshControlStateChange:) forControlEvents:UIControlEventValueChanged];
    
    // 第一次进入页面开始刷新
    [refreshControl beginRefreshing];
    [self refreshControlStateChange:refreshControl];
}
/**
 *  刷新控件状态发生改变时调用
 */
- (void)refreshControlStateChange:(UIRefreshControl *)refreshControl {
    
    // 创建请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [QJAccountTool account].access_token;
    // 如果存在微博状态信息,设置since_id属性
    QJStatus *firstStatus = [self.statuses firstObject];
    if (firstStatus) {
        params[@"since_id"] = firstStatus.idstr;
    }
    
    // 发送GET请求
    [QJHttpTool get:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params success:^(id responseObjt) {
        // 微博字典数组
        NSArray *statusArray = responseObjt[@"statuses"];
        // 微博字典数组->微博模型数组
        NSArray *newStatuses = [QJStatus objectArrayWithKeyValuesArray:statusArray];
        // 插入最新状态信息
        NSRange range = NSMakeRange(0, newStatuses.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statuses insertObjects:newStatuses atIndexes:indexSet];
        // 刷新tableView
        [self.tableView reloadData];
        // 结束刷新控件
        [refreshControl endRefreshing];
        // 提示用户最新微博数据数量
        [self showNewStatusCount:(int)newStatuses.count];
    } failure:^(NSError *error) {
        NSLog(@"error = %@", error);
        [refreshControl endRefreshing];
    }];
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
    label.width = screenW;
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
    return self.statuses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    // 取出对应status模型
    QJStatus *status = self.statuses[indexPath.row];
    cell.textLabel.text = status.text;
    // 取出对应user模型
    QJUser *user = status.user;
    cell.detailTextLabel.text = user.name;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
