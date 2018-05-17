//
//  DetailMsgViewController.m
//  WeChat1
//
//  Created by Topsky on 2018/5/9.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "DetailMsgViewController.h"
#import "ReciveMsgCell.h"
#import "SendMsgCell.h"
#import "PublicDef.h"
#import "DetailMsgViewModel.h"
#import "MessageItem.h"
#import <MJRefresh.h>

static NSString *const kCellID0 = @"ReciveCell";
static NSString *const kCellID1 = @"SendCell";

@interface DetailMsgViewController () <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *kInputView;
@property (weak, nonatomic) IBOutlet UITextView *kTextView;
@property (weak, nonatomic) IBOutlet UITableView *kTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *kInputViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *kInputViewBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *kTextViewBottom;
@property (nonatomic, strong) NSMutableArray *msgMuArray;

@end

@implementation DetailMsgViewController

- (NSMutableArray *)msgMuArray {
    if (_msgMuArray == nil) {
        _msgMuArray = [NSMutableArray array];
    }
    return _msgMuArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.msgItem.userName;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.kTextView.layer.cornerRadius = 5;
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 5;// 字体的行间距
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:16], NSParagraphStyleAttributeName:paragraphStyle
                                 };
    self.kTextView.typingAttributes = attributes;
    self.kTextView.delegate = self;
    //self.kTableView.clipsToBounds = YES;
    self.kTableView.estimatedRowHeight = 52;
    [self.kTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ReciveMsgCell class]) bundle:nil] forCellReuseIdentifier:kCellID0];
    [self.kTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SendMsgCell class]) bundle:nil] forCellReuseIdentifier:kCellID1];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
//    [self.kTableView addGestureRecognizer:tap];
    [self setHeaderRefresh];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.msgMuArray = [[DetailMsgViewModel new] loadDetailMessages];
        [self.msgMuArray insertObject:self.msgItem atIndex:0];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.kTableView reloadData];
            NSIndexPath *path = [NSIndexPath indexPathForRow:self.msgMuArray.count - 1 inSection:0];
            [self.kTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:NO];
        });
    });
}

- (void)setHeaderRefresh {
    __weak __typeof(&*self)weakSelf =self;
    self.kTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSMutableArray *muArr = [[DetailMsgViewModel new] loadDetailMessages];
            if (muArr.count > 0) {
                [weakSelf.msgMuArray addObjectsFromArray:muArr];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.kTableView reloadData];
                    NSIndexPath *path = [NSIndexPath indexPathForRow:muArr.count inSection:0];
                    [weakSelf.kTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:NO];
                    [weakSelf.kTableView.mj_header endRefreshing];
                    weakSelf.kTableView.mj_header = nil;
                });
            } else {
                [weakSelf.kTableView.mj_header endRefreshing];
                weakSelf.kTableView.mj_header = nil;
            }
        });
    }];
}

- (void)hideKeyBoard {
    [self.kTextView resignFirstResponder];
}

- (void)sendMessage:(NSString *)text autoAnswer:(BOOL)autoAnswer{
    MessageItem *msgItem = [MessageItem new];
    msgItem.message = text;
    if (autoAnswer) {
        msgItem.userId = [NSString stringWithFormat:@"%d",USER_ID];
    } else {
        msgItem.userId = @"1";
    }
    [self.msgMuArray insertObject:msgItem atIndex:0];
    [self.kTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.msgMuArray.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSIndexPath *path = [NSIndexPath indexPathForRow:self.msgMuArray.count - 1 inSection:0];
        [self.kTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
        if (autoAnswer) {
            [self sendMessage:text autoAnswer:NO];
        }
    });
}

- (IBAction)clickVoiceBtn:(UIButton *)sender {
}

- (IBAction)clickEmotionBtn:(id)sender {
}

- (IBAction)clickAddBtn:(id)sender {
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    // 1,取出键盘动画的时间
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 2,取得键盘将要移动到的位置的frame
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 3,计算kInputView需要平移的距离
    CGFloat moveY = self.view.frame.size.height + TOPBAR_HEIGHT - keyboardFrame.origin.y;
    
    // 4,执行动画
    //xib中的动画必须要这样写，否则无效
    self.kInputViewBottom.constant = moveY;
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
    
    if (self.msgMuArray.count > 0) {
        if (moveY == 0) {
            [self.kTableView reloadData];
        } else {
            NSIndexPath *path = [NSIndexPath indexPathForRow:self.msgMuArray.count - 1 inSection:0];
            [self.kTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    DebugLog(@"%@--dealloc",[self class]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.msgMuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageItem *msgItem = self.msgMuArray[self.msgMuArray.count - indexPath.row - 1];
    if ([msgItem.userId integerValue] == USER_ID) {
        SendMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID1 forIndexPath:indexPath];
        [cell setContentMsg:msgItem];
        return cell;
    } else {
        ReciveMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID0 forIndexPath:indexPath];
        [cell setContentMsg:msgItem];
        [cell setHeadImg:self.msgItem.photo];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

// 开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self hideKeyBoard];
}

#pragma mark - UITextViewDelegate

- (void) textViewDidBeginEditing:(UITextView *)textView {
    
}

- (void) textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 5000) { // 限制5000字内
        textView.text = [textView.text substringToIndex:5000];
    }
    static CGFloat maxHeight = 36 + 24 * 2;//初始高度为36，每增加一行，高度增加24
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    NSLog(@"size = %f ,  frame = %f", size.height, frame.size.height);
    if (size.height >= maxHeight) {
        size.height = maxHeight;
        textView.scrollEnabled = YES;   // 允许滚动
    } else {
        textView.scrollEnabled = NO;    // 不允许滚动
    }
    if (self.kInputViewHeight.constant != ceil(size.height) + self.kTextViewBottom.constant * 2) {
        self.kInputViewHeight.constant = ceil(size.height) + self.kTextViewBottom.constant * 2;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        if (self.kTextView.text.length > 0) {     // send Text
            [self sendMessage:self.kTextView.text autoAnswer:YES];
        }
        [self.kTextView setText:@""];
        self.kInputViewHeight.constant = 50;
        return NO;
    }
    return YES;
}

@end
