//
//  NSDate+SKYExtension.m
//  TestDemo
//
//  Created by Topsky on 2018/4/23.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "NSDate+SKYExtension.h"

@implementation NSDate (SKYExtension)

+ (NSDate *)dateFromString:(NSString *)string format:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:string];
    return date;
}

+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+ (NSDate *)transformToLocalDate:(NSDate *)date {
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localDate = [date dateByAddingTimeInterval:interval];
    return localDate;
}

+ (NSString *)transformMillisecondToTime:(long long)time format:(NSString *)format {
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    NSString *timeString = [formatter stringFromDate:d];
    return timeString;
}

@end
