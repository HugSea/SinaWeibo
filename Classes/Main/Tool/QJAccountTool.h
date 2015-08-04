//
//  QJAccountTool.h
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/2.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QJAccount;

@interface QJAccountTool : NSObject

/**
 *  存储账号模型
 */
+ (void)save:(QJAccount *)account;
/**
 *  读取归档,读取账号模型
 */
+ (QJAccount *)account;

@end
