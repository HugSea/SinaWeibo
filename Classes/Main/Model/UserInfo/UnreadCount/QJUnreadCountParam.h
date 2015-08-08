//
//  QJUnreadCountParam.h
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/5.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QJUnreadCountParam : NSObject

/** string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。*/
@property (nonatomic, copy) NSString *access_token;
/**	需要获取消息未读数的用户UID，必须是当前登录用户。*/
@property (nonatomic, strong) NSNumber *uid;

@end
