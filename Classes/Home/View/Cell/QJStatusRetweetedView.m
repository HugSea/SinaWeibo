//
//  QJStatusRetweetedView.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/5.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJStatusRetweetedView.h"
#import "QJStatusRetweetedFrame.h"
#import "QJStatus.h"
#import "QJUser.h"
#import "QJStatusPhotosView.h"

@interface QJStatusRetweetedView ()

/**
 *  昵称
 */
@property (nonatomic, weak) UILabel *nameLabel;
/**
 *  正文
 */
@property (nonatomic, weak) UILabel *textLabel;
/**
 *  配图相册
 */
@property (nonatomic, weak) QJStatusPhotosView *photosView;

@end

@implementation QJStatusRetweetedView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        // 设置背景色
        self.image = [UIImage resizedImage:@"timeline_retweet_background"];
        
        // 添加昵称
        UILabel *nameLable = [[UILabel alloc] init];
        nameLable.textColor = QJColor(74, 102, 105);
        nameLable.font = QJStatusRetweetedNameFont;
        [self addSubview:nameLable];
        self.nameLabel = nameLable;
        
        // 添加正文
        UILabel *textLable = [[UILabel alloc] init];
        textLable.font = QJStatusRetweetedTextFont;
        textLable.numberOfLines = 0;
        [self addSubview:textLable];
        self.textLabel = textLable;
        
        // 添加配图相册
        QJStatusPhotosView *photosView = [[QJStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
    }
    return self;
}

/**
 *  设置转发微博Frame
 */
-(void)setRetweetedFrame:(QJStatusRetweetedFrame *)retweetedFrame {
    _retweetedFrame = retweetedFrame;
    
    self.frame = retweetedFrame.frame;
    
    // 设置昵称
    self.nameLabel.text = [NSString stringWithFormat:@"@%@", retweetedFrame.retweetedStatus.user.name];
    self.nameLabel.frame = retweetedFrame.nameFrame;
    
    // 设置正文
    self.textLabel.text = retweetedFrame.retweetedStatus.text;
    self.textLabel.frame = retweetedFrame.textFrame;
    
    // 设置配图相册
    if (retweetedFrame.retweetedStatus.pic_urls.count > 0) {
        self.photosView.hidden = NO;
        self.photosView.frame = retweetedFrame.photosFrame;
        self.photosView.pic_urls = retweetedFrame.retweetedStatus.pic_urls;
    } else {
        self.photosView.hidden = YES;
    }
}

@end
