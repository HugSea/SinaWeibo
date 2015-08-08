//
//  QJUser.h
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/2.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QJUser : NSObject

/** string 	友好显示名称 */
@property (nonatomic, copy) NSString *name;

/** string 	用户头像地址（中图），50×50像素 */
@property (nonatomic, copy) NSString *profile_image_url;
/** 会员类型 */
@property (nonatomic, assign) int mbtype;
/** 会员等级 */
@property (nonatomic, assign) int mbrank;
/** 是否为会员 */
@property (nonatomic, assign, getter=isVip) BOOL vip;

@end
