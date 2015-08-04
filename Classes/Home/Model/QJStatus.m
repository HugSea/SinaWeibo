//
//  QJStatus.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/2.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJStatus.h"
#import "QJPhoto.h"
#import "MJExtension.h"

@implementation QJStatus

-(NSDictionary *)objectClassInArray {
    return @{@"pic_urls" : [QJPhoto class]};
}

@end
