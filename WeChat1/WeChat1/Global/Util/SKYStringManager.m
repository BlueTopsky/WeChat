//
//  SKYStringManager.m
//  WeChat1
//
//  Created by Topsky on 2018/5/14.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "SKYStringManager.h"

static SKYStringManager *_instance = nil;

@implementation SKYStringManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[SKYStringManager alloc] init];
        [_instance initParams];
    });
    return _instance;
}

- (void)initParams {
    self.label = [UILabel new];
}

@end
