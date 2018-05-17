//
//  DetailMsgViewModel.h
//  WeChat1
//
//  Created by Topsky on 2018/5/9.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "BaseViewModel.h"

@interface DetailMsgViewModel : BaseViewModel

//获取详细消息数据
- (NSMutableArray *)loadDetailMessages;

@end
