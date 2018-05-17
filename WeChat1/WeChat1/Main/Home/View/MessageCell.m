//
//  MessageCell.m
//  WeChat1
//
//  Created by Topsky on 2018/4/28.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "MessageCell.h"
#import <UIImageView+WebCache.h>
#import "MessageItem.h"
#import "NSDate+SKYExtension.h"

@interface MessageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *silentImgV;

@end

@implementation MessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImgV.layer.cornerRadius = 10;
    self.headImgV.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setMessageContent:(MessageItem *)item {
    [self.headImgV sd_setImageWithURL:[NSURL URLWithString:item.photo]];
    self.nameLabel.text = item.userName;
    self.contentLabel.text = item.message;
    
    self.silentImgV.hidden = !item.isSilent;
    NSString *createDate = [NSDate transformMillisecondToTime:item.createDate  format:@"yyyy/MM/dd HH:mm:ss"];
    NSString *todayStr = [NSDate stringFromDate:[NSDate date] format:@"yyyy/MM/dd HH:mm:ss"];
    NSString *str0 = [[createDate substringToIndex:10] stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSString *str1 = [[todayStr substringToIndex:10] stringByReplacingOccurrencesOfString:@"/" withString:@""];
    if ([str1 integerValue] - [str0 integerValue] < 0) {
        self.timeLabel.text = nil;
    } else if ([str1 integerValue] - [str0 integerValue] == 0) {
        self.timeLabel.text = [createDate substringWithRange:NSMakeRange(11, 5)];
    } else if ([str1 integerValue] - [str0 integerValue] == 1) {
        self.timeLabel.text = @"昨天";
    } else {
        self.timeLabel.text = [createDate substringToIndex:10];
    }
}

@end
