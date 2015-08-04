//
//  QJComposeToolBar.h
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/3.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    QJComposeToolbarButtonTypeCamera, // 照相机
    QJComposeToolbarButtonTypePicture, // 相册
    QJComposeToolbarButtonTypeMention, // 提到@
    QJComposeToolbarButtonTypeTrend, // 话题
    QJComposeToolbarButtonTypeEmotion // 表情
}QJComposeToolBarButtonType;

@interface QJComposeToolBar : UIView

@property (nonatomic, copy) void(^composeToolBarButtonClickedBlock)(UIButton *button);;

@end
