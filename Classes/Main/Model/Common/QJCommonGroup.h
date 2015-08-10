//
//  QJCommonGroup.h
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/9.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QJCommonGroup : NSObject

/**
 *  头标题
 */
@property (nonatomic, copy) NSString *header;
/**
 *  尾标题
 */
@property (nonatomic, copy) NSString *footer;
/**
 *  存放每一行cell模型
 */
@property (nonatomic, strong) NSArray *items;

+ (instancetype)group;

@end
