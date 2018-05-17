//
//  SKYContactManager.m
//  WeChat1
//
//  Created by Topsky on 2018/5/8.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "SKYContactManager.h"
#import "PeopleItem.h"

static SKYContactManager *_instance = nil;

@interface SKYContactManager ()

@property (nonatomic, strong) NSMutableArray *allPeoplesMuArr;

@end

@implementation SKYContactManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[SKYContactManager alloc] init];
    });
    return _instance;
}

- (void)loadAllPeoples {
    @synchronized(self) {
        NSData *messagesData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"AddressBook" ofType:@"json"]]];
        NSDictionary *JSONDic = [NSJSONSerialization JSONObjectWithData:messagesData options:NSJSONReadingAllowFragments error:nil];
        NSMutableArray *muArray = [NSMutableArray array];
        for (NSDictionary *eachDic in JSONDic[@"friends"][@"row"]) {
            PeopleItem *item = [[PeopleItem alloc] initWithItem:eachDic];
            item.fullPinyin = [self pinyinWithString:item.userName];
            [muArray addObject:item];
        }
        self.allPeoplesMuArr = muArray;
    }
}

- (NSMutableArray *)getAllPeoples {
    if (self.allPeoplesMuArr == nil) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self loadAllPeoples];
        });
        return nil;
    } else {
        return self.allPeoplesMuArr;
    }
}

- (NSString *)pinyinWithString:(NSString *)str {
    if ([str containsString:@"沈"]) {
        return @"shen";
    } else if ([str containsString:@"曾"]) {
        return @"zeng";
    } else if ([str containsString:@"解"]) {
        return @"xie";
    } else if ([str containsString:@"仇"]) {
        return @"qiu";
    } else if ([str containsString:@"朴"]) {
        return @"piao";
    } else if ([str containsString:@"查"]) {
        return @"zha";
    } else if ([str containsString:@"区"]) {
        return @"ou";
    } else if ([str containsString:@"乐"]) {
        return @"yue";
    } else if ([str containsString:@"单"]) {
        return @"shan";
    } else if ([str containsString:@"黑"]) {
        return @"he";
    } else if ([str containsString:@"尉"]) {
        return @"yu";
    } else if ([str containsString:@"重"]) {
        return @"chong";
    } else if ([str containsString:@"秘"]) {
        return @"bi";
    } else if ([str containsString:@"翟"]) {
        return @"zhai";
    } else if ([str containsString:@"折"]) {
        return @"she";
    }
    NSMutableString *ms = [[NSMutableString alloc] initWithString:str];
    //带音标的拼音
    if (CFStringTransform((__bridge CFMutableStringRef) ms, 0, kCFStringTransformMandarinLatin, NO)) {
        //        NSLog(@"Pingying: %@", ms); // wǒ shì zhōng guó rén
    }
    //不带音标的拼音
    if (CFStringTransform((__bridge CFMutableStringRef) ms, 0, kCFStringTransformStripDiacritics, NO)) {
        //        NSLog(@"Pingying: %@", ms); // wo shi zhong guo ren
        return ms;
    }
    return @"";
}

@end
