//
//  QJStatusCell.h
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/5.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QJStatusFrame;

@interface QJStatusCell : UITableViewCell

@property (nonatomic, strong) QJStatusFrame *statusFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
