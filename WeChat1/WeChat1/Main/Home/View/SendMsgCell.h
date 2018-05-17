//
//  SendMsgCell.h
//  WeChat1
//
//  Created by Topsky on 2018/5/9.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "BaseTableViewCell.h"

@class MessageItem;

@interface SendMsgCell : BaseTableViewCell

- (void)setContentMsg:(MessageItem *)msgItem;

@end
