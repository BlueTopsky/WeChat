//
//  BaseNavigationController.m
//  WeChat1
//
//  Created by Topsky on 2018/4/27.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "BaseNavigationController.h"
#import "PublicDef.h"
#import <UIColor+SKYExtension.h>
#import <UIImage+SKYExtension.h>

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: MAIN_COLOR} forState:UIControlStateSelected];
    
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRGBA:@"25.5,25.5,25.5,1"]] forBarMetrics:UIBarMetricsDefault];
    //去掉阴影分割线
    //self.navigationBar.shadowImage = [UIImage new];
    //self.navigationBar.barTintColor = [UIColor colorWithRGBA:@"25.5,25.5,25.5,1"];
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont boldSystemFontOfSize:19]};
    self.navigationBar.translucent = NO;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
