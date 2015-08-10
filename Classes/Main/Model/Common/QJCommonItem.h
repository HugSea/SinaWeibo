//
//  QJCommonItem.h
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/9.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QJCommonItem : NSObject

/** 图标 */
@property (nonatomic, copy) NSString *icon;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 子标题 */
@property (nonatomic, copy) NSString *subtitle;
/**
 *  显示动态个数值
 */
@property (nonatomic, copy) NSString *badgeValue;
/**
 *  目标控制器类
 */
@property (nonatomic, assign) Class destVcClass;
/**
 *  点击cell触发事件的block
 */
@property (nonatomic, copy) void(^operation)();

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;
+ (instancetype)itemWithTitle:(NSString *)title;

@end
