//
//  ReciveMsgCell.m
//  WeChat1
//
//  Created by Topsky on 2018/5/9.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "ReciveMsgCell.h"
#import "MessageItem.h"
#import "PublicDef.h"
#import "NSString+SKYExtension.h"
#import <UIImageView+WebCache.h>

@interface ReciveMsgCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImgV;
@property (weak, nonatomic) IBOutlet UIImageView *contentBgImgV;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentBgTrailing;

@end

@implementation ReciveMsgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentBgImgV.image = [self getPopImg];
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureDidFire:)];
    [self.contentBgImgV addGestureRecognizer:longPressGestureRecognizer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setContentMsg:(MessageItem *)msgItem {
    self.contentLabel.text = msgItem.message;
    CGFloat maxWidth = SCREEN_MIN_LENGTH - 8 - 36 - 4 - 40 - 27;
    if ([msgItem.message contentHaveOneLinesWithWidth:maxWidth font:[UIFont systemFontOfSize:16] lineSpacing:10]) {
        CGSize contentSize = [msgItem.message contentSizeWithWidth:maxWidth font:[UIFont systemFontOfSize:16] lineSpacing:10];
        CGFloat contentWidth = ceil(contentSize.width);
        if (contentWidth < 30) {
            contentWidth = 30;
        }
        self.contentBgTrailing.constant = SCREEN_MIN_LENGTH - contentWidth - 27 - 4 - 8 - 36;
    } else {
        self.contentBgTrailing.constant = 40;
    }
}

- (void)setHeadImg:(NSString *)imgUrlStr {
    [self.headImgV sd_setImageWithURL:[NSURL URLWithString:imgUrlStr]];
}

- (UIImage *)getPopImg {
    UIImage *image = [UIImage imageNamed:@"ReceiverTextNodeBkg"];
    return [image stretchableImageWithLeftCapWidth:30 topCapHeight:35];
}

//长按cell
- (void)longPressGestureDidFire:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];
        CGRect rect = self.contentBgImgV.frame;
        UIMenuController *menu = [UIMenuController sharedMenuController];
        // 定义菜单
        UIMenuItem *a = [[UIMenuItem alloc] initWithTitle:@"复制"
                                                   action:@selector(aAction)];
        UIMenuItem *b = [[UIMenuItem alloc] initWithTitle:@"转发"
                                                   action:@selector(bAction)];
        UIMenuItem *c = [[UIMenuItem alloc] initWithTitle:@"删除"
                                                   action:@selector(cAction)];
        menu.menuItems = @[a,b,c];
        [menu setTargetRect:rect inView:self];
        [menu setMenuVisible:YES animated:YES];
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(aAction) || action == @selector(bAction) || action == @selector(cAction)) {
        return YES;
    } else {
        return NO;
    }
}

- (void)aAction{
    NSLog(@"--aAction--");
}

- (void)bAction{
    NSLog(@"--bAction--");
}

- (void)cAction{
    NSLog(@"--aAction--");
}

@end
