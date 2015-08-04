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

@interface QJTabBarViewController ()

@end

@implementation QJTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 首页
    QJHomeController *homeVc = [[QJHomeController alloc] init];
    [self addOneChileVc:homeVc andTitle:@"首页" andImageName:@"tabbar_home" andSelectedImageName:@"tabbar_home_selected"];
    
    // 消息
    QJMessageController *messageVc = [[QJMessageController alloc] init];
    [self addOneChileVc:messageVc andTitle:@"消息" andImageName:@"tabbar_message_center" andSelectedImageName:@"tabbar_message_center_selected"];
    
    // 发现
    QJDiscoverController *discoverVc = [[QJDiscoverController alloc] init];
    [self addOneChileVc:discoverVc andTitle:@"发现" andImageName:@"tabbar_discover" andSelectedImageName:@"tabbar_discover_selected"];
    
    // 我
    QJMineController *mineVc = [[QJMineController alloc] init];
    [self addOneChileVc:mineVc andTitle:@"我" andImageName:@"tabbar_profile" andSelectedImageName:@"tabbar_profile_selected"];
    
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

@end
