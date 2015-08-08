//
//  QJUserTool.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/4.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJUserTool.h"
#import "QJHttpTool.h"
#import "MJExtension.h"

@implementation QJUserTool

/**
 *  加载首页的微博数据
 *
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)userInfoWithParams:(QJUserInfoParam *)params success:(void (^)(QJUserInfoResult *))success failure:(void (^)(NSError *))failure {
    [QJHttpTool get:@"https://api.weibo.com/2/users/show.json" params:params.keyValues success:^(id responseObjt) {
        if (success) {
            QJUserInfoResult *result = [QJUserInfoResult objectWithKeyValues:responseObjt];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

/**
 *  获取用户未读数
 *
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)unreadCountWithParams:(QJUnreadCountParam *)params success:(void(^)(QJUnreadCountResult *result))success failure:(void(^)(NSError *error))failure {
    [QJHttpTool get:@"https://rm.api.weibo.com/2/remind/unread_count.json" params:params.keyValues success:^(id responseObjt) {
        if (success) {
            QJUnreadCountResult *result = [QJUnreadCountResult objectWithKeyValues:responseObjt];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
