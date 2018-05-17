//
//  MeTableViewController.m
//  WeChat1
//
//  Created by Topsky on 2018/4/28.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "MeTableViewController.h"
#import "FindCell.h"
#import "MeCell.h"
#import "PublicDef.h"

static NSString *const kCellId0 = @"FindCell";
static NSString *const kCellId1 = @"MeCell";

@interface MeTableViewController ()

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation MeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FindCell class]) bundle:nil] forCellReuseIdentifier:kCellId0];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MeCell class]) bundle:nil] forCellReuseIdentifier:kCellId1];
    self.dataArr = @[@[@{MeCellImageName:HEAD_IMG_NAME, MeCellMainStr:USER_NAME, MeCellAccountIdStr:@"微信号：123456789"}],
                     @[@{FindCellImageName:@"MoreMyBankCard", FindCellContentStr:@"钱包"}],
                     @[@{FindCellImageName:@"MoreMyFavorites", FindCellContentStr:@"收藏"},
                       @{FindCellImageName:@"ff_IconShowAlbum", FindCellContentStr:@"相册"},
                       @{FindCellImageName:@"MyCardPackageIcon", FindCellContentStr:@"卡包"},
                       @{FindCellImageName:@"MoreExpressionShops", FindCellContentStr:@"表情"}],
                     @[@{FindCellImageName:@"MoreSetting", FindCellContentStr:@"设置"}]
                     ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 90;
    } else {
        return 45;
    }
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
    if (indexPath.section == 0) {
        MeCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId1 forIndexPath:indexPath];
        [cell setContentData:[self.dataArr[indexPath.section] objectAtIndex:indexPath.row]];
        return cell;
    } else {
        FindCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId0 forIndexPath:indexPath];
        [cell setContentData:[self.dataArr[indexPath.section] objectAtIndex:indexPath.row]];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
