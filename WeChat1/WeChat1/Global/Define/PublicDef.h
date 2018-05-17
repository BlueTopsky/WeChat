//
//  PublicDef.h
//  WeChat1
//
//  Created by Topsky on 2018/4/27.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#ifndef PublicDef_h
#define PublicDef_h

#ifdef DEBUG
#define DebugLog(...)  NSLog(__VA_ARGS__)
#else
#define DebugLog(...)  {}
#endif

#define   IS_IPAD             (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define   IS_IPHONE           (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define   SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
#define   SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height
#define   SCREEN_MAX_LENGTH   (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define   SCREEN_MIN_LENGTH   (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define   SYSTEM_VERSION      [[UIDevice currentDevice].systemVersion floatValue]
#define   MAIN_COLOR          [UIColor colorWithRed:0 green:(190 / 255.0) blue:(12 / 255.0) alpha:1]
#define   TOPBAR_HEIGHT       ([[UIApplication sharedApplication] statusBarFrame].size.height + [UINavigationController new].navigationBar.frame.size.height)
#define   HEAD_IMG_NAME       @"avatar.jpg"     //自己的头像
#define   USER_NAME           @"Topsky"     //自己的user_name
#define   USER_ID             0   //自己的user_id

#endif /* PublicDef_h */
