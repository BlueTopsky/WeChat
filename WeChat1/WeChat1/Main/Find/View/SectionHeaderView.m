//
//  SectionHeaderView.m
//  WeChat1
//
//  Created by Topsky on 2018/5/14.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "SectionHeaderView.h"
#import <TTTAttributedLabel.h>
#import <Masonry.h>
#import "CircleItem.h"
#import <UIColor+SKYExtension.h>
#import <UIImageView+WebCache.h>
#import "NSString+SKYExtension.h"
#import "PublicDef.h"
#import "CommentMenuView.h"

const CGFloat SectionHeaderHorizontalSpace = 8; //水平方向控件之间的间隙距离
const CGFloat SectionHeaderVerticalSpace = 8; //竖直方向控件之间的间隙距离
const CGFloat SectionHeaderTopSpace = 12; //顶部的空白距离
const CGFloat SectionHeaderBottomSpace = 5; //底部的空白距离
const CGFloat SectionHeaderPictureSpace = 5; //图片之间的间隙距离
const CGFloat SectionHeaderLineSpace = 2; //文本行间距
const CGFloat SectionHeaderBigFontSize = 16;
const CGFloat SectionHeaderSmallFontSize = 13;
const CGFloat SectionHeaderMoreBtnHeight = 25; //全文按钮高度
const CGFloat SectionHeaderNameLabelHeight = 20; //名字label高度
const CGFloat SectionHeaderTimeLabelHeight = 20; //时间label高度
const CGFloat SectionHeaderMaxContentHeight = 104; //文本最大高度
const CGFloat SectionHeaderOnePictureHeight = 100; //只有一张图片时的图片高度
const CGFloat SectionHeaderSomePicturesHeight = 70; //有多张图片时的单张图片高度

@interface SectionHeaderView ()

@property (nonatomic, strong) CircleItem *item;
@property (nonatomic, assign) NSUInteger section;
@property (nonatomic, strong) UIImageView *headImgV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) TTTAttributedLabel *contentLabel;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) UIView *imgBgView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *commentBtn;
@property (nonatomic, strong) UIView *corner;
@property (nonatomic, strong) CommentMenuView *menuView;

@end

@implementation SectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.headImgV = [UIImageView new];
    self.headImgV.contentMode = UIViewContentModeScaleAspectFill;
    self.headImgV.clipsToBounds = YES;
    
    self.nameLabel = [UILabel new];
    self.nameLabel.font = [UIFont boldSystemFontOfSize:SectionHeaderBigFontSize];
    self.nameLabel.textColor = [UIColor colorWithRGB:@"54,71,121"];
    self.nameLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapName:)];
    [self.nameLabel addGestureRecognizer:tap];
    
    self.contentLabel = [TTTAttributedLabel new];
    self.contentLabel.font = [UIFont systemFontOfSize:SectionHeaderBigFontSize];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.lineSpacing = SectionHeaderLineSpace;
    self.contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.contentLabel.preferredMaxLayoutWidth = SCREEN_MIN_LENGTH - 3 * SectionHeaderHorizontalSpace - 36;
    
    self.moreBtn = [UIButton new];
    [self.moreBtn setTitleColor:[UIColor colorWithRGB:@"92,140,193"] forState:UIControlStateNormal];
    [self.moreBtn setTitle:@"全文" forState:UIControlStateNormal];
    self.moreBtn.titleLabel.font = [UIFont systemFontOfSize:SectionHeaderBigFontSize];
    [self.moreBtn addTarget:self action:@selector(clickMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.imgBgView = [UIView new];
    
    self.timeLabel = [UILabel new];
    self.timeLabel.font = [UIFont systemFontOfSize:SectionHeaderSmallFontSize];
    self.timeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    
    self.commentBtn = [UIButton new];
    [self.commentBtn setImage:[UIImage imageNamed:@"AlbumOperateMore"] forState:UIControlStateNormal];
    [self.commentBtn addTarget:self action:@selector(clickCommentBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.corner = [UIView new];
    self.corner.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    //x改成你要的角度 順時針90就用90 逆時針90就用-90 无论是M_PI还是-M_PI都是逆时针旋转
    CGAffineTransform transform = CGAffineTransformMakeRotation(45 * M_PI/180.0);
    [self.corner setTransform:transform];
    
    self.menuView = [CommentMenuView new];
    __weak typeof(self) weakSelf = self;
    [self.menuView setLikeButtonClickedBlock:^{
        if ([weakSelf.delegate respondsToSelector:@selector(didClickLikeButton:)]) {
            [weakSelf.delegate didClickLikeButton:weakSelf.section];
        }
    }];
    [self.menuView setCommentButtonClickedBlock:^{
        if ([weakSelf.delegate respondsToSelector:@selector(didClickCommentButton:)]) {
            [weakSelf.delegate didClickCommentButton:weakSelf.section];
        }
    }];
    
    [self.contentView addSubview:self.headImgV];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.moreBtn];
    [self.contentView addSubview:self.imgBgView];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.commentBtn];
    [self.contentView addSubview:self.corner];
    [self.contentView addSubview:self.menuView];
    
    //self.contentView.clipsToBounds = YES;
}

- (void)setContentData:(CircleItem *)circleItem section:(NSInteger)section {
    self.item = circleItem;
    self.section = section;
    
    [self.headImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(SectionHeaderHorizontalSpace));
        make.top.equalTo(@(SectionHeaderTopSpace));
        make.width.height.equalTo(@36);
    }];
    [self.headImgV sd_setImageWithURL:[NSURL URLWithString:circleItem.photo]];
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImgV.mas_right).offset(SectionHeaderHorizontalSpace);
        make.right.equalTo(@(-SectionHeaderHorizontalSpace));
        make.top.equalTo(self.headImgV);
        make.height.equalTo(@(SectionHeaderNameLabelHeight));
    }];
    self.nameLabel.text = circleItem.user_name;
    
    [self setContentLabelConstraint];
    [self setImgBgViewContent];
    [self setTimeLabelAndCommentBtnConstraint];
}

