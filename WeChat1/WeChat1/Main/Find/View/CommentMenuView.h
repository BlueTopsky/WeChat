//
//  CommentMenuView.h
//  WeChat1
//
//  Created by Topsky on 2018/5/16.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "BaseView.h"

@interface CommentMenuView : BaseView

@property (nonatomic, assign, getter = isShowing) BOOL show;
@property (nonatomic, copy) void (^likeButtonClickedBlock)(void);
@property (nonatomic, copy) void (^commentButtonClickedBlock)(void);

-(void)setLikeTitle:(NSString *)title;

@end
