//
//  FriendCircleViewModel.m
//  WeChat1
//
//  Created by Topsky on 2018/5/11.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "FriendCircleViewModel.h"
#import "CircleItem.h"
#import "SectionHeaderView.h"
#import "PublicDef.h"
#import "SKYStringManager.h"
#import "NSString+SKYExtension.h"
#import "LikeUserCell.h"
#import <UIKit/UIKit.h>

@implementation FriendCircleViewModel

- (NSMutableArray *)loadDatas {
    NSData *messagesData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"]]];
    NSDictionary *JSONDic = [NSJSONSerialization JSONObjectWithData:messagesData options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *muArray = [NSMutableArray array];
    for (NSDictionary *eachDic in JSONDic[@"data"][@"rows"]) {
        CircleItem *item = [[CircleItem alloc]initWithItem:eachDic];
        item.nameLabelHeight = SectionHeaderNameLabelHeight;
        item.contentLabelHeight = [self calculateStringHeight:item.message];
        item.imgBgViewHeight = [self getImgBgViewHeight:item];
        [self calculateItemHeight:item];
        [muArray addObject:item];
    }
    return muArray;
}

- (void)calculateItemHeight:(CircleItem *)item {
    if (item.contentLabelHeight == 0) {
        item.headerHeight = SectionHeaderTopSpace + SectionHeaderVerticalSpace + SectionHeaderBottomSpace + item.nameLabelHeight + item.imgBgViewHeight + SectionHeaderTimeLabelHeight;
    } else if (item.contentLabelHeight <= SectionHeaderMaxContentHeight){
        item.headerHeight = SectionHeaderTopSpace + SectionHeaderVerticalSpace * 2 + SectionHeaderBottomSpace + item.nameLabelHeight + item.contentLabelHeight + item.imgBgViewHeight + SectionHeaderTimeLabelHeight;
    } else {
        item.headerHeight = [self getHeaderHeight:item];
    }
    item.likerHeight = [self calculateLikeUserCellHeight:item];
    item.commentHeightArr = [self calculateCellHeight:item];
    if (item.comments.count <= 0 && item.like_users.count <= 0) {
        item.footerHeight = 12 - SectionHeaderBottomSpace - 2;
    } else {
        item.footerHeight = 12;
    }
}

- (CGFloat)calculateLikeUserCellHeight:(CircleItem *)item {
    NSArray *likeUserArr = item.like_users;
    if (item.like_users.count <= 0) {
        return 0;
    }
    NSString *str = [prefixStr copy];
    for (int i = 0; i < likeUserArr.count; i++) {
        NSString *userName = [likeUserArr[i] valueForKey:@"userName"];
        str = [str stringByAppendingString:userName];
        if (i != likeUserArr.count - 1) {
            str = [str stringByAppendingString:@", "];
        }
    }
    return ceil([str contentSizeWithWidth:SCREEN_MIN_LENGTH - (36 + SectionHeaderHorizontalSpace * 2 + 5) - SectionHeaderHorizontalSpace font:[UIFont systemFontOfSize:15] lineSpacing:SectionHeaderLineSpace].height) + 6;
}

- (CGFloat)calculateStringHeight:(NSString *)text {
    return ceil([text contentSizeWithWidth:SCREEN_MIN_LENGTH - SectionHeaderHorizontalSpace * 3 - 36 font:[UIFont systemFontOfSize:SectionHeaderBigFontSize] lineSpacing:SectionHeaderLineSpace].height);
}

- (NSMutableArray *)calculateCellHeight:(CircleItem *)item {
    NSMutableArray *muArr = [NSMutableArray array];
    for (NSDictionary *dic in item.comments) {
        NSString *text = nil;
        if ([dic valueForKey:@"comment_to_user_name"] == nil || [[dic valueForKey:@"comment_to_user_name"] length] <= 0 || [[dic valueForKey:@"comment_to_user_id"] integerValue] == item.user_id) {
            text = [NSString stringWithFormat:@"%@: %@", [dic valueForKey:@"comment_user_name"], [dic valueForKey:@"comment_text"]];
        } else {
            text = [NSString stringWithFormat:@"%@回复%@: %@", [dic valueForKey:@"comment_user_name"], [dic valueForKey:@"comment_to_user_name"], [dic valueForKey:@"comment_text"]];
        }
        CGFloat height = ceil([text contentSizeWithWidth:SCREEN_MIN_LENGTH - (36 + SectionHeaderHorizontalSpace * 2 + 5) - SectionHeaderHorizontalSpace font:[UIFont systemFontOfSize:15] lineSpacing:SectionHeaderLineSpace].height) + 6;
        [muArr addObject:@(height)];
    }
    return muArr;
}

- (CGFloat)getImgBgViewHeight:(CircleItem *)item {
    switch (item.small_pics.count) {
        case 0:
            return 0;
        case 1:
            return SectionHeaderOnePictureHeight + SectionHeaderVerticalSpace;
        case 2:
            
        case 3:
            return SectionHeaderSomePicturesHeight + SectionHeaderVerticalSpace;
        case 4:
            
        case 5:
            
        case 6:
            return SectionHeaderSomePicturesHeight * 2 + SectionHeaderPictureSpace + SectionHeaderVerticalSpace;
        case 7:
            
        case 8:
            
        case 9:
            return SectionHeaderSomePicturesHeight * 3 + SectionHeaderPictureSpace * 2 + SectionHeaderVerticalSpace;
        default:
            return 0;
    }
}

- (CGFloat)getHeaderHeight:(CircleItem *)item {
    CGFloat height = 0;
    if (item.isSpread) {
        height = SectionHeaderTopSpace + SectionHeaderVerticalSpace * 3 + SectionHeaderBottomSpace + item.nameLabelHeight + item.contentLabelHeight + item.imgBgViewHeight + SectionHeaderTimeLabelHeight + SectionHeaderMoreBtnHeight;
    } else {
        height = SectionHeaderTopSpace + SectionHeaderVerticalSpace * 3 + SectionHeaderBottomSpace + item.nameLabelHeight + SectionHeaderMaxContentHeight + item.imgBgViewHeight + SectionHeaderTimeLabelHeight + SectionHeaderMoreBtnHeight;
    }
    return height;
}

@end
