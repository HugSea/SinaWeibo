//
//  QJUserInfoParam.h
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/4.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QJUserInfoParam : NSObject

/**	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。*/
@property (nonatomic, copy) NSString *access_token;
/**	需要查询的用户ID。*/
@property (nonatomic, strong) NSNumber *uid;

@end
