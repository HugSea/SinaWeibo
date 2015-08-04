//
//  QJTabBar.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/1.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJTabBar.h"

@interface QJTabBar ()

@property (nonatomic, weak) UIButton *plusButton;

@end

@implementation QJTabBar

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 添加+号按钮
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        // 设置正常状态图片
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        // 设置高亮状态图片
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [plusButton addTarget:self action:@selector(plusButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        self.plusButton = plusButton;
        [self addSubview:self.plusButton];
    }
    return self;
}

- (void)plusButtonClicked {
    if (_tabBarPlusButtonClickedBlock) {
        self.tabBarPlusButtonClickedBlock();
    }
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    // 遍历所有标签并设置frame
    CGFloat viewW = self.size.width / (self.items.count + 1);
    CGFloat viewH = self.size.height;
    CGFloat viewY = 0;
    int index = 0;
    for (UIView *view in self.subviews) {
        if (![view isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        CGFloat viewX = 0;
        if (index > 1) {
            viewX = (index + 1) * viewW;
        } else {
            viewX = index * viewW;
        }
        view.frame = CGRectMake(viewX, viewY, viewW, viewH);
        index++;
    }
    // 设置+号按钮frame
    self.plusButton.size = self.plusButton.currentBackgroundImage.size;
    self.plusButton.center = CGPointMake(self.width * 0.5, self.height * 0.5);
}

@end
