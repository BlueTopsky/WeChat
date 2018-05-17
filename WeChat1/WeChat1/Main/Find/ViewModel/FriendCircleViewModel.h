//
//  FriendCircleViewModel.h
//  WeChat1
//
//  Created by Topsky on 2018/5/11.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "BaseViewModel.h"
#import <UIKit/UIKit.h>

@class CircleItem;

@interface FriendCircleViewModel : BaseViewModel

- (NSMutableArray *)loadDatas;
- (CGFloat)getHeaderHeight:(CircleItem *)item;
- (void)calculateItemHeight:(CircleItem *)item;

@end
