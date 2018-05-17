//
//  SKYStringManager.h
//  WeChat1
//
//  Created by Topsky on 2018/5/14.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SKYStringManager : NSObject

@property (nonatomic, strong) UILabel *label;

+ (instancetype)sharedInstance;

@end
