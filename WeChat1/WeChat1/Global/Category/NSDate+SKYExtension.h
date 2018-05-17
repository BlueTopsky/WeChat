//
//  NSDate+SKYExtension.h
//  TestDemo
//
//  Created by Topsky on 2018/4/23.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (SKYExtension)


/**
 NSString转NSDate

 @param string 2016-01-26 11:03:21
 @param format yyyy-MM-dd HH:mm:ss
 @return 2016-01-26 11:03:21 +0000
 */
+ (NSDate *)dateFromString:(NSString *)string format:(NSString *)format;

/**
 NSDate转NSString

 @param date 2016-01-26 03:03:21 +0000
 @param format yyyy-MM-dd HH:mm:ss
 @return 2016-01-26 11:03:21
 */
+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format;

/**
 转换成当地时间，解决时差问题

 @param date 2016-01-26 03:03:21 +0000
 @return 2016-01-26 11:03:21 +0000
 */
+ (NSDate *)transformToLocalDate:(NSDate *)date;

/**
 将毫秒数转换为年月日时分秒的时间

 @param time 1439348978000
 @param format yyyy-MM-dd HH:mm:ss
 @return yyyy-MM-dd HH:mm:ss
 */
+ (NSString *)transformMillisecondToTime:(long long)time format:(NSString *)format;

@end
