//
//  SendMsgCell.m
//  WeChat1
//
//  Created by Topsky on 2018/5/9.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "SendMsgCell.h"
#import "MessageItem.h"
#import "NSString+SKYExtension.h"
#import "PublicDef.h"
#import <UIImageView+WebCache.h>

@interface SendMsgCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImgV;
@property (weak, nonatomic) IBOutlet UIImageView *contentBgImgV;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentBgLeading;

@end

@implementation SendMsgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentBgImgV.image = [self getPopImg];
    [self.headImgV setImage:[UIImage imageNamed:HEAD_IMG_NAME]];
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureDidFire:)];
    [self.contentBgImgV addGestureRecognizer:longPressGestureRecognizer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContentMsg:(MessageItem *)msgItem {
    self.contentLabel.text = msgItem.message;
    CGFloat maxWidth = SCREEN_MIN_LENGTH - 8 - 36 - 4 - 40 - 30;
    if ([msgItem.message contentHaveOneLinesWithWidth:maxWidth font:[UIFont systemFontOfSize:16] lineSpacing:10]) {
        CGSize contentSize = [msgItem.message contentSizeWithWidth:maxWidth font:[UIFont systemFontOfSize:16] lineSpacing:10];
        CGFloat contentWidth = ceil(contentSize.width);
        if (contentWidth < 30) {
            contentWidth = 30;
        }
        self.contentBgLeading.constant = SCREEN_MIN_LENGTH - contentWidth - 30 - 4 - 8 - 36;
    } else {
        self.contentBgLeading.constant = 40;
    }
}

- (UIImage *)getPopImg {
    UIImage *image = [UIImage imageNamed:@"SenderTextNodeBkg"];
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
