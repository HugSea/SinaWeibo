//
//  QJStatusDetailView.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/5.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJStatusDetailView.h"
#import "QJStatusOriginalView.h"
#import "QJStatusRetweetedView.h"
#import "QJStatusDetailFrame.h"

@interface QJStatusDetailView ()

@property (nonatomic, weak) QJStatusOriginalView *originalView;
@property (nonatomic, weak) QJStatusRetweetedView *retweetedView;

@end

@implementation QJStatusDetailView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 设置背景颜色
        self.backgroundColor = [UIColor clearColor];
        
        // 添加原创微博
        QJStatusOriginalView *originalView = [[QJStatusOriginalView alloc] init];
        [self addSubview:originalView];
        self.originalView = originalView;
        
        // 添加转发微博
        QJStatusRetweetedView *retweetedView = [[QJStatusRetweetedView alloc] init];
        [self addSubview:retweetedView];
        self.retweetedView = retweetedView;
    }
    return self;
}

-(void)setDetailFrame:(QJStatusDetailFrame *)detailFrame {
    _detailFrame = detailFrame;
    
    self.frame = detailFrame.frame;
    
    // 设置原创微博Frame
    self.originalView.originalFrame = detailFrame.originalFrame;
    
    // 设置转发微博Frame
    self.retweetedView.retweetedFrame = detailFrame.retweetedFrame;
}

@end
