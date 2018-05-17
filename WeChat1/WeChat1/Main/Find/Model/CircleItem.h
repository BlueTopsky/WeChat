//
//  CircleItem.h
//  WeChat1
//
//  Created by Topsky on 2018/5/11.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "BaseItem.h"
#import <UIKit/UIKit.h>

@interface CircleItem : BaseItem

@property (nonatomic, copy) NSString *message_id;
@property (nonatomic, assign) NSInteger user_id;
@property (nonatomic, copy) NSString *user_name;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *time_str;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSArray *small_pics;
@property (nonatomic, copy) NSArray *big_pics;
@property (nonatomic, copy) NSArray *like_users;
@property (nonatomic, copy) NSArray *comments;
@property (nonatomic, strong) NSMutableArray *commentHeightArr;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat nameLabelHeight;
@property (nonatomic, assign) CGFloat contentLabelHeight;
@property (nonatomic, assign) CGFloat imgBgViewHeight;
@property (nonatomic, assign) CGFloat footerHeight;
@property (nonatomic, assign) CGFloat likerHeight;
@property (nonatomic, assign) BOOL isSpread; //全文是否展开

@end
