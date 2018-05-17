//
//  SearchTableViewController.m
//  WeChat1
//
//  Created by Topsky on 2018/5/3.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "SearchTableViewController.h"
#import "PeopleTableViewCell.h"
#import "SearchDefaultCell.h"
#import "PublicDef.h"
#import "ContactViewModel.h"
#import "PeopleItem.h"
#import "SKYContactManager.h"

static NSString *const kCellID0 = @"SearchCellID0";
static NSString *const kCellID1 = @"SearchCellID1";

@interface SearchTableViewController ()

@property (nonatomic, strong) NSMutableArray *searchArray; // 搜索结果数组
@property (nonatomic, strong) NSMutableArray *peopleMuArray; // 数据源数组

@end

@implementation SearchTableViewController

- (NSMutableArray *)searchArray {
    if (_searchArray == nil) {
        _searchArray = [NSMutableArray array];
    }
    return _searchArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SearchDefaultCell class]) bundle:nil] forCellReuseIdentifier:kCellID0];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PeopleTableViewCell class]) bundle:nil] forCellReuseIdentifier:kCellID1];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self loadData];
}

- (void)loadData {
    if ([[SKYContactManager sharedInstance] getAllPeoples] == nil) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self loadData];
        });
    } else {
        self.peopleMuArray = [[SKYContactManager sharedInstance] getAllPeoples];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchArray.count > 0) {
        return self.searchArray.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.searchArray.count > 0) {
        PeopleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID1 forIndexPath:indexPath];
        [cell setPeopleContent:self.searchArray[indexPath.row]];
        return cell;
    } else {
        SearchDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID0 forIndexPath:indexPath];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.searchArray.count > 0) {
        return 54;
    } else {
        return 150;
    }
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *inputStr = searchController.searchBar.text;
    if (self.searchArray.count > 0) {
        [self.searchArray removeAllObjects];
    }
    NSString *str = [[[SKYContactManager sharedInstance] pinyinWithString:inputStr] lowercaseString];
    for (PeopleItem *item in self.peopleMuArray) {
        NSString *str0 = nil;
        NSString *str1 = nil;
        if ([[ContactViewModel new] containChinese:inputStr]) {
            str1 = item.userName;
            str0 = inputStr;
        }else {
            str1 = [item.fullPinyin lowercaseString];
            str0 = str;
        }
        if ([str1 containsString:str0]) {
            [self.searchArray addObject:item];
        }
    }
    [self.tableView reloadData];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.hidden = NO;
}

#pragma mark - UISearchControllerDelegate

- (void)willPresentSearchController:(UISearchController *)searchController {
    [searchController.searchBar setPositionAdjustment:UIOffsetMake(0, 0) forSearchBarIcon:UISearchBarIconSearch];
}

//UISearchController会默认隐藏resultVC的view,所以要手动设置显示当前view
- (void)didPresentSearchController:(UISearchController *)searchController {
    self.view.hidden = NO;
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    [searchController.searchBar setPositionAdjustment:UIOffsetMake(SCREEN_MIN_LENGTH/2-43, 0) forSearchBarIcon:UISearchBarIconSearch];
    self.view.hidden = YES;
}

@end
