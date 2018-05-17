//
//  UIColor+SKYExtension.h
//  123
//
//  Created by Topsky on 2018/4/17.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SKYExtension)


/**
 从十六进制字符串获取颜色

 @param color 支持@"#123456"、 @"0X123456"、@"0x123456"、 @"123456"四种格式
 @return UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)color;

/**
 从十六进制字符串获取颜色

 @param color 支持@"#123456"、 @"0X123456"、@"0x123456"、 @"123456"四种格式
 @param alpha 透明度
 @return UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

/**
 根据RGB生成颜色
 
 @param rgb @"51,51,51"
 @return UIColor
 */
+ (UIColor *)colorWithRGB:(NSString *)rgb;

/**
 根据RGB生成颜色

 @param rgba @"51,51,51,0.5"
 @return UIColor
 */
+ (UIColor *)colorWithRGBA:(NSString *)rgba;

/**
 生成随机色

 @return UIColor
 */
+ (UIColor *)randomColor;

@end
