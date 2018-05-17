//
//  HomeTableViewController.m
//  WeChat1
//
//  Created by Topsky on 2018/4/28.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "HomeTableViewController.h"
#import "HomeViewModel.h"
#import "MessageItem.h"
#import "MessageCell.h"
#import "PublicDef.h"
#import "SearchTableViewController.h"
#import <UIColor+SKYExtension.h>
#import <UIImage+SKYExtension.h>
#import "DetailMsgViewController.h"

#if defined(DEBUG) || defined(_DEBUG)
#import "FHHFPSIndicator.h"
#endif

static NSString *const kCellID = @"MessageCellID";

@interface HomeTableViewController ()

@property (nonatomic, strong) NSMutableArray *msgMuArray;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) SearchTableViewController *searchVC;

@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.msgMuArray = [NSMutableArray array];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MessageCell class]) bundle:nil] forCellReuseIdentifier:kCellID];
    [self setSearchView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.msgMuArray = [NSMutableArray arrayWithArray:[[HomeViewModel new] loadMessages]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        });
    });
    #if defined(DEBUG) || defined(_DEBUG)
    [[FHHFPSIndicator sharedFPSIndicator] show];
    //[FHHFPSIndicator sharedFPSIndicator].fpsLabelPosition = FPSIndicatorPositionTopLeft;
    #endif
    
}

- (void)setSearchView {
    // 创建UISearchController, 这里使用当前控制器来展示结果
    self.searchVC = [SearchTableViewController new];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.msgMuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    MessageItem *item = self.msgMuArray[indexPath.row];
    [cell setMessageContent:item];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MessageItem *item = self.msgMuArray[indexPath.row];
    [self performSegueWithIdentifier:@"PushToDetailMsgVC" sender:item];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.msgMuArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PushToDetailMsgVC"]) {
        DetailMsgViewController *detailVC = (DetailMsgViewController *)segue.destinationViewController;
        detailVC.msgItem = sender;
    }
}

@end
