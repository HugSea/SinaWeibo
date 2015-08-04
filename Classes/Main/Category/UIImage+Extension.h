//
//  UIImage+Extension.h
//  SinaWeibo
//
//  Created by 张庆杰 on 15/7/31.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIImage (Extension)

// 返回一张拉伸后的图片
+ (UIImage *)resizedImage:(NSString *)imageName;
@end
