//
//  QJNavigationController.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/7/31.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJNavigationController.h"

@implementation QJNavigationController

+(void)initialize {
    // 设置导航栏字体属性
    UIBarButtonItem *barBtn = [UIBarButtonItem appearance];
    
    // 正常状态下
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    attrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [barBtn setTitleTextAttributes:attrs forState:UIControlStateNormal];
    // 高亮状态下
    NSMutableDictionary *highAttrs = [NSMutableDictionary dictionary];
    highAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    highAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    [barBtn setTitleTextAttributes:highAttrs forState:UIControlStateHighlighted];
    // 失效状态下
    NSMutableDictionary *disableAttrs = [NSMutableDictionary dictionary];
    disableAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    disableAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [barBtn setTitleTextAttributes:disableAttrs forState:UIControlStateDisabled];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 设置导航栏按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_back" highlightedImageName:@"navigationbar_back_highlighted" target:self action:@selector(back)];
        
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_more" highlightedImageName:@"navigationbar_more_highlighted" target:self action:@selector(more)];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

- (void)more {
    [self popToRootViewControllerAnimated:YES];
}

@end
