//
//  SectionFooterView.m
//  WeChat1
//
//  Created by Topsky on 2018/5/15.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "SectionFooterView.h"
#import "PublicDef.h"
#import <UIColor+SKYExtension.h>
#import <Masonry.h>

@implementation SectionFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.contentView.backgroundColor = [UIColor whiteColor];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@0.5);
    }];
}

@end
