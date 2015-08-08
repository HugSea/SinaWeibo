//
//  QJStatusTool.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/4.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJStatusTool.h"
#import "QJHttpTool.h"
#import "MJExtension.h"

@implementation QJStatusTool

/**
 *  加载首页的微博数据
 *
 *  @param params   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+(void)homeStatusesWithParams:(QJHomeStatusesParam *)params success:(void (^)(QJHomeStatusesResult *))success failure:(void (^)(NSError *))failure {
    [QJHttpTool get:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params.keyValues success:^(id responseObjt) {
        if (success) {
            QJHomeStatusesResult *result = [QJHomeStatusesResult objectWithKeyValues:responseObjt];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

/**
 *  发布微博不加图片
 *
 *  @param params   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)SendStatusWithoutPhotoWithParams:(QJSendStatusParam *)params success:(void(^)(QJSendStatusResult *result))success failure:(void(^)(NSError *error))failure {
    [QJHttpTool post:@"https://api.weibo.com/2/statuses/update.json" params:params.keyValues success:^(id responseObjt) {
        if (success) {
            QJSendStatusResult *result = [QJSendStatusResult objectWithKeyValues:responseObjt];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

/**
 *  发布微博加图片
 *
 *  @param params   请求参数
 *  @param constructingBodyWithBlock 请求需要添加的文件参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)SendStatusWithPhotoWithParams:(QJSendStatusParam *)params constructingBodyWithBlock:(void(^)(id<AFMultipartFormData> formData))constructingBodyWithBlock success:(void(^)(QJSendStatusResult *result))success failure:(void(^)(NSError *error))failure {
    [QJHttpTool post:@"https://upload.api.weibo.com/2/statuses/upload.json" params:params.keyValues constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (constructingBodyWithBlock) {
            constructingBodyWithBlock(formData);
        }
    } success:^(id responseObjt) {
        if (success) {
            QJSendStatusResult *result = [QJSendStatusResult objectWithKeyValues:responseObjt];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
