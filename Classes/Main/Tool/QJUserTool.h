//
//  QJUserTool.h
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/4.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QJUserInfoParam.h"
#import "QJUserInfoResult.h"
#import "QJUnreadCountParam.h"
#import "QJUnreadCountResult.h"

@interface QJUserTool : NSObject

/**
 *  加载首页的微博数据
 *
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)userInfoWithParams:(QJUserInfoParam *)params success:(void(^)(QJUserInfoResult *result))success failure:(void(^)(NSError *error))failure;

/**
 *  获取用户未读数
 *
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)unreadCountWithParams:(QJUnreadCountParam *)params success:(void(^)(QJUnreadCountResult *result))success failure:(void(^)(NSError *error))failure;

@end
