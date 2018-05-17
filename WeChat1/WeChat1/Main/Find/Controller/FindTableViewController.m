//
//  FindTableViewController.m
//  WeChat1
//
//  Created by Topsky on 2018/4/28.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "FindTableViewController.h"
#import "FindCell.h"
#import "SKYStringManager.h"

static NSString *const kCellId = @"FindCell";

@interface FindTableViewController ()

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation FindTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SKYStringManager sharedInstance];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FindCell class]) bundle:nil] forCellReuseIdentifier:kCellId];
    self.dataArr = @[@[@{FindCellImageName:@"ff_IconShowAlbum",FindCellContentStr:@"朋友圈"}],
                     @[@{FindCellImageName:@"ff_IconQRCode",FindCellContentStr:@"扫一扫"},
                         @{FindCellImageName:@"ff_IconShake",FindCellContentStr:@"摇一摇"}],
                     @[@{FindCellImageName:@"find_look",FindCellContentStr:@"看一看"},
                         @{FindCellImageName:@"find_search",FindCellContentStr:@"搜一搜"}],
                     @[@{FindCellImageName:@"ff_IconLocationService",FindCellContentStr:@"附近的人"},
                         @{FindCellImageName:@"ff_IconBottle",FindCellContentStr:@"漂流瓶"}],
                     @[@{FindCellImageName:@"find_program",FindCellContentStr:@"小程序"}]
                     ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FindCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId forIndexPath:indexPath];
    [cell setContentData:[self.dataArr[indexPath.section] objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        [self performSegueWithIdentifier:@"PushToFriendCircleVC" sender:nil];
    }
}

@end
