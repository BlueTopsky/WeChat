//
//  MessageCell.h
//  WeChat1
//
//  Created by Topsky on 2018/4/28.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "BaseTableViewCell.h"

@class MessageItem;

@interface MessageCell : BaseTableViewCell

- (void)setMessageContent:(MessageItem *)item;

@end
