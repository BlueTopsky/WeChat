//
//  UIColor+SKYExtension.m
//  123
//
//  Created by Topsky on 2018/4/17.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "UIColor+SKYExtension.h"

#define LS_MID(x, y, z)    ( y < x ? x : (z < y ? z : y) )

@implementation UIColor (SKYExtension)

+ (UIColor *)colorWithHexString:(NSString *)color {
    return [self colorWithHexString:color alpha:1.0];
}

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha {
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"]||[cString hasPrefix:@"0x"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

+ (UIColor *)colorWithRGB:(NSString *)rgb {
    NSString *rgba = [NSString stringWithFormat:@"%@,1.0", rgb];
    return [[self class] colorWithRGBA:rgba];
}

+ (UIColor *)colorWithRGBA:(NSString *)rgba {
    NSArray *list = [rgba componentsSeparatedByString:@","];
    if (list.count != 4) {
        return [UIColor clearColor];
    }
    NSInteger r = [list[0] integerValue];
    NSInteger g = [list[1] integerValue];
    NSInteger b = [list[2] integerValue];
    CGFloat a = [list[3] floatValue];
    
    return [[self class] p_colorWithR:r g:g b:b a:a];
}

+ (UIColor *)p_colorWithR:(NSInteger)r g:(NSInteger)g b:(NSInteger)b a:(CGFloat)a {
    r = LS_MID(0, r, 255);
    g = LS_MID(0, g, 255);
    b = LS_MID(0, b, 255);
    a = LS_MID(0, a, 1.0);
    
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:a];
}

+ (UIColor *)randomColor {
    NSInteger r = (arc4random() % 256);
    NSInteger g = (arc4random() % 256);
    NSInteger b = (arc4random() % 256);
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1];
}

@end

