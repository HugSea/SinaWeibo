//
//  UIImage+Extension.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/7/31.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "UIImage+Extension.h"
#import "UIView+Extension.h"

@implementation UIImage (Extension)

// 返回一张拉伸后的图片
+ (UIImage *)resizedImage:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
