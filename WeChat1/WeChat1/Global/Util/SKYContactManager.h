//
//  SKYContactManager.h
//  WeChat1
//
//  Created by Topsky on 2018/5/8.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKYContactManager : NSObject

+ (instancetype)sharedInstance;

- (NSMutableArray *)getAllPeoples; //获取联系人

- (NSString *)pinyinWithString:(NSString *)str; //汉字转拼音

@end
