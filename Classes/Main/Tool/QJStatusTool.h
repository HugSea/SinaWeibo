//
//  QJStatusTool.h
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/4.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QJHomeStatusesParam.h"
#import "QJHomeStatusesResult.h"
#import "QJSendStatusParam.h"
#import "QJSendStatusResult.h"
#import "AFNetworking.h"

@interface QJStatusTool : NSObject

/**
 *  加载首页的微博数据
 *
 *  @param params   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)homeStatusesWithParams:(QJHomeStatusesParam *)params success:(void(^)(QJHomeStatusesResult *result))success failure:(void(^)(NSError *error))failure;

/**
 *  发布微博不加图片
 *
 *  @param params   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)SendStatusWithoutPhotoWithParams:(QJSendStatusParam *)params success:(void(^)(QJSendStatusResult *result))success failure:(void(^)(NSError *error))failure;

/**
 *  发布微博加图片
 *
 *  @param params   请求参数
 *  @param constructingBodyWithBlock 请求需要添加的文件参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)SendStatusWithPhotoWithParams:(QJSendStatusParam *)params constructingBodyWithBlock:(void(^)(id<AFMultipartFormData> formData))constructingBodyWithBlock success:(void(^)(QJSendStatusResult *result))success failure:(void(^)(NSError *error))failure;

@end
