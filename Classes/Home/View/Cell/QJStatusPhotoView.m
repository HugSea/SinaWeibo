//
//  QJStatusPhotoView.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/8.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJStatusPhotoView.h"
#import "QJPhoto.h"
#import "UIImageView+WebCache.h"

@interface QJStatusPhotoView ()

@property (nonatomic, weak) UIImageView *gifView;

@end

@implementation QJStatusPhotoView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        
        // 添加GIF图片
        UIImageView *gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return self;
}

-(void)setPhoto:(QJPhoto *)photo {
    _photo = photo;
    
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    NSLog(@"%@", photo.thumbnail_pic);
    
    // 是否隐藏gif图片
    NSString *extension = photo.thumbnail_pic.pathExtension.lowercaseString;
    self.gifView.hidden = ![extension isEqualToString:@"gif"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

@end
