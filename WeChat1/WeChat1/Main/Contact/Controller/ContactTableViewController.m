//
//  ContactTableViewController.m
//  WeChat1
//
//  Created by Topsky on 2018/4/28.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "ContactTableViewController.h"
#import "PeopleItem.h"
#import "PeopleTableViewCell.h"
#import "ContactViewModel.h"
#import "PublicDef.h"
#import "SearchTableViewController.h"
#import <UIColor+SKYExtension.h>
#import <UIImage+SKYExtension.h>
#include "SKYContactManager.h"

static NSString *const kCellID = @"PeopleCellID";

@interface ContactTableViewController ()

@property (nonatomic, strong) NSMutableArray *peopleMuArray; // 数据源数组
@property (nonatomic, strong) NSArray *topArray;
@property (nonatomic, strong) NSMutableArray *indexTitlesArr;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) SearchTableViewController *searchVC;

@end

@implementation ContactTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.peopleMuArray = [NSMutableArray new];
    self.indexTitlesArr = [NSMutableArray new];
    self.topArray = @[@{@"title": @"新朋友", @"image": @"新朋友"}, @{@"title": @"群聊", @"image": @"新朋友"}, @{@"title": @"标签", @"image": @"新朋友"}, @{@"title": @"公众号", @"image": @"新朋友"}];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PeopleTableViewCell class]) bundle:nil] forCellReuseIdentifier:kCellID];
    //索引条背景的颜色（清空颜色就不会感觉索引条将tableview往左边挤）
    [self.tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
    //索引条文字的颜色
    [self.tableView setSectionIndexColor:[UIColor darkGrayColor]];
    [self setSearchView];
    DebugLog(@"开始获取通讯录");
    [self loadData];
}

- (void)loadData {
    if ([[SKYContactManager sharedInstance] getAllPeoples] == nil) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self loadData];
        });   
    } else {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            self.peopleMuArray = [[ContactViewModel new] handleLettersArray:[[SKYContactManager sharedInstance] getAllPeoples]];
            for (NSDictionary *dic in self.peopleMuArray) {
                [self.indexTitlesArr addObject:dic.allKeys[0]];
            }
            DebugLog(@"获取通讯录结束");
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        });
    }
}

- (void)setSearchView {
    // 创建UISearchController, 这里使用当前控制器来展示结果
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self.searchVC = [main instantiateViewControllerWithIdentifier:@"SearchResultVC"];
    UISearchController *search = [[UISearchController alloc] initWithSearchResultsController:_searchVC];
    // 设置结果更新代理
    [search setSearchResultsUpdater:_searchVC];
    [search setDelegate:_searchVC];
    // 因为在当前控制器展示结果, 所以不需要这个透明视图
    search.dimsBackgroundDuringPresentation = NO;
    //点击搜索的时候,是否隐藏导航栏
    search.hidesNavigationBarDuringPresentation = YES;
    search.searchBar.placeholder = @"搜索";
    [search.searchBar setValue:@"取消" forKey:@"_cancelButtonText"];
    [search.searchBar sizeToFit];
    //取消按钮字体和光标的颜色
    search.searchBar.tintColor = [UIColor greenColor];
    //改变searchController背景颜色
    search.searchBar.backgroundImage = [UIImage imageWithColor:[UIColor colorWithHexString:@"#eeeeee"]];
    //设置搜索框图标的偏移
    [search.searchBar setPositionAdjustment:UIOffsetMake(SCREEN_MIN_LENGTH/2-43, 0) forSearchBarIcon:UISearchBarIconSearch];

    self.searchController = search;
    //searchBar加到tableView的headerView上，然后为tableView添加sectionIndex，问题就出来了，因为sectionIndex会占用位置，tableView整体左移，searchBar也不例外。解决方法是把searchBar加在一个UIView上，然后把UIView加在tableHeaderView上，同时sectionIndex背景色要清除(clearColor)
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_MIN_LENGTH, _searchController.searchBar.bounds.size.height)];
    headerView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [headerView addSubview:self.searchController.searchBar];
    self.tableView.tableHeaderView = headerView;
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.definesPresentationContext = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.peopleMuArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dic = self.peopleMuArray[section];
    return [dic.allValues[0] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PeopleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    NSDictionary *dic = self.peopleMuArray[indexPath.section];
    [cell setPeopleContent:dic.allValues[0][indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_MIN_LENGTH, 20)];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, SCREEN_MIN_LENGTH - 8, 20)];
    [bgView addSubview:label];
    label.font = [UIFont systemFontOfSize:15.f];
    label.textColor = [UIColor colorWithHexString:@"#999999"];
    NSDictionary *dic = self.peopleMuArray[section];
    label.text = dic.allKeys[0];
    return bgView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_MIN_LENGTH, 0.1)];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    return bgView;
}

//响应点击索引时的委托方法
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    NSInteger count = 0;
    for (NSString *letter in self.indexTitlesArr) {
        if([letter isEqualToString:title]) {
            return count;
        }
        count++;
    }
    return 0;
}

//返回索引数组
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.indexTitlesArr;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
