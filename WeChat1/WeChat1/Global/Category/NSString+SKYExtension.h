//
//  NSString+SKYExtension.h
//  TestDemo
//
//  Created by Topsky on 2018/4/24.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (SKYExtension)

- (CGSize)contentSizeWithWidth:(CGFloat)width
                          font:(UIFont *)font
                   lineSpacing:(CGFloat)lineSpacing;
//是否只有一行
- (BOOL)contentHaveOneLinesWithWidth:(CGFloat)width
                                font:(UIFont *)font
                         lineSpacing:(CGFloat)lineSpacing;

@end
