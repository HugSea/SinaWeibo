//
//  QJStatusOriginalFrame.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/6.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJStatusOriginalFrame.h"
#import "QJStatus.h"
#import "QJUser.h"
#import "QJStatusPhotosView.h"

@implementation QJStatusOriginalFrame

-(void)setStatus:(QJStatus *)status {
    
    _status = status;
    
    // 1.头像
    CGFloat iconX = QJStatusCellInset;
    CGFloat iconY = QJStatusCellInset;
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 2.昵称
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + QJStatusCellInset;
    CGFloat nameY = iconY;
    CGSize nameSize = [status.user.name sizeWithAttributes:@{NSFontAttributeName : QJStatusOrginalNameFont}];
    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    // 3.vip
    if (status.user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameFrame) + QJStatusCellInset;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = vipH;
        self.vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    // 4.正文
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(self.iconFrame) + QJStatusCellInset;
    CGFloat maxW = QJScreenW - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [status.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : QJStatusOrginalTextFont} context:nil].size;
    self.textFrame = (CGRect){{textX, textY}, textSize};
    
    // 5.配图相册
    CGFloat h = 0;
    if (status.pic_urls.count > 0) {
        CGFloat photosX = QJStatusCellInset;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + QJStatusCellInset;
        CGSize photosSize = [QJStatusPhotosView sizeWithPhotosCount:(int)status.pic_urls.count];
        self.photosFrame = CGRectMake(photosX, photosY, photosSize.width, photosSize.height);
        h = CGRectGetMaxY(self.photosFrame) + QJStatusCellInset;
    } else {
        h = CGRectGetMaxY(self.textFrame) + QJStatusCellInset;
    }
    
    // 自己
    CGFloat x = 0;
    CGFloat y = QJStatusCellInset;
    CGFloat w = QJScreenW;
    self.frame = CGRectMake(x, y, w, h);
}

@end
