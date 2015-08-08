//
//  QJComposePhotoView.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/3.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJComposePhotoView.h"

@implementation QJComposePhotoView

/**
 *  增加一张图片
 */
-(void)addImage:(UIImage *)image {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [self addSubview:imageView];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    int count = (int)self.subviews.count;
    CGFloat margin = 10;
    int column = 4;
    CGFloat imageW = (QJScreenW - (column + 1) * margin) / 4.0;
    CGFloat imageH = imageW;
    for (int i = 0; i < count; i++) {
        UIImageView *imageView = self.subviews[i];
        int row = i / column;
        int col = i % column;
        imageView.x = margin + (margin + imageW) * col;
        imageView.y = margin + (margin + imageH) * row;
        imageView.width = imageW;
        imageView.height = imageH;
    }
}

-(NSMutableArray *)images {
    NSMutableArray *array = [NSMutableArray array];
    for (UIImageView *imageView in self.subviews) {
        [array addObject:imageView.image];
    }
    return array;
}

@end
