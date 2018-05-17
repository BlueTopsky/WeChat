//
//  FriendCircleTableViewController.m
//  WeChat1
//
//  Created by Topsky on 2018/5/11.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "FriendCircleTableViewController.h"
#import "CircleCell.h"
#import "CircleHeaderView.h"
#import "PublicDef.h"
#import "FriendCircleViewModel.h"
#import "CircleItem.h"
#import "SectionHeaderView.h"
#import "SectionFooterView.h"
#import "LikeUserCell.h"
#import <UIColor+SKYExtension.h>
#import <Masonry.h>
#import <MJRefresh.h>

static NSString *const kCellId = @"CircleCell";
static NSString *const kCellId1 = @"LikeUserCell";

@interface FriendCircleTableViewController () <SectionHeaderViewDelegate, CircleCellDelegate, LikeUserCellDelegate, UITextViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataMuArr;
@property (nonatomic, strong) NSMutableArray *headerMuArr;
@property (nonatomic, assign) NSInteger selectedSection;
@property (nonatomic, strong) UITextView *kTextView;
@property (nonatomic, strong) UIView *kInputView;
@property (nonatomic, assign) CGFloat kInputHeight;
@property (nonatomic, strong) NSDictionary *toPeople;

@end

@implementation FriendCircleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.kInputHeight = 50;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.navigationItem.title = @"朋友圈";
    [self.tableView registerClass:[CircleCell class] forCellReuseIdentifier:kCellId];
    [self.tableView registerClass:[LikeUserCell class] forCellReuseIdentifier:kCellId1];
    CircleHeaderView *headView = [[CircleHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_MIN_LENGTH, 280)];
    self.tableView.tableHeaderView = headView;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.estimatedRowHeight = 100;
    [self addInputView];
    [self setMJRefreshData];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.dataMuArr = [[FriendCircleViewModel new] loadDatas];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self hideKeyBoard];
}

- (void)addInputView {
    self.kInputView = [UIView new];
    _kInputView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [[UIApplication sharedApplication].keyWindow addSubview:_kInputView];
    [_kInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@50);
        make.left.right.equalTo([UIApplication sharedApplication].keyWindow);
        make.bottom.equalTo(@(self.kInputHeight));
    }];
    
    self.kTextView = [UITextView new];
    _kTextView.backgroundColor = [UIColor whiteColor];
    _kTextView.layer.cornerRadius = 5;
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 5;// 字体的行间距
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:16], NSParagraphStyleAttributeName:paragraphStyle
                                 };
    _kTextView.typingAttributes = attributes;
    _kTextView.returnKeyType = UIReturnKeySend;
    _kTextView.delegate = self;
    [_kInputView addSubview:_kTextView];
    [_kTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@7);
        make.bottom.equalTo(@(-7));
        make.left.equalTo(@14);
        make.right.equalTo(@(-50));
    }];
}

- (void)setMJRefreshData {
    __weak typeof(self) weakSelf = self;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        DebugLog(@"开始刷新");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.dataMuArr addObjectsFromArray:[[FriendCircleViewModel new] loadDatas]];
            [weakSelf.tableView.mj_footer endRefreshing];
            DebugLog(@"结束刷新");
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
            });
        });
    }];
    [footer setTitle:@"加载更多" forState:MJRefreshStateRefreshing];
    self.tableView.mj_footer = footer;
}

- (void)startComment {
    [self.kTextView becomeFirstResponder];
}

- (void)hideKeyBoard {
    [self.kTextView resignFirstResponder];
}

- (void)sendMessage:(NSString *)text {
    CircleItem *item = self.dataMuArr[self.selectedSection];
    NSDictionary *dic = @{
        @"commet_id": @10,
        @"comment_user_id": @(USER_ID),
        @"comment_user_name": USER_NAME,
        @"comment_text": text,
        @"comment_to_user_id": [_toPeople valueForKey:@"comment_to_user_id"],
        @"comment_to_user_name": [_toPeople valueForKey:@"comment_to_user_name"],
    };
    NSMutableArray *comments = [NSMutableArray arrayWithArray:item.comments];
    [comments addObject:dic];
    item.comments = [comments copy];
    [[FriendCircleViewModel new] calculateItemHeight:item];
    [self.tableView reloadData];
}

// 开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self hideKeyBoard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataMuArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CircleItem *item = self.dataMuArr[section];
    if (item.like_users.count > 0) {
        return item.comments.count + 1;
    } else {
        return item.comments.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CircleItem *item = self.dataMuArr[indexPath.section];
    if (item.like_users.count > 0) {
        if (indexPath.row == 0) {
            LikeUserCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId1 forIndexPath:indexPath];
            cell.delegate = self;
            [cell setContentData:item];
            return cell;
        } else {
            CircleCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId forIndexPath:indexPath];
            [cell setContentData:item index:indexPath.row - 1];
            cell.delegate = self;
            return cell;
        }
    } else {
        CircleCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId forIndexPath:indexPath];
        [cell setContentData:item index:indexPath.row];
        cell.delegate = self;
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *viewIdentfier = @"headView";
    SectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:viewIdentfier];
    if(!headerView){
        headerView = [[SectionHeaderView alloc] initWithReuseIdentifier:viewIdentfier];
    }
    CircleItem *item = self.dataMuArr[section];
    headerView.delegate = self;
    [headerView setContentData:item section:section];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CircleItem *item = self.dataMuArr[section];
    return item.headerHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    static NSString *viewIdentfier = @"footerView";
    SectionFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:viewIdentfier];
    if(!footerView){
        footerView = [[SectionFooterView alloc] initWithReuseIdentifier:viewIdentfier];
        if (!self.headerMuArr) {
            self.headerMuArr = [NSMutableArray array];
        }
        [self.headerMuArr addObject:footerView];
    }
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CircleItem *item = self.dataMuArr[section];
    return item.footerHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CircleItem *item = self.dataMuArr[indexPath.section];
    NSDictionary *dic = nil;
    if (item.like_users.count > 0) {
        if (indexPath.row > 0) {
            dic = item.comments[indexPath.row - 1];
        }
    } else {
        dic = item.comments[indexPath.row];
    }
    if (dic) {
        self.selectedSection = indexPath.section;
        self.toPeople = @{
                          @"comment_to_user_id": [dic valueForKey:@"comment_user_id"],
                          @"comment_to_user_name": [dic valueForKey:@"comment_user_name"],
                          };
        [self startComment];
    }
}

