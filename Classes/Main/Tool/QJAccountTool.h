//
//  QJAccountTool.h
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/2.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QJAccessTokenParam.h"
#import "QJAccount.h"

@interface QJAccountTool : NSObject

/**
 *  存储账号模型
 */
+ (void)save:(QJAccount *)account;
/**
 *  读取归档,读取账号模型
 */
+ (QJAccount *)account;
/**
 *  加载首页的微博数据
 *
 *  @param params   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)accessTokenWithParams:(QJAccessTokenParam *)params success:(void(^)(QJAccount *result))success failure:(void(^)(NSError *error))failure;

@end
