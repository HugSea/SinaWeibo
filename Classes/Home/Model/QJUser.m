//
//  QJUser.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/2.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJUser.h"

@implementation QJUser

-(BOOL)isVip {
    return self.mbrank > 2;
}

@end
