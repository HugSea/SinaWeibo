//
//  QJStatusRetweetedFrame.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/6.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJStatusRetweetedFrame.h"
#import "QJUser.h"
#import "QJStatus.h"
#import "QJStatusPhotosView.h"

@implementation QJStatusRetweetedFrame

-(void)setRetweetedStatus:(QJStatus *)retweetedStatus {
    
    _retweetedStatus = retweetedStatus;
    
    // 1.昵称
    CGFloat nameX = QJStatusCellInset;
    CGFloat nameY = QJStatusCellInset;
    NSString *name = [NSString stringWithFormat:@"@%@", retweetedStatus.user.name];
    CGSize nameSize = [name sizeWithAttributes:@{NSFontAttributeName : QJStatusRetweetedNameFont}];
    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    // 2.正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(self.nameFrame) + QJStatusCellInset;
    CGFloat maxW = QJScreenW - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [retweetedStatus.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :QJStatusRetweetedTextFont} context:nil].size;
    self.textFrame = (CGRect){{textX, textY}, textSize};
    
    // 3.配图相册
    CGFloat h = 0;
    if (retweetedStatus.pic_urls.count > 0) {
        CGFloat photosX = QJStatusCellInset;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + QJStatusCellInset;
        CGSize photosSize = [QJStatusPhotosView sizeWithPhotosCount:(int)retweetedStatus.pic_urls.count];
        self.photosFrame = CGRectMake(photosX, photosY, photosSize.width, photosSize.height);
        h = CGRectGetMaxY(self.photosFrame) + QJStatusCellInset;
    } else {
        h = CGRectGetMaxY(self.textFrame) + QJStatusCellInset;
    }
    
    // 自己
    CGFloat x = 0;
    CGFloat y = 0; // 高度 = 原创微博最大的Y值
    CGFloat w = QJScreenW;
    self.frame = CGRectMake(x, y, w, h);
}

@end
