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
            photoView.tag = i;
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
    // 创建图片浏览器
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    
    // 设置图片浏览器显示的所有图片
    NSMutableArray *photos = [NSMutableArray array];
    int count = (int)self.pic_urls.count;
    for (int i = 0; i < count; i++) {
        QJPhoto *pic = self.pic_urls[i];
        
        MJPhoto *photo = [[MJPhoto alloc] init];
        // 设置图片的路径
        photo.url = [NSURL URLWithString:pic.bmiddle_pic];
        // 设置来源于哪一个ImageView
        photo.srcImageView = self.subviews[i];
        [photos addObject:photo];
    }
    browser.photos = photos;
    
    // 设置默认显示的图片索引
    browser.currentPhotoIndex = recognizer.view.tag;
    
    // 显示浏览器
    [browser show];
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
