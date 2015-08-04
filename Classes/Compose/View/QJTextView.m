//
//  QJTextView.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/3.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJTextView.h"

@interface QJTextView ()

@property (nonatomic, weak) UILabel *placehoderLabel;

@end

@implementation QJTextView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 设置textView可以垂直滚动
        self.alwaysBounceVertical = YES;
        // 创建占位文字label
        UILabel *placehoderLabel = [[UILabel alloc] init];
        [self addSubview:placehoderLabel];
        // 设置占位文字label属性
        placehoderLabel.backgroundColor = [UIColor clearColor];
        placehoderLabel.font = [UIFont systemFontOfSize:15];
        placehoderLabel.textColor = [UIColor lightGrayColor];
        placehoderLabel.numberOfLines = 0;
        self.placehoderLabel = placehoderLabel;
        
        // 监听输入文本
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}
/**
 *  创建消息中心就需要释放
 */
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/**
 *  输入文本发生改变时调用
 */
- (void)textChange {
    self.placehoderLabel.hidden = (self.text.length != 0);
}
/**
 *  设置占位文字
 */
-(void)setPlacehoder:(NSString *)placehoder {
    _placehoder = [placehoder copy];
    self.placehoderLabel.text = _placehoder;
}

-(void)setFont:(UIFont *)font {
    [super setFont:font];
    
    self.placehoderLabel.font = font;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    self.placehoderLabel.x = 5;
    self.placehoderLabel.y = 8;
    self.placehoderLabel.width = screenW - self.placehoderLabel.x * 2;
    CGSize maxSize = CGSizeMake(self.placehoderLabel.width, MAXFLOAT);
    CGRect placehoderRect = [self.placehoderLabel.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.placehoderLabel.font} context:nil];
    self.placehoderLabel.height = placehoderRect.size.height;
}

@end
