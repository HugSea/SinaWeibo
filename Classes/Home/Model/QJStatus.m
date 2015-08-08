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
#import "NSDate+Extension.h"

@implementation QJStatus

-(NSDictionary *)objectClassInArray {
    return @{@"pic_urls" : [QJPhoto class]};
}

/**
 一、今年
 1、今天
 1分钟内：刚刚
 1个小时内：xx分钟前
 
 2、昨天
 昨天 xx:xx
 
 3、至少是前天发的
 04-23 xx:xx
 
 二、非今年
 2012-07-24
 */
//    _created_at = @"Sat Aug 08 16:04:01 +0800 2015";
-(NSString *)created_at {
    NSDateFormatter *dfm = [[NSDateFormatter alloc] init];
    [dfm setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
    //必须设置，否则无法解析
    dfm.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *createDate = [dfm dateFromString:_created_at];
    
    // 判断是否为今年
    if (createDate.isThisYear) {
        if (createDate.isToday) {
            // 今天
            NSDateComponents *component = [createDate deltaWithNow];
            if (component.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前", component.hour];
            } else if (component.minute >= 1) {
                return [NSString stringWithFormat:@"%ld分钟前", component.minute];
            } else {
                return @"刚刚";
            }
        } else if (createDate.isYesterday) {
            // 昨天
            dfm.dateFormat = @"昨天 HH:mm";
            return [dfm stringFromDate:createDate];
        } else {
            // 前天以前
            dfm.dateFormat = @"MM-dd HH:mm";
            return [dfm stringFromDate:createDate];
        }
    } else {
        // 非今年
        dfm.dateFormat = @"yyyy-MM-dd";
        return [dfm stringFromDate:createDate];
    }
}

-(void)setSource:(NSString *)source {
    _source = source;
    if ([source isEqualToString:@""]) return ;
    // 截取范围
    NSRange range = {0,0};
    range.location = [source rangeOfString:@">"].location + 1;
    range.length = [source rangeOfString:@"</"].location - range.location;
    NSString *sourcee = [source substringWithRange:range];
    
    _source = [NSString stringWithFormat:@"来自 %@", sourcee];
}

@end











