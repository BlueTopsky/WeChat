//
//  CircleCell.h
//  WeChat1
//
//  Created by Topsky on 2018/5/11.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol CircleCellDelegate <NSObject>
@optional
- (void)didSelectPeople:(NSDictionary *)dic;

@end

@class CircleItem;

@interface CircleCell : BaseTableViewCell

@property (nonatomic, weak) id <CircleCellDelegate> delegate;
- (void)setContentData:(CircleItem *)item index:(NSInteger)index;

@end
