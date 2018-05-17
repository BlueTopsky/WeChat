//
//  LikeUserCell.h
//  WeChat1
//
//  Created by Topsky on 2018/5/16.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol LikeUserCellDelegate <NSObject>
@optional
- (void)didSelectPeople:(NSDictionary *)dic;

@end

extern NSString *const prefixStr;

@class CircleItem;
@interface LikeUserCell : BaseTableViewCell

@property (nonatomic, weak) id <LikeUserCellDelegate> delegate;
- (void)setContentData:(CircleItem *)item;

@end
