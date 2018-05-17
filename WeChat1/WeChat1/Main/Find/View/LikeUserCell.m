//
//  LikeUserCell.m
//  WeChat1
//
//  Created by Topsky on 2018/5/16.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "LikeUserCell.h"
#import <TTTAttributedLabel.h>
#import <Masonry.h>
#import "CircleItem.h"
#import <UIColor+SKYExtension.h>
#import "SectionHeaderView.h"

NSString *const prefixStr = @"       ";

@interface LikeUserCell () <TTTAttributedLabelDelegate>

@property (nonatomic, strong) TTTAttributedLabel *likerLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) NSMutableArray *links;

@end

@implementation LikeUserCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setup {
    self.links = [NSMutableArray array];
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-SectionHeaderHorizontalSpace);
        make.left.equalTo(@(36 + SectionHeaderHorizontalSpace * 2));
    }];

    UIFont *font = [UIFont systemFontOfSize:15];
    self.likerLabel = [TTTAttributedLabel new];
    self.likerLabel.font = font;
    self.likerLabel.numberOfLines = 0;
    self.likerLabel.lineSpacing = SectionHeaderLineSpace;
    self.likerLabel.delegate = self;
    [self.contentView addSubview:self.likerLabel];
    [self.likerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@3);
        make.bottom.equalTo(@(-3));
        make.right.equalTo(self.contentView).offset(-SectionHeaderHorizontalSpace);
        make.left.equalTo(@(36 + SectionHeaderHorizontalSpace * 2 + 5));
    }];
    
    self.lineView = [UIView new];
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"#999999" alpha:0.5];
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(bgView);
        make.height.equalTo(@0.3);
    }];
    
    UIImageView *likeImgV = [UIImageView new];
    likeImgV.image =[UIImage imageNamed:@"Like"];
    [self.contentView addSubview:likeImgV];
    [likeImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(9);
        make.width.height.equalTo(@(font.lineHeight));
        make.top.equalTo(@3);
    }];
    [self linkStyles];
}

- (void)linkStyles {
    UIColor *linkColor = [UIColor colorWithRGB:@"54,71,121"];
    CTUnderlineStyle linkUnderLineStyle = kCTUnderlineStyleNone;
    UIColor *activeLinkColor = [UIColor colorWithRGB:@"54,71,121"];
    CTUnderlineStyle activelinkUnderLineStyle  = kCTUnderlineStyleNone;
    
    // 没有点击时候的样式
    self.likerLabel.linkAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],
                                         (NSString *)kCTForegroundColorAttributeName: linkColor,
                                         (NSString *)kCTUnderlineStyleAttributeName: [NSNumber numberWithInt:linkUnderLineStyle]};
    // 点击时候的样式
    self.likerLabel.activeLinkAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],
                                               (NSString *)kCTForegroundColorAttributeName: activeLinkColor,
                                               (NSString *)kTTTBackgroundFillColorAttributeName:[UIColor lightGrayColor],
                                               (NSString *)kCTUnderlineStyleAttributeName: [NSNumber numberWithInt:activelinkUnderLineStyle]};
}

- (void)setContentData:(CircleItem *)item {
    NSArray *likeUserArr = item.like_users;
    [self.links removeAllObjects];
    NSString *str = [prefixStr copy];
    for (int i = 0; i < likeUserArr.count; i++) {
        NSString *userName = [likeUserArr[i] valueForKey:@"userName"];
        [self.links addObject:@{@"loc": @(str.length), @"length": @(userName.length), @"userName": userName}];
        str = [str stringByAppendingString:userName];
        if (i != likeUserArr.count - 1) {
            str = [str stringByAppendingString:@", "];
        }
    }
    self.likerLabel.text = str;
    for (NSDictionary *dic in self.links) {
        NSRange range = NSMakeRange([[dic valueForKey:@"loc"] integerValue], [[dic valueForKey:@"length"] integerValue]);
        [self.likerLabel addLinkToTransitInformation:@{@"user_name":[dic valueForKey:@"userName"]} withRange:range];
    }
    if (item.comments.count <= 0) {
        self.lineView.hidden = YES;
    } else {
        self.lineView.hidden = NO;
    }
}

#pragma mark - TTTAttributedLabelDelegate

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithTransitInformation:(NSDictionary *)components {
    if ([_delegate respondsToSelector:@selector(didSelectPeople:)]) {
        [_delegate didSelectPeople:components];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
