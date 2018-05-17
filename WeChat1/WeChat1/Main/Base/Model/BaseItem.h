//
//  BaseItem.h
//  WeChat1
//
//  Created by Topsky on 2018/4/28.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseItem : NSObject

/**
 通过字典来创建一个模型

 @param item 字典(可以是NSDictionary、NSData、NSString)
 @return 新建的对象
 */
- (instancetype)initWithItem:(id)item;

@end
