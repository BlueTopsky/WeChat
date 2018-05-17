//
//  FindCell.m
//  WeChat1
//
//  Created by Topsky on 2018/5/10.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "FindCell.h"

NSString *const FindCellImageName = @"image";
NSString *const FindCellContentStr = @"title";

@interface FindCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImgV;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation FindCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContentData:(NSDictionary *)dic {
    self.headImgV.image = [UIImage imageNamed:[dic valueForKey:FindCellImageName]];
    self.contentLabel.text = [dic valueForKey:FindCellContentStr];
}

@end
