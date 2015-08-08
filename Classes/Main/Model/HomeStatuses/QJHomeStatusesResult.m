//
//  QJHomeStatusesResult.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/4.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJHomeStatusesResult.h"
#import "MJExtension.h"
#import "QJStatus.h"

@implementation QJHomeStatusesResult

- (NSDictionary *)objectClassInArray {
    return @{@"statuses" : [QJStatus class]};
}

@end
