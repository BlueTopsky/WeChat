//
//  MeCell.m
//  WeChat1
//
//  Created by Topsky on 2018/5/10.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "MeCell.h"

NSString *const MeCellImageName = @"image";
NSString *const MeCellMainStr = @"title";
NSString *const MeCellAccountIdStr = @"accountId";

@interface MeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImgV;
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountIdLabel;

@end

@implementation MeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImgV.layer.cornerRadius = 5;
    self.headImgV.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContentData:(NSDictionary *)dic {
    self.headImgV.image = [UIImage imageNamed:[dic valueForKey:MeCellImageName]];
    self.mainLabel.text = [dic valueForKey:MeCellMainStr];
    self.accountIdLabel.text = [dic valueForKey:MeCellAccountIdStr];
}

@end
