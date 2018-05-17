//
//  CircleCell.m
//  WeChat1
//
//  Created by Topsky on 2018/5/11.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "CircleCell.h"
#import <TTTAttributedLabel.h>
#import <Masonry.h>
#import "CircleItem.h"
#import <UIColor+SKYExtension.h>
#import <UIImageView+WebCache.h>
#import "SectionHeaderView.h"

@interface CircleCell () <TTTAttributedLabelDelegate>

@property (nonatomic, strong) TTTAttributedLabel *commentLabel;

@end

@implementation CircleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setup {
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-SectionHeaderHorizontalSpace);
        make.left.equalTo(@(36 + SectionHeaderHorizontalSpace * 2));
    }];
    
    self.commentLabel = [TTTAttributedLabel new];
    self.commentLabel.numberOfLines = 0;
    self.commentLabel.lineSpacing = SectionHeaderLineSpace;
    self.commentLabel.font = [UIFont systemFontOfSize:15];
    self.commentLabel.delegate = self;
    [self.contentView addSubview:self.commentLabel];
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(3);
        make.bottom.equalTo(self.contentView).offset(-3);
        make.right.equalTo(self.contentView).offset(-SectionHeaderHorizontalSpace);
        make.left.equalTo(@(36 + SectionHeaderHorizontalSpace * 2 + 5));
    }];
    [self linkStyles];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)linkStyles {
    UIColor *linkColor = [UIColor colorWithRGB:@"54,71,121"];
    CTUnderlineStyle linkUnderLineStyle = kCTUnderlineStyleNone;
    UIColor *activeLinkColor = [UIColor colorWithRGB:@"54,71,121"];
    CTUnderlineStyle activelinkUnderLineStyle  = kCTUnderlineStyleNone;

    // 没有点击时候的样式
    self.commentLabel.linkAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],
                                         (NSString *)kCTForegroundColorAttributeName: linkColor,
                                        (NSString *)kCTUnderlineStyleAttributeName: [NSNumber numberWithInt:linkUnderLineStyle]};
    // 点击时候的样式
    self.commentLabel.activeLinkAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],
                                               (NSString *)kCTForegroundColorAttributeName: activeLinkColor,
                                               (NSString *)kTTTBackgroundFillColorAttributeName:[UIColor lightGrayColor],
                                        (NSString *)kCTUnderlineStyleAttributeName: [NSNumber numberWithInt:activelinkUnderLineStyle]};
}

- (void)setContentData:(CircleItem *)item index:(NSInteger)index{
    NSDictionary *dic = item.comments[index];
    NSString *text = nil;
    if ([dic valueForKey:@"comment_to_user_name"] == nil || [[dic valueForKey:@"comment_to_user_name"] length] <= 0 || [[dic valueForKey:@"comment_to_user_id"] integerValue] == item.user_id) {
        text = [NSString stringWithFormat:@"%@: %@", [dic valueForKey:@"comment_user_name"], [dic valueForKey:@"comment_text"]];
        self.commentLabel.text = text;
    } else {
        text = [NSString stringWithFormat:@"%@回复%@: %@", [dic valueForKey:@"comment_user_name"], [dic valueForKey:@"comment_to_user_name"], [dic valueForKey:@"comment_text"]];
        self.commentLabel.text = text;
    }
    
    //添加url
    NSRange boldRange0 = NSMakeRange(0, [[dic valueForKey:@"comment_user_name"] length]);
    NSRange boldRange1 = NSMakeRange([[dic valueForKey:@"comment_user_name"] length] + 2, [[dic valueForKey:@"comment_to_user_name"] length]);
    [self.commentLabel addLinkToTransitInformation:@{@"user_name":[dic valueForKey:@"comment_user_name"]} withRange:boldRange0];
    if ([dic valueForKey:@"comment_to_user_name"] == nil || [[dic valueForKey:@"comment_to_user_name"] length] <= 0 || [[dic valueForKey:@"comment_to_user_id"] integerValue] == item.user_id) {
        
    } else {
        [self.commentLabel addLinkToTransitInformation:@{@"user_name":[dic valueForKey:@"comment_to_user_name"]} withRange:boldRange1];
    }
}

#pragma mark - TTTAttributedLabelDelegate

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithTransitInformation:(NSDictionary *)components {
    if ([_delegate respondsToSelector:@selector(didSelectPeople:)]) {
        [_delegate didSelectPeople:components];
    }
}

@end
