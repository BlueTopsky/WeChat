//
//  PeopleTableViewCell.h
//  WeChat1
//
//  Created by Topsky on 2018/5/2.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "BaseTableViewCell.h"

@class PeopleItem;

@interface PeopleTableViewCell : BaseTableViewCell

- (void)setPeopleContent:(PeopleItem *)peopleVO;

@end
