//
//  BaseItem.m
//  WeChat1
//
//  Created by Topsky on 2018/4/28.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "BaseItem.h"
#import <MJExtension.h>

@implementation BaseItem

- (instancetype)initWithItem:(id)item {
    return [[self class] mj_objectWithKeyValues:item];
}

@end
