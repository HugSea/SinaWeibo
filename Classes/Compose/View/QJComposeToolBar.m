//
//  QJComposeToolBar.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/3.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJComposeToolBar.h"

@implementation QJComposeToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 设置工具条背景
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        // 添加工具栏按钮
        [self addToolBarButtonWithImageName:@"compose_camerabutton_background" andHighlightedImageName:@"compose_camerabutton_background_highlighted" andTag:QJComposeToolbarButtonTypeCamera];
        [self addToolBarButtonWithImageName:@"compose_toolbar_picture" andHighlightedImageName:@"compose_toolbar_picture_highlighted" andTag:QJComposeToolbarButtonTypePicture];
        [self addToolBarButtonWithImageName:@"compose_mentionbutton_background" andHighlightedImageName:@"compose_mentionbutton_background_highlighted" andTag:QJComposeToolbarButtonTypeMention];
        [self addToolBarButtonWithImageName:@"compose_trendbutton_background" andHighlightedImageName:@"compose_trendbutton_background_highlighted" andTag:QJComposeToolbarButtonTypeTrend];
        [self addToolBarButtonWithImageName:@"compose_emoticonbutton_background" andHighlightedImageName:@"compose_emoticonbutton_background_highlighted" andTag:QJComposeToolbarButtonTypeEmotion];
    }
    return self;
}
/**
 *  添加工具栏按钮
 */
- (void)addToolBarButtonWithImageName:(NSString *)imageName andHighlightedImageName:(NSString *)highlightedImageName andTag:(QJComposeToolBarButtonType)tag {
    // 创建工具栏按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    btn.tag = tag;
    // 添加按钮
    [self addSubview:btn];
    // 添加事件
    [btn addTarget:self action:@selector(toolBarBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}
/**
 *  点击按钮触发事件
 */
- (void)toolBarBtnClicked:(UIButton *)btn {
    if (self.composeToolBarButtonClickedBlock) {
        self.composeToolBarButtonClickedBlock(btn);
    }
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置工具栏按钮frame
    int count = (int)self.subviews.count;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        btn.width = QJScreenW / count;
        btn.height = self.height;
        btn.y = 0;
        btn.x = i * btn.width;
    }
}

@end
