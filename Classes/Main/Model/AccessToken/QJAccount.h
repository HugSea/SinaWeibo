//
//  QJAccount.h
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/2.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QJAccount : NSObject <NSCoding>

/**
 *  用于调用access_token，接口获取授权后的access token。
 */
@property (nonatomic, copy) NSString *access_token;
/**
 *  access_token的生命周期，单位是秒数。
 */
@property (nonatomic, copy) NSString *expires_in;
/**
 *  access_token到期时间
 */
@property (nonatomic, strong) NSDate *expires_time;
/**
 *  当前授权用户的UID。
 */
@property (nonatomic, copy) NSString *uid;
/**
 *  用户名称
 */
@property (nonatomic, copy) NSString *name;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
