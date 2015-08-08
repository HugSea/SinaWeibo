//
//  QJUnreadCountResult.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/5.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJUnreadCountResult.h"

@implementation QJUnreadCountResult

-(int)unreadMessageCount {
    return self.follower + self.cmt + self.dm;
}

-(int)unreadMineCount {
    return self.mention_cmt + self.mention_status;
}

- (int)totalCount {
    return self.status + self.unreadMessageCount + self.unreadMineCount;
}

@end
