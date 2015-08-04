//
//  QJComposePhotoView.h
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/3.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QJComposePhotoView : UIView

@property (nonatomic, strong) NSMutableArray *images;

/**
 *  添加一张图片
 */
- (void)addImage:(UIImage *)image;

@end
