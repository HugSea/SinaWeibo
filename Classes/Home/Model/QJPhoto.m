//
//  QJPhoto.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/2.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJPhoto.h"

@implementation QJPhoto

-(void)setThumbnail_pic:(NSString *)thumbnail_pic {
    _thumbnail_pic = thumbnail_pic;
    
    self.bmiddle_pic = [thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
}

@end
