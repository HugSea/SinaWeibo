//
//  QJCommonItem.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/9.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJCommonItem.h"

@implementation QJCommonItem

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon {
    QJCommonItem *item = [[self alloc] init];
    item.title = title;
    item.icon = icon;
    return item;
}

+(instancetype)itemWithTitle:(NSString *)title {
    return [self itemWithTitle:title icon:nil];
}

@end
