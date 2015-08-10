//
//  QJCommonCell.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/9.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJCommonCell.h"
#import "QJCommonItem.h"
#import "QJArrowItem.h"
#import "QJSwitchItem.h"
#import "QJLabelItem.h"
#import "QJBadgeView.h"

@interface QJCommonCell ()

/**
 *  cell右侧箭头
 */
@property (nonatomic, strong) UIImageView *rightArrow;
/**
 *  cell右侧开关
 */
@property (nonatomic, strong) UISwitch *rightSwitch;
/**
 *  cell右侧文本
 */
@property (nonatomic, strong) UILabel *rightLabel;
/**
 *  提醒View
 */
@property (nonatomic, strong) QJBadgeView *badgeView;


@end

@implementation QJCommonCell

#pragma mark - 懒加载右侧的View

-(UIImageView *)rightArrow {
    if (!_rightArrow) {
        _rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
    }
    return _rightArrow;
}

-(UISwitch *)rightSwitch {
    if (!_rightSwitch) {
        _rightSwitch = [[UISwitch alloc] init];
    }
    return _rightSwitch;
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.textColor = [UIColor lightGrayColor];
        _rightLabel.font = [UIFont systemFontOfSize:13];
    }
    return _rightLabel;
}

-(QJBadgeView *)badgeView {
    if (!_badgeView) {
        _badgeView = [[QJBadgeView alloc] init];
    }
    return _badgeView;
}

+(instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *cellID = @"common";
    QJCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[QJCommonCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 设置标题的字体
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        self.detailTextLabel.font = [UIFont systemFontOfSize:13];
        
        // 设置背景图
        self.backgroundView = [[UIImageView alloc] init];
        self.selectedBackgroundView = [[UIImageView alloc] init];
    }
    return self;
}

-(void)setItem:(QJCommonItem *)item {
    _item = item;
    
    self.imageView.image = [UIImage imageNamed:item.icon];
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subtitle;
    
    if (item.badgeValue) {
        self.badgeView.badgeValue = item.badgeValue;
        self.accessoryView = self.badgeView;
    } else if ([item isKindOfClass:[QJArrowItem class]]) {
        self.accessoryView = self.rightArrow;
    } else if ([item isKindOfClass:[QJSwitchItem class]]) {
        self.accessoryView = self.rightSwitch;
    } else if ([item isKindOfClass:[QJLabelItem class]]) {
        QJLabelItem *labelItem = (QJLabelItem *)item;
        self.rightLabel.text = labelItem.labelTitle;
        self.rightLabel.size = [self.rightLabel.text sizeWithAttributes:@{NSFontAttributeName : self.rightLabel.font}];
        self.accessoryView = self.rightLabel;
    } else {
        self.accessoryView = nil;
    }
}

-(void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(int)rows {
    // 1.取出背景view
    UIImageView *bgView = (UIImageView *)self.backgroundView;
    UIImageView *selectedBgView = (UIImageView *)self.selectedBackgroundView;
    
    // 2.设置背景图片
    if (rows == 1) {
        bgView.image = [UIImage resizedImage:@"common_card_background"];
        selectedBgView.image = [UIImage resizedImage:@"common_card_background_highlighted"];
    } else if (indexPath.row == 0) { // 首行
        bgView.image = [UIImage resizedImage:@"common_card_top_background"];
        selectedBgView.image = [UIImage resizedImage:@"common_card_top_background_highlighted"];
    } else if (indexPath.row == rows - 1) { // 末行
        bgView.image = [UIImage resizedImage:@"common_card_bottom_background"];
        selectedBgView.image = [UIImage resizedImage:@"common_card_bottom_background_highlighted"];
    } else { // 中间
        bgView.image = [UIImage resizedImage:@"common_card_middle_background"];
        selectedBgView.image = [UIImage resizedImage:@"common_card_middle_background_highlighted"];
    }
}

/**
 *  调整子控件的位置
 */
-(void)layoutSubviews {
    [super layoutSubviews];
    
    self.detailTextLabel.x = CGRectGetMaxX(self.textLabel.frame) + QJStatusCellInset;
}

@end
