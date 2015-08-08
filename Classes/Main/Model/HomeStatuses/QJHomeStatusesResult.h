//
//  QJHomeStatusesResult.h
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/4.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QJHomeStatusesResult : NSObject

/** 微博数组（装着HMStatus模型） */
@property (nonatomic, strong) NSArray *statuses;

/** 近期的微博总数 */
@property (nonatomic, assign) int total_number;

@end
