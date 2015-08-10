//
//  QJCommonCell.h
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/9.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QJCommonItem;

@interface QJCommonCell : UITableViewCell

@property (nonatomic, strong) QJCommonItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(int)rows;

@end