#pragma mark - SectionHeaderViewDelegate

- (void)spreadContent:(BOOL)isSpread section:(NSUInteger)section{
    CircleItem *item = self.dataMuArr[section];
    item.isSpread = isSpread;
    item.headerHeight = [[FriendCircleViewModel new] getHeaderHeight:item];
    [self.tableView reloadData];
}

- (void)didTapPeople:(CircleItem *)circleItem {
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.navigationItem.title = circleItem.user_name;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didClickLikeButton:(NSInteger)section {
    CircleItem *item = self.dataMuArr[section];
    NSMutableArray *muArr = [NSMutableArray arrayWithArray:item.like_users];
    BOOL isContain = NO;
    NSDictionary *containDic = nil;
    for (NSDictionary *dic in item.like_users) {
        if ([[dic valueForKey:@"userId"] integerValue] == 0) {
            isContain = YES;
            containDic = dic;
            break;
        }
    }
    if (isContain) {
        [muArr removeObject:containDic];
    } else {
        [muArr addObject:@{@"userId": @(USER_ID), @"userName": USER_NAME}];
    }
    item.like_users = [muArr copy];
    [[FriendCircleViewModel new] calculateItemHeight:item];
    [self.tableView reloadData];
}

- (void)didClickCommentButton:(NSInteger)section {
    self.selectedSection = section;
    CircleItem *item = self.dataMuArr[section];
    self.toPeople = @{
                      @"comment_to_user_id": @(item.user_id),
                      @"comment_to_user_name": item.user_name,
                      };
    [self startComment];
}

#pragma mark - CircleCellDelegate,LikeUserCellDelegate

- (void)didSelectPeople:(NSDictionary *)dic {
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.navigationItem.title = [dic valueForKey:@"user_name"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 5000) { // 限制5000字内
        textView.text = [textView.text substringToIndex:5000];
    }
    static CGFloat maxHeight = 36 + 24 * 2;//初始高度为36，每增加一行，高度增加24
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    if (size.height >= maxHeight) {
        size.height = maxHeight;
        textView.scrollEnabled = YES;   // 允许滚动
    } else {
        textView.scrollEnabled = NO;    // 不允许滚动
    }
    if ((ceil(size.height) + 14) != self.kInputHeight) {
        CGPoint offset = self.tableView.contentOffset;
        CGFloat delta = ceil(size.height) + 14 - self.kInputHeight;
        offset.y += delta;
        if (offset.y < 0) {
            offset.y = 0;
        }
        [self.tableView setContentOffset:offset animated:NO];
        self.kInputHeight = ceil(size.height) + 14;
        [self.kInputView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(ceil(size.height) + 14));
        }];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        if (self.kTextView.text.length > 0) {     // send Text
            [self sendMessage:self.kTextView.text];
        }
        [self.kInputView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@50);
        }];
        [self.kTextView setText:@""];
        self.kInputHeight = 50;
        [self hideKeyBoard];
        return NO;
    }
    return YES;
}

#pragma mark - 通知方法

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    // 1,取出键盘动画的时间
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 2,取得键盘将要移动到的位置的frame
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 3,计算kInputView需要平移的距离
    CGFloat moveY = self.view.frame.size.height + TOPBAR_HEIGHT - keyboardFrame.origin.y;
    // 4,执行动画
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    SectionHeaderView *headerView = (SectionHeaderView *)[self.tableView headerViewForSection:self.selectedSection];
    CGRect rect = [headerView.superview convertRect:headerView.frame toView:window];
    CircleItem *item = self.dataMuArr[self.selectedSection];
    CGFloat cellHeight = item.likerHeight;
    for (NSNumber *num in item.commentHeightArr) {
        cellHeight += [num floatValue];
    }
    CGFloat footerMaxY = CGRectGetMaxY(rect) + cellHeight + item.footerHeight;
    CGFloat delta = footerMaxY - (SCREEN_MAX_LENGTH - (moveY + self.kInputHeight));
    CGPoint offset = self.tableView.contentOffset;
    offset.y += delta;
    if (offset.y < 0) {
        offset.y = 0;
    }
    [self.tableView setContentOffset:offset animated:NO];
    [self.kInputView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (moveY == 0) {
            make.bottom.equalTo(@(self.kInputHeight));
        } else {
            make.bottom.equalTo(@(-moveY));
        }
    }];
    [UIView animateWithDuration:duration animations:^{
        [[UIApplication sharedApplication].keyWindow layoutIfNeeded];
    }];
}

- (void)dealloc {
    [self.kInputView removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    DebugLog(@"%@--dealloc",[self class]);
}

@end