- (void)setContentLabelConstraint {
    self.contentLabel.text = nil;
    if (self.item.contentLabelHeight <= 0) {
        [self.moreBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
        }];
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            
        }];
        self.contentLabel.hidden = YES;
        self.moreBtn.hidden = YES;
    } else if (self.item.contentLabelHeight <= SectionHeaderMaxContentHeight){
        [self.moreBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
        }];
        self.contentLabel.hidden = NO;
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(self.item.contentLabelHeight));
            make.top.equalTo(self.nameLabel.mas_bottom).offset(SectionHeaderVerticalSpace);
            make.left.right.equalTo(self.nameLabel);
        }];
        self.moreBtn.hidden = YES;
        self.contentLabel.text = self.item.message;
    } else {
        self.contentLabel.hidden = NO;
        self.moreBtn.hidden = NO;
        if (self.item.isSpread) {
            [self.moreBtn setTitle:@"收起" forState:UIControlStateNormal];
            [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(self.item.contentLabelHeight));
                make.top.equalTo(self.nameLabel.mas_bottom).offset(SectionHeaderVerticalSpace);
                make.left.right.equalTo(self.nameLabel);
            }];
        } else {
            [self.moreBtn setTitle:@"全文" forState:UIControlStateNormal];
            [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(SectionHeaderMaxContentHeight));
                make.top.equalTo(self.nameLabel.mas_bottom).offset(SectionHeaderVerticalSpace);
                make.left.right.equalTo(self.nameLabel);
            }];
        }
        self.contentLabel.text = self.item.message;
        [self.moreBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(SectionHeaderVerticalSpace);
            make.left.equalTo(self.nameLabel).offset(-3);
            make.width.equalTo(@40);
            make.height.equalTo(@(SectionHeaderMoreBtnHeight));
        }];
    }
}

- (void)setImgBgViewContent {
    [self.imgBgView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (self.item.small_pics.count <= 0) {
        self.imgBgView.hidden = YES;
    } else {
        self.imgBgView.hidden = NO;
        [self setImgBgViewConstraint:self.item.imgBgViewHeight];
        [self addPictures];
    }
}

- (void)setImgBgViewConstraint:(CGFloat)height {
    if (self.moreBtn.hidden) {
        if (self.contentLabel.hidden) {
            [self.imgBgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.nameLabel.mas_bottom);
                make.left.right.equalTo(self.nameLabel);
                make.height.equalTo(@(height));
            }];
        } else {
            [self.imgBgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentLabel.mas_bottom);
                make.left.right.equalTo(self.nameLabel);
                make.height.equalTo(@(height));
            }];
        }
    } else {
        [self.imgBgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.moreBtn.mas_bottom);
            make.left.right.equalTo(self.nameLabel);
            make.height.equalTo(@(height));
        }];
    }
}

- (void)addPictures {
    if (self.item.small_pics.count > 0) {
        if (self.item.small_pics.count == 1) {
            UIImageView *imgV = [self createImgV:self.item.small_pics[0]];
            [self.imgBgView addSubview:imgV];
            [imgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@(SectionHeaderVerticalSpace));
                make.left.equalTo(self.imgBgView);
                make.height.equalTo(@(SectionHeaderOnePictureHeight));
                make.width.equalTo(@(SectionHeaderOnePictureHeight + 40));
            }];
        } else {
            for (int i = 0; i < self.item.small_pics.count; i++) {
                if (i == 3) {
                    break;
                }
                UIImageView *imgV = [self createImgV:self.item.small_pics[i]];
                [self.imgBgView addSubview:imgV];
                [imgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(@(SectionHeaderVerticalSpace));
                    make.left.equalTo(@((SectionHeaderPictureSpace + SectionHeaderSomePicturesHeight) * i));
                    make.width.height.equalTo(@(SectionHeaderSomePicturesHeight));
                }];
            }
            if (self.item.small_pics.count > 3) {
                for (int i = 3; i < self.item.small_pics.count; i++) {
                    if (i == 6) {
                        break;
                    }
                    UIImageView *imgV = [self createImgV:self.item.small_pics[i]];
                    [self.imgBgView addSubview:imgV];
                    [imgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(@(SectionHeaderVerticalSpace + SectionHeaderPictureSpace + SectionHeaderSomePicturesHeight));
                        make.left.equalTo(@((SectionHeaderPictureSpace + SectionHeaderSomePicturesHeight) * (i - 3)));
                        make.width.height.equalTo(@(SectionHeaderSomePicturesHeight));
                    }];
                }
            }
            if (self.item.small_pics.count > 6) {
                for (int i = 6; i < self.item.small_pics.count; i++) {
                    if (i == 9) {
                        break;
                    }
                    UIImageView *imgV = [self createImgV:self.item.small_pics[i]];
                    [self.imgBgView addSubview:imgV];
                    [imgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(@(SectionHeaderVerticalSpace + SectionHeaderPictureSpace * 2 + SectionHeaderSomePicturesHeight * 2));
                        make.left.equalTo(@((SectionHeaderPictureSpace + SectionHeaderSomePicturesHeight) * (i - 6)));
                        make.width.height.equalTo(@(SectionHeaderSomePicturesHeight));
                    }];
                }
            }
        }
    }
}

