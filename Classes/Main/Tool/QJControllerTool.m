//
//  QJControllerTool.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/2.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJControllerTool.h"
#import "QJNewfeatureViewController.h"
#import "QJTabBarViewController.h"

@implementation QJControllerTool

+ (void)chooseRootViewController {
    // 查询当前app版本号,并设置是否显示新特性
    NSString *version = (__bridge NSString *)kCFBundleVersionKey;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // info.plist信息
    NSDictionary *infoDict = [NSBundle mainBundle].infoDictionary;
    // 上一次打开app的版本号
    NSString *lastVersion = [defaults objectForKey:version];
    // 当前版本号
    NSString *currentVersion = infoDict[version];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (![currentVersion isEqualToString:lastVersion]) {
        // 当前版本号与上一次打开app的版本号不一致,需要显示新特性
        QJNewfeatureViewController *nvc = [[QJNewfeatureViewController alloc] init];
        window.rootViewController = nvc;
        [defaults setObject:infoDict[version] forKey:version];
    } else {
        // 当前版本号与上一次打开的app版本号一致,不需要显示新特性
        QJTabBarViewController *tvc = [[QJTabBarViewController alloc] init];
        window.rootViewController = tvc;
    }
}

@end
