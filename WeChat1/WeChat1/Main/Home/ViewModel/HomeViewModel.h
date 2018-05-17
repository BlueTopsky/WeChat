//
//  HomeViewModel.h
//  WeChat1
//
//  Created by Topsky on 2018/4/28.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "BaseViewModel.h"

@interface HomeViewModel : BaseViewModel

//获取首页消息数据
- (NSMutableArray *)loadMessages;

@end
