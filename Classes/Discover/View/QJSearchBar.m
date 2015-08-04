//
//  QJSearchBar.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/1.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJSearchBar.h"

@implementation QJSearchBar

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 设置背景图片
        [self setBackground:[UIImage resizedImage:@"searchbar_textfield_background"]];
        // 设置SearchBar左视图
        UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        leftView.width = leftView.image.size.width + 10;
        leftView.height = leftView.width;
        leftView.contentMode = UIViewContentModeCenter;
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        // 设置内容居中
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        // 设置字体大小
        self.font = [UIFont systemFontOfSize:13];
        // 设置清除样式
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return self;
}

+(instancetype)searchBar {
    return [[self alloc] init];
}

@end
