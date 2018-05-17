//
//  PeopleItem.h
//  WeChat1
//
//  Created by Topsky on 2018/5/2.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "BaseItem.h"

@interface PeopleItem : BaseItem

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *phoneNO;
@property (nonatomic, copy) NSString *fullPinyin;

@end
