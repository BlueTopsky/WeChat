//
//  MyTabBarController.m
//  WeChat1
//
//  Created by Topsky on 2018/4/27.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "MyTabBarController.h"
#import "PublicDef.h"
#import <UIColor+SKYExtension.h>

@interface MyTabBarController ()

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithHexString:@"#eeeeee"]];
    [UITabBar appearance].translucent = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    DebugLog(@"%@--dealloc",NSStringFromClass([self class]));
}

@end
