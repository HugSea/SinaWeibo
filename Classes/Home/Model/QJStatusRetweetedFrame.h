//
//  QJStatusRetweetedFrame.h
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/6.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QJStatus;

@interface QJStatusRetweetedFrame : NSObject

/**
 *  昵称Frame
 */
@property (nonatomic, assign) CGRect nameFrame;
/**
 *  正文Frame
 */
@property (nonatomic, assign) CGRect textFrame;
/**
 *  配图相册Frame
 */
@property (nonatomic, assign) CGRect photosFrame;
/**
 *  转发微博数据模型
 */
@property (nonatomic, strong) QJStatus *retweetedStatus;
/**
 *  frame
 */
@property (nonatomic, assign) CGRect frame;

@end
