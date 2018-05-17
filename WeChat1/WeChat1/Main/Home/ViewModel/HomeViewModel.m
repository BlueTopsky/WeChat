//
//  HomeViewModel.m
//  WeChat1
//
//  Created by Topsky on 2018/4/28.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "HomeViewModel.h"
#import "MessageItem.h"

@implementation HomeViewModel

- (NSMutableArray *)loadMessages {
    NSData *messagesData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Message" ofType:@"json"]]];
    NSDictionary *JSONDic = [NSJSONSerialization JSONObjectWithData:messagesData options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *muArray = [NSMutableArray array];
    for (NSDictionary *eachDic in JSONDic[@"messages"][@"row"]) {
        MessageItem *item = [[MessageItem alloc]initWithItem:eachDic];
        [muArray addObject:item];
    }
    return muArray;
}

@end