- (UIImageView *)createImgV:(NSString *)urlStr {
    UIImageView *imgV = [UIImageView new];
    imgV.backgroundColor = [UIColor lightGrayColor];
    imgV.contentMode = UIViewContentModeScaleAspectFill;
    imgV.clipsToBounds = YES;
    [imgV sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    return imgV;
}

- (void)setTimeLabelAndCommentBtnConstraint {
    if (self.imgBgView.hidden) {
        if (self.moreBtn.hidden) {
            if (self.contentLabel.hidden) {
                [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.nameLabel.mas_bottom).offset(SectionHeaderVerticalSpace);
                    make.left.equalTo(self.nameLabel);
                    make.width.equalTo(@80);
                    make.height.equalTo(@(SectionHeaderTimeLabelHeight));
                }];
            } else {
                [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.contentLabel.mas_bottom).offset(SectionHeaderVerticalSpace);
                    make.left.equalTo(self.nameLabel);
                    make.width.equalTo(@80);
                    make.height.equalTo(@(SectionHeaderTimeLabelHeight));
                    //make.bottom.equalTo(@(-SectionHeaderBottomSpace));
                }];
            }
        } else {
            [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.moreBtn.mas_bottom).offset(SectionHeaderVerticalSpace);
                make.left.equalTo(self.nameLabel);
                make.width.equalTo(@80);
                make.height.equalTo(@(SectionHeaderTimeLabelHeight));
            }];
        }
    } else {
        [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imgBgView.mas_bottom).offset(SectionHeaderVerticalSpace);
            make.left.equalTo(self.nameLabel);
            make.width.equalTo(@80);
            make.height.equalTo(@(SectionHeaderTimeLabelHeight));
        }];
    }
    self.timeLabel.text = self.item.time_str;
    [self.commentBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_top).offset(-2);
        make.right.equalTo(self.nameLabel.mas_right).offset(5);
        make.width.equalTo(@(30));
        make.height.equalTo(@(SectionHeaderTimeLabelHeight+4));
    }];
    [self.menuView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@32);
        make.centerY.equalTo(self.commentBtn);
        make.right.equalTo(self.commentBtn.mas_left);
        make.width.equalTo(@0);
    }];
    
    if (self.item.comments.count > 0 || self.item.like_users.count > 0) {
        self.corner.hidden = NO;
        [self.corner mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.timeLabel.mas_bottom).offset(1);
            make.width.height.equalTo(@8);
            make.left.equalTo(self.timeLabel.mas_left).offset(10);
        }];
    } else {
        self.corner.hidden = YES;
    }
}

- (void)setLikeBtnTitle {
    BOOL isContain = NO;
    for (NSDictionary *dic in self.item.like_users) {
        if ([[dic valueForKey:@"userId"] integerValue] == 0) {
            isContain = YES;
            break;
        }
    }
    if (isContain) {
        [self.menuView setLikeTitle:@"取消"];
    } else {
        [self.menuView setLikeTitle:@"赞"];
    }
}

- (void)clickMoreBtn:(UIButton *)button {
    if (self.item.isSpread) {
        [button setTitle:@"收起" forState:UIControlStateNormal];
    } else {
        [button setTitle:@"全文" forState:UIControlStateNormal];
    }
    if ([_delegate respondsToSelector:@selector(spreadContent: section:)]) {
        [_delegate spreadContent:!self.item.isSpread section:self.section];
    }
}

- (void)clickCommentBtn:(UIButton *)button {
    [self setLikeBtnTitle];
    self.menuView.show = !self.menuView.isShowing;
}

- (void)tapName:(UITapGestureRecognizer *)tap {
    if ([_delegate respondsToSelector:@selector(didTapPeople:)]) {
        [_delegate didTapPeople:self.item];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.menuView.isShowing) {
        self.menuView.show = NO;
    }
}

@end
