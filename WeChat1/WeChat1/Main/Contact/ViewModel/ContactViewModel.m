//
//  ContactViewModel.m
//  WeChat1
//
//  Created by Topsky on 2018/5/2.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "ContactViewModel.h"
#import "PeopleItem.h"

@implementation ContactViewModel

- (NSMutableArray *)handleLettersArray:(NSMutableArray *)muArray {
    [muArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        //类型转换
        PeopleItem *p1 = (PeopleItem *)obj1;
        PeopleItem *p2 = (PeopleItem *)obj2;
        return [p1.fullPinyin.uppercaseString compare:p2.fullPinyin.uppercaseString];
    }];
    NSMutableArray *groupMuArray = [NSMutableArray array];
    NSMutableArray *tempArray = [NSMutableArray array];
    NSMutableArray *specialMuArray = [NSMutableArray array];
    NSString *firstChar = nil;
    for (PeopleItem *item in muArray) {
        NSString *peopleFirstChar = [[item.fullPinyin substringToIndex:1] uppercaseString];
        if ([peopleFirstChar characterAtIndex:0] < 'A' || [peopleFirstChar characterAtIndex:0] > 'Z') {
            [specialMuArray addObject:item];
        } else {
            if (!firstChar) {
                firstChar = peopleFirstChar;
                [tempArray addObject:item];
            }else if ([firstChar isEqualToString:peopleFirstChar]) {
                [tempArray addObject:item];
            }else {
                NSDictionary *dic = [NSDictionary dictionaryWithObject:[tempArray copy] forKey:[firstChar copy]];
                [groupMuArray addObject:dic];
                
                [tempArray removeAllObjects];
                firstChar = peopleFirstChar;
                [tempArray addObject:item];
            }
        }
    }
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[tempArray copy] forKey:[firstChar copy]];
    [groupMuArray addObject:dic];
    if (specialMuArray.count > 0) {
        NSDictionary *specialDic = [NSDictionary dictionaryWithObject:[specialMuArray copy] forKey:@"#"];
        [groupMuArray addObject:specialDic];
    }
    return groupMuArray;
}

- (BOOL)containChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}

@end
