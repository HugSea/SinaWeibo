//
//  QJHttpTool.h
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/4.
//  Copyright (c) 2015年 QJ. All rights reserved.
//
// 将第三方框架封装成工具类,减少对第三方框架的依赖

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface QJHttpTool : NSObject

/**
 *  发送GET请求
 *
 *  @param url     请求链接
 *  @param params  请求参数
 *  @param success 请求成功
 *  @param failure 请求失败
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObjt))success failure:(void(^)(NSError *error))failure;

/**
 *  发送POST请求
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObjt)) success failure:(void(^)(NSError *error))failure;

/**
 *  发送POST请求(带文件参数)
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params constructingBodyWithBlock:(void(^)(id<AFMultipartFormData>formData))constructingBodyWithBlock success:(void(^)(id responseObjt))success failure:(void(^)(NSError *error))failure;

@end
