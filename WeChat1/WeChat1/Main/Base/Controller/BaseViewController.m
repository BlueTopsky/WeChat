//
//  BaseViewController.m
//  WeChat1
//
//  Created by Topsky on 2018/4/27.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "BaseViewController.h"
#import "PublicDef.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    DebugLog(@"%@--dealloc",NSStringFromClass([self class]));
}

@end
