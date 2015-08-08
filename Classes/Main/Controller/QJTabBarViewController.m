//
//  QJTabBarViewController.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/7/31.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJTabBarViewController.h"
#import "QJDiscoverController.h"
#import "QJHomeController.h"
#import "QJMessageController.h"
#import "QJMineController.h"
#import "QJNavigationController.h"
#import "QJTabBar.h"
#import "QJComposeViewController.h"
#import "QJUserTool.h"
#import "QJAccount.h"
#import "QJAccountTool.h"

@interface QJTabBarViewController () <UITabBarControllerDelegate>

@property (nonatomic, weak) QJHomeController *homeVc;
@property (nonatomic, weak) QJMessageController *messageVc;
@property (nonatomic, weak) QJMineController *mineVc;
@property (nonatomic, strong) UIViewController *lastViewController;

@end

@implementation QJTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
    // 添加子视图控制器
    [self addChildViewControllers];
    
    // 添加自定义TabBar
    [self addCustomTabBar];
    
    // 设置定时器获取当前用户未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(getUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [timer fire];
}

/**
 *  添加子视图控制器
 */
- (void)addChildViewControllers {
    // 首页
    QJHomeController *homeVc = [[QJHomeController alloc] init];
    [self addOneChileVc:homeVc andTitle:@"首页" andImageName:@"tabbar_home" andSelectedImageName:@"tabbar_home_selected"];
    self.homeVc = homeVc;
    self.lastViewController = self.homeVc;
    
    // 消息
    QJMessageController *messageVc = [[QJMessageController alloc] init];
    [self addOneChileVc:messageVc andTitle:@"消息" andImageName:@"tabbar_message_center" andSelectedImageName:@"tabbar_message_center_selected"];
    self.messageVc = messageVc;
    
    // 发现
    QJDiscoverController *discoverVc = [[QJDiscoverController alloc] init];
    [self addOneChileVc:discoverVc andTitle:@"发现" andImageName:@"tabbar_discover" andSelectedImageName:@"tabbar_discover_selected"];
    
    // 我
    QJMineController *mineVc = [[QJMineController alloc] init];
    [self addOneChileVc:mineVc andTitle:@"我" andImageName:@"tabbar_profile" andSelectedImageName:@"tabbar_profile_selected"];
    self.mineVc = mineVc;
}

/**
 *  添加自定义TabBar
 */
- (void)addCustomTabBar {
    QJTabBar *tabBar = [[QJTabBar alloc] init];
    // 点击加号按钮的block
    __weak typeof(self) selfVc = self;
    tabBar.tabBarPlusButtonClickedBlock = ^{
        QJComposeViewController *cvc = [[QJComposeViewController alloc] init];
        QJNavigationController *nvc = [[QJNavigationController alloc] initWithRootViewController:cvc];
        [selfVc presentViewController:nvc animated:YES completion:nil];
    };
    // KVC设置将自定义tabBar赋值给系统自带tabBar
    [self setValue:tabBar forKey:@"tabBar"];
    [self.tabBar setTintColor:[UIColor orangeColor]];
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar_background"]];
}

- (void)addOneChileVc:(UIViewController *)vc andTitle:(NSString *)title andImageName:(NSString *)imageName andSelectedImageName:(NSString *)selectedImageName{
    // 设置标签标题
    vc.title = title;
    
    // 设置标签图片
    vc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    QJNavigationController *nvc = [[QJNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nvc];
}

/**
 *  获取用户未读数
 */
- (void)getUnreadCount {
    // 创建请求参数
    QJUnreadCountParam *params = [[QJUnreadCountParam alloc] init];
    params.access_token = [QJAccountTool account].access_token;
    params.uid = @([[QJAccountTool account].uid longLongValue]);
    
    // 加载GET请求获取用户未读数
    [QJUserTool unreadCountWithParams:params success:^(QJUnreadCountResult *result) {
        // 微博未读数
        if (result.status == 0) {
            self.homeVc.tabBarItem.badgeValue = nil;
        } else {
            self.homeVc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        }
        // 消息未读数
        if (result.unreadMessageCount == 0) {
            self.messageVc.tabBarItem.badgeValue = nil;
        } else {
            self.messageVc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.unreadMessageCount];
        }
        // 我的未读数
        if (result.unreadMineCount == 0) {
            self.mineVc.tabBarItem.badgeValue = nil;
        } else {
            self.mineVc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.unreadMineCount];
        }
        // 设置app图片显示未读数
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalCount;
        
    } failure:^(NSError *error) {
        NSLog(@"获取用户未读数失败 --> %@", error);
    }];
}

#pragma mark - UITabBarViewController代理方法

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    QJNavigationController *nvc = (QJNavigationController *)viewController;
    if (nvc.viewControllers.firstObject == self.homeVc) {
        if (self.lastViewController == self.homeVc) {
            [self.homeVc refresh:YES];
        } else {
            [self.homeVc refresh:NO];
        }
    }
    self.lastViewController = nvc.viewControllers.firstObject;
}

@end
