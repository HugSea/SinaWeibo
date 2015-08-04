//
//  QJAccountTool.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/2.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#define QJAccountFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

#import "QJAccountTool.h"
#import "QJAccount.h"

@implementation QJAccountTool

/**
 *  存储账号模型
 */
+ (void)save:(QJAccount *)account {
    [NSKeyedArchiver archiveRootObject:account toFile:QJAccountFilePath];
}
/**
 *  读取归档,读取账号模型
 */
+ (QJAccount *)account {
    QJAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:QJAccountFilePath];
    NSDate *now = [NSDate date];
    // 判断当前时间是否小于到期时间
    if ([now compare:account.expires_time] != NSOrderedAscending) {
        account = nil;
    }
    return account;
}

@end
