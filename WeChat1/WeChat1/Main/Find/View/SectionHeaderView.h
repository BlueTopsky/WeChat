//
//  SectionHeaderView.h
//  WeChat1
//
//  Created by Topsky on 2018/5/14.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const CGFloat SectionHeaderHorizontalSpace; //水平方向控件之间的间隙距离
extern const CGFloat SectionHeaderVerticalSpace; //竖直方向控件之间的间隙距离
extern const CGFloat SectionHeaderTopSpace; //顶部的空白距离
extern const CGFloat SectionHeaderBottomSpace; //底部的空白距离
extern const CGFloat SectionHeaderPictureSpace; //图片之间的间隙距离
extern const CGFloat SectionHeaderLineSpace; //文本行间距
extern const CGFloat SectionHeaderBigFontSize; //除时间label外的其它控件字体大小
extern const CGFloat SectionHeaderSmallFontSize; //时间label字体大小
extern const CGFloat SectionHeaderMoreBtnHeight; //全文按钮高度
extern const CGFloat SectionHeaderNameLabelHeight; //名字label高度
extern const CGFloat SectionHeaderTimeLabelHeight; //时间label高度
extern const CGFloat SectionHeaderMaxContentHeight; //文本最大高度
extern const CGFloat SectionHeaderOnePictureHeight; //只有一张图片时的图片高度
extern const CGFloat SectionHeaderSomePicturesHeight; //有多张图片时的单张图片高度

@class CircleItem;

@protocol SectionHeaderViewDelegate <NSObject>

- (void)spreadContent:(BOOL)isSpread section:(NSUInteger)section;
- (void)didTapPeople:(CircleItem *)circleItem;
- (void)didClickLikeButton:(NSInteger)section;
- (void)didClickCommentButton:(NSInteger)section;

@end

@interface SectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, weak) id <SectionHeaderViewDelegate> delegate;

- (void)setContentData:(CircleItem *)circleItem section:(NSInteger)section;

@end
