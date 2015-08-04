//
//  QJHttpTool.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/4.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJHttpTool.h"

@implementation QJHttpTool

/**
 *  发送GET请求
 *
 *  @param url     请求链接
 *  @param params  请求参数
 *  @param success 请求成功
 *  @param failure 请求失败
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObjt))success failure:(void(^)(NSError *error))failure {
    // 创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 发送GET请求
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  发送POST请求
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObjt)) success failure:(void(^)(NSError *error))failure {
    // 创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 发送POST请求
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  发送POST请求(带文件参数)
 */
+(void)post:(NSString *)url params:(NSDictionary *)params constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))constructingBodyWithBlock success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    // 创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 发送POST请求
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (constructingBodyWithBlock) {
            constructingBodyWithBlock(formData);
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
