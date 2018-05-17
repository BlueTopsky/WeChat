//
//  MeCell.h
//  WeChat1
//
//  Created by Topsky on 2018/5/10.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "BaseTableViewCell.h"

extern NSString *const MeCellImageName;
extern NSString *const MeCellMainStr;
extern NSString *const MeCellAccountIdStr;

@interface MeCell : BaseTableViewCell

- (void)setContentData:(NSDictionary *)dic;

@end
