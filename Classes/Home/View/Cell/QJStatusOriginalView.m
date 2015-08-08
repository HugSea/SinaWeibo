//
//  QJStatusOriginalView.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/5.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJStatusOriginalView.h"
#import "UIImageView+WebCache.h"
#import "QJStatusOriginalFrame.h"
#import "QJStatus.h"
#import "QJUser.h"
#import "QJStatusPhotosView.h"

@interface QJStatusOriginalView ()

/**
 *  昵称
 */
@property (nonatomic, weak) UILabel *nameLabel;
/**
 *  正文
 */
@property (nonatomic, weak) UILabel *textLabel;
/**
 *  时间
 */
@property (nonatomic, weak) UILabel *timeLabel;
/**
 *  来源
 */
@property (nonatomic, weak) UILabel *sourceLabel;
/**
 *  头像
 */
@property (nonatomic, weak) UIImageView *iconView;
/**
 *  VIP图标
 */
@property (nonatomic, weak) UIImageView *vipView;
/**
 *  配图相册
 */
@property (nonatomic, weak) QJStatusPhotosView *photosView;

@end

@implementation QJStatusOriginalView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        // 添加昵称
        UILabel *nameLable = [[UILabel alloc] init];
        nameLable.font = QJStatusOrginalNameFont;
        [self addSubview:nameLable];
        self.nameLabel = nameLable;
        
        // 添加VIP图标
        UIImageView *vipView = [[UIImageView alloc] init];
        [self addSubview:vipView];
        self.vipView = vipView;
        
        // 添加正文
        UILabel *textLable = [[UILabel alloc] init];
        textLable.font = QJStatusOrginalTextFont;
        textLable.numberOfLines = 0;
        [self addSubview:textLable];
        self.textLabel = textLable;
        
        // 添加时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = QJStatusOrginalTimeFont;
        timeLabel.textColor = [UIColor orangeColor];
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        // 添加来源
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.font = QJStatusOrginalSourceFont;
        sourceLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        // 添加头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        // 添加配图相册
        QJStatusPhotosView *photosView = [[QJStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
    }
    return self;
}

/**
 *  设置原创微博Frame
 */
-(void)setOriginalFrame:(QJStatusOriginalFrame *)originalFrame {
    
    _originalFrame = originalFrame;
    
    self.frame = originalFrame.frame;
    
    // 设置头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:originalFrame.status.user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    self.iconView.frame = originalFrame.iconFrame;
    
    // 设置昵称
    self.nameLabel.text = originalFrame.status.user.name;
    self.nameLabel.frame = originalFrame.nameFrame;
    
    // 设置VIP
    if (originalFrame.status.user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d", originalFrame.status.user.mbrank]];
        self.nameLabel.textColor = [UIColor colorWithRed:0.949 green:0.350 blue:0.066 alpha:1.000];
        self.vipView.frame = originalFrame.vipFrame;
    } else {
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    // 设置时间
    self.timeLabel.text = originalFrame.status.created_at;
    // 设置时间Frame
    CGFloat timeX = CGRectGetMinX(self.nameLabel.frame);
    CGFloat timeY = CGRectGetMaxY(self.nameLabel.frame) + QJStatusCellInset;
    CGSize timeSize = [self.timeLabel.text sizeWithAttributes:@{NSFontAttributeName :QJStatusOrginalTimeFont}];
    self.timeLabel.frame = (CGRect){{timeX, timeY}, timeSize};
    
    // 设置来源
    self.sourceLabel.text = originalFrame.status.source;
    // 设置来源Frame
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + QJStatusCellInset;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [self.sourceLabel.text sizeWithAttributes:@{NSFontAttributeName : QJStatusOrginalSourceFont}];
    self.sourceLabel.frame = (CGRect){{sourceX, sourceY}, sourceSize};
    
    // 设置正文
    self.textLabel.text = originalFrame.status.text;
    self.textLabel.frame = originalFrame.textFrame;
    
    // 设置配图相册
    if (originalFrame.status.pic_urls.count > 0) {
        self.photosView.hidden = NO;
        self.photosView.frame = originalFrame.photosFrame;
        self.photosView.pic_urls = originalFrame.status.pic_urls;
    } else {
        self.photosView.hidden = YES;
    }
}

@end
