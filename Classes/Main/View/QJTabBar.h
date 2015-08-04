//
//  QJTabBar.h
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/1.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QJTabBar : UITabBar

@property (nonatomic, copy) void(^tabBarPlusButtonClickedBlock)(void);

@end
