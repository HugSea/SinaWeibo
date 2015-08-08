//
//  QJStatusPhotosView.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/8.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJStatusPhotosView.h"
#import "QJStatusPhotoView.h"
#import "MJPhotoBrowser.h"
#import "QJPhoto.h"
#import "MJPhoto.h"

#define kStatusPhotosMaxCount 9
#define kStatusPhotoMaxCols(photosCount) ((photosCount) == 4 ? 2 : 3)
#define kStatusPhotoMargin 5
#define kStatusPhotoW (QJScreenW - QJStatusCellInset * 2 - kStatusPhotoMargin * 2) / 3.0
#define kStatusPhotoH kStatusPhotoW

@implementation QJStatusPhotosView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 预先创建9个图片控件
        for (int i = 0; i < kStatusPhotosMaxCount; i++) {
            QJStatusPhotoView *photoView = [[QJStatusPhotoView alloc] init];
            [self addSubview:photoView];
            
            // 添加手势监听器（一个手势监听器 只能 监听对应的一个view）
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] init];
            [recognizer addTarget:self action:@selector(tapPhoto:)];
            [photoView addGestureRecognizer:recognizer];
        }
    }
    return self;
}

/**
 *  手势触发事件
 */
- (void)tapPhoto:(UITapGestureRecognizer *)recognizer
{
    // 添加一个盖板
    UIView *cover = [[UIView alloc] init];
    cover.frame = [UIScreen mainScreen].bounds;
    cover.backgroundColor = [UIColor blackColor];
    [[UIApplication sharedApplication].keyWindow addSubview:cover];
    
    // 将图片加到盖板上
    QJStatusPhotoView *photoView = (QJStatusPhotoView *)recognizer.view;
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = photoView.image;
    // 将photoView.frame从self的坐标系转换为cover坐标系
    imageView.frame = [cover convertRect:photoView.frame fromView:self];
    [cover addSubview:imageView];
    
    // 放大
    [UIView animateWithDuration:1.0 animations:^{
        CGRect frame = imageView.frame;
        frame.size.width = cover.width;
        frame.size.height = frame.size.width * (imageView.height / imageView.width);
        frame.origin.x = 0;
        frame.origin.y = (cover.height - frame.size.height) * 0.5;
        imageView.frame = frame;
    }];
}

-(void)setPic_urls:(NSArray *)pic_urls {
    _pic_urls = pic_urls;
    
    for (int i = 0; i < kStatusPhotosMaxCount; i++) {
        QJStatusPhotoView *photoView = self.subviews[i];
        
        if (i < pic_urls.count) {
            photoView.photo = pic_urls[i];
            photoView.hidden = NO;
        } else {
            photoView.hidden = YES;
        }
    }
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    int count = (int)self.pic_urls.count;
    int maxCols = kStatusPhotoMaxCols(count);
    for (int i = 0; i < count; i++) {
        QJStatusPhotoView *photoView = self.subviews[i];
        photoView.width = kStatusPhotoW;
        photoView.height = kStatusPhotoH;
        photoView.x = (i % maxCols) * (kStatusPhotoW + kStatusPhotoMargin);
        photoView.y = (i / maxCols) * (kStatusPhotoH + kStatusPhotoMargin);
    }
}

+ (CGSize)sizeWithPhotosCount:(int)photosCount
{
    // 一行最多几列
    int maxCols = kStatusPhotoMaxCols(photosCount);
    
    // 总列数
    int totalCols = photosCount >= maxCols ?  maxCols : photosCount;
    
    // 总行数
    // 知道总个数
    // 知道每一页最多显示多少个
    // 能算出一共能显示多少页
    int totalRows = (photosCount + maxCols - 1) / maxCols;
    
    // 计算尺寸
    CGFloat photosW = totalCols * kStatusPhotoW + (totalCols - 1) * kStatusPhotoMargin;
    CGFloat photosH = totalRows * kStatusPhotoH + (totalRows - 1) * kStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}

@end
