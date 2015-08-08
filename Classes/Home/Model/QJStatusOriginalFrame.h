//
//  QJStatusOriginalFrame.h
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/6.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QJStatus;

@interface QJStatusOriginalFrame : NSObject

/**
 *  昵称Frame
 */
@property (nonatomic, assign) CGRect nameFrame;
/**
 *  正文Frame
 */
@property (nonatomic, assign) CGRect textFrame;
/**
 *  时间Frame
 */
@property (nonatomic, assign) CGRect timeFrame;
/**
 *  数据源Frame
 */
@property (nonatomic, assign) CGRect sourceFrame;
/**
 *  头像Frame
 */
@property (nonatomic, assign) CGRect iconFrame;
/**
 *  VIP图标Frame
 */
@property (nonatomic, assign) CGRect vipFrame;
/**
 *  配图相册Frame
 */
@property (nonatomic, assign) CGRect photosFrame;
/**
 *  正文数据模型
 */
@property (nonatomic, strong) QJStatus *status;
/**
 *  frame
 */
@property (nonatomic, assign) CGRect frame;

@end
