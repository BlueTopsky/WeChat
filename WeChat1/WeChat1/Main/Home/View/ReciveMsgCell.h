//
//  ReciveMsgCell.h
//  WeChat1
//
//  Created by Topsky on 2018/5/9.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "BaseTableViewCell.h"

@class MessageItem;

@interface ReciveMsgCell : BaseTableViewCell

- (void)setContentMsg:(MessageItem *)msgItem;
- (void)setHeadImg:(NSString *)imgUrlStr;

@end
