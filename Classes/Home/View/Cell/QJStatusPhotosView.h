//
//  QJStatusPhotosView.h
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/8.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QJStatusPhotosView : UIView

/**
 *  图片数据（里面都是HMPhoto模型）
 */
@property (nonatomic, strong) NSArray *pic_urls;

+ (CGSize)sizeWithPhotosCount:(int)photosCount;

@end
