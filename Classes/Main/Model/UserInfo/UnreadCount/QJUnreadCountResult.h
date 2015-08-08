//
//  QJUnreadCountResult.h
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/5.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QJUnreadCountResult : NSObject

/**	int	新微博未读数 */
@property (nonatomic, assign) int status;
/**	int	新粉丝数 */
@property (nonatomic, assign) int follower;
/**	int	新评论数 */
@property (nonatomic, assign) int cmt;
/**	int	新私信数 */
@property (nonatomic, assign) int dm;
/**	int	新提及我的微博数 */
@property (nonatomic, assign) int mention_status;
/**	int	新提及我的评论数 */
@property (nonatomic, assign) int mention_cmt;

- (int)unreadMessageCount;

- (int)unreadMineCount;

- (int)totalCount;

@end
