//
//  PeopleTableViewCell.m
//  WeChat1
//
//  Created by Topsky on 2018/5/2.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "PeopleTableViewCell.h"
#import "PeopleItem.h"
#import <UIImageView+WebCache.h>

@interface PeopleTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation PeopleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setPeopleContent:(PeopleItem *)peopleVO {
    [self.headImgV sd_setImageWithURL:[NSURL URLWithString:peopleVO.photo]];
    self.nameLabel.text = peopleVO.userName;
}

@end
