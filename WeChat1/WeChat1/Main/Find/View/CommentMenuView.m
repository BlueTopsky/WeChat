//
//  CommentMenuView.m
//  WeChat1
//
//  Created by Topsky on 2018/5/16.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "CommentMenuView.h"
#import <UIColor+SKYExtension.h>
#import <Masonry.h>

@interface CommentMenuView ()

@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UIButton *commentButton;

@end

@implementation CommentMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 5;
    self.backgroundColor = [UIColor colorWithRGB:@"69,74,76"];
    
    self.likeButton = [self creatButtonWithTitle:@"赞" image:[UIImage imageNamed:@"AlbumLike"] selImage:[UIImage imageNamed:@""] target:self selector:@selector(likeButtonClicked)];
    self.commentButton = [self creatButtonWithTitle:@"评论" image:[UIImage imageNamed:@"AlbumComment"] selImage:[UIImage imageNamed:@""] target:self selector:@selector(commentButtonClicked)];
    UIView *centerLine = [UIView new];
    centerLine.backgroundColor = [UIColor grayColor];
    [self addSubview:_likeButton];
    [self addSubview:_commentButton];
    [self addSubview:centerLine];
    [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self);
        make.width.equalTo(@80);
    }];
    [centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.width.equalTo(@1);
        make.left.equalTo(self.likeButton.mas_right);
    }];
    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.width.equalTo(self.likeButton);
        make.left.equalTo(centerLine.mas_right);
    }];
}

- (UIButton *)creatButtonWithTitle:(NSString *)title image:(UIImage *)image selImage:(UIImage *)selImage target:(id)target selector:(SEL)sel {
    UIButton *btn = [UIButton new];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    return btn;
}

- (void)likeButtonClicked
{
    if (self.likeButtonClickedBlock) {
        self.likeButtonClickedBlock();
    }
    self.show = NO;
}

- (void)commentButtonClicked
{
    if (self.commentButtonClickedBlock) {
        self.commentButtonClickedBlock();
    }
    self.show = NO;
}

- (void)setShow:(BOOL)show
{
    _show = show;
    if (!show) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@0);
        }];
    } else {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@161);
        }];
    }
    [UIView animateWithDuration:0.2 animations:^{
        
        [self.superview layoutIfNeeded];
    }];
}

-(void)setLikeTitle:(NSString *)title {
    [self.likeButton setTitle:title forState:UIControlStateNormal];
}

@end
