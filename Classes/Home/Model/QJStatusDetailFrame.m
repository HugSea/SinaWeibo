//
//  QJStatusDetailFrame.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/6.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJStatusDetailFrame.h"
#import "QJStatusOriginalFrame.h"
#import "QJStatusRetweetedFrame.h"
#import "QJStatus.h"

@implementation QJStatusDetailFrame

-(void)setStatus:(QJStatus *)status {
    
    _status = status;
    
    // 计算原创微博Frame
    self.originalFrame = [[QJStatusOriginalFrame alloc] init];
    self.originalFrame.status = self.status;
    
    // 计算转发微博Frame
    CGFloat h = 0;
    if (status.retweeted_status) {
        self.retweetedFrame = [[QJStatusRetweetedFrame alloc] init];
        self.retweetedFrame.retweetedStatus = status.retweeted_status;
        
        CGRect f = self.retweetedFrame.frame;
        f.origin.y = CGRectGetMaxY(self.originalFrame.frame);
        self.retweetedFrame.frame = f;
        
        h = CGRectGetMaxY(self.retweetedFrame.frame);
    } else {
        h = CGRectGetMaxY(self.originalFrame.frame);
    }
    
    // 计算自己的Frame
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = QJScreenW;
    self.frame = CGRectMake(x, y, w, h);
}

@end
