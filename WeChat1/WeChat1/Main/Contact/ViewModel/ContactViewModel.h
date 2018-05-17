//
//  ContactViewModel.h
//  WeChat1
//
//  Created by Topsky on 2018/5/2.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "BaseViewModel.h"

@interface ContactViewModel : BaseViewModel

//处理letterArray，包括按英文字母顺序排序
- (NSMutableArray *)handleLettersArray:(NSMutableArray *)muArray;

//判断是否包含中文
- (BOOL)containChinese:(NSString *)str;

@end
