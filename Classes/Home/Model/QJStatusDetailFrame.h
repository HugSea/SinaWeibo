//
//  QJStatusDetailFrame.h
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/6.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QJStatus, QJStatusOriginalFrame, QJStatusRetweetedFrame;

@interface QJStatusDetailFrame : NSObject

/**
 *  原创微博Frame
 */
@property (nonatomic, strong) QJStatusOriginalFrame *originalFrame;
/**
 *  转载微博Frame
 */
@property (nonatomic, strong) QJStatusRetweetedFrame *retweetedFrame;
/**
 *  微博数据
 */
@property (nonatomic, strong) QJStatus *status;
/**
 *  frame
 */
@property (nonatomic, assign) CGRect frame;

@end
