//
//  QJBadgeView.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/10.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJBadgeView.h"

@implementation QJBadgeView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        self.height = self.currentBackgroundImage.size.height;
    }
    return self;
}

-(void)setBadgeValue:(NSString *)badgeValue {
    _badgeValue = [badgeValue copy];
    
    // 设置按钮文字
    [self setTitle:badgeValue forState:UIControlStateNormal];
    
    // 计算view宽度
    CGSize viewSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}];
    CGFloat bgW = self.currentBackgroundImage.size.width;
    if (viewSize.width < bgW) {
        self.width = bgW;
    } else {
        self.width = viewSize.width + 10;
    }
    
}

@end
