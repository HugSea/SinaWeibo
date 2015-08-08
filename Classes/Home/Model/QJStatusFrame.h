//
//  QJStatusFrame.h
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/6.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QJStatus, QJStatusDetailFrame;

@interface QJStatusFrame : NSObject

@property (nonatomic, strong) QJStatusDetailFrame *detailFrame;
@property (nonatomic, assign) CGRect toolBarFrame;

/**
 *  微博数据模型
 */
@property (nonatomic, strong) QJStatus *status;
/**
 *  Cell高度
 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
