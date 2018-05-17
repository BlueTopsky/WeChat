//
//  FindCell.h
//  WeChat1
//
//  Created by Topsky on 2018/5/10.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "BaseTableViewCell.h"

extern NSString *const FindCellImageName;
extern NSString *const FindCellContentStr;

@interface FindCell : BaseTableViewCell

- (void)setContentData:(NSDictionary *)dic;

@end
