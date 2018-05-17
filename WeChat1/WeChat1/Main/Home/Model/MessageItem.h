//
//  MessageItem.h
//  WeChat1
//
//  Created by Topsky on 2018/4/28.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "BaseItem.h"

@interface MessageItem : BaseItem

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) BOOL isSilent;
@property (nonatomic, assign) long long createDate;

@end
