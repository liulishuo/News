//
//  LLSTweetListViewController.m
//  News
//
//  Created by liulishuo on 2017/11/4.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import "LLSTweetListViewController.h"
#import "LLSAPIManager+Tweet.h"
#import <YYModel.h>
#import "LLStweetListItemModel.h"
#import "LLSTweetListCell.h"
#import "MJRefresh.h"

static const NSUInteger kPageSize = 20;

@interface LLSTweetListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSUInteger pageIndex;
@property (nonatomic,strong) NSMutableDictionary *heightDict;

@end

@implementation LLSTweetListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"动弹";
    
    _dataArray = [NSMutableArray new];
    
    __weak __typeof(self) weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageIndex = 1;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.tableView reloadData];
        [weakSelf fetchTweetList];
    }];
    
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageIndex ++;
        [weakSelf fetchTweetList];
    }];
    
    [_tableView.mj_header beginRefreshing];
    _tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Event Response

/**
 刚好只有20条数据的话，请求第二页会得到重复的数据（热门动弹）

 @param itemId 单条数据标识符
 @return 是否和现有数据重复
 */
- (BOOL)checkItemId:(NSString *)itemId {
    __block BOOL existDuplicate = NO;
    [_dataArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(LLStweetListItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.itemId isEqualToString:itemId]) {
            existDuplicate = YES;
            *stop = YES;
        }
    }];
    
    return existDuplicate;
}
#pragma mark - Network
- (void)fetchTweetList {
    [LLSAPIManager fetchTweetListWithUserId:0 pageIndex:_pageIndex pageSize:kPageSize success:^(NSDictionary * _Nullable responseObject) {
        NSArray *tweetListArray = responseObject[@"tweetlist"];
        
        __block BOOL dataIncreased = YES;
        [tweetListArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            LLStweetListItemModel *model = [LLStweetListItemModel yy_modelWithDictionary:obj];
            
            if ([self checkItemId:model.itemId]) {
                dataIncreased = NO;
                *stop = YES;
            }
            
            [_dataArray addObject:model];
        }];
        
        if (dataIncreased) {
            [_tableView reloadData];
            [self refershMJEndStatus];
        } else {
            [_tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSError * _Nullable error) {
        if (_pageIndex > 1) {
            _pageIndex --;
        }
        [self processError:error];
        [self refershMJEndStatus];
    }];
}
#pragma mark - Delegate
#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LLStweetListItemModel *model  = self.dataArray[indexPath.row];
    LLSTweetListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LLSTweetListCell class])];
    [cell reset];
    [cell configureWithData:model];
//    [cell setNeedsUpdateConstraints];
//    [cell updateConstraintsIfNeeded];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - Methods
- (void)refershMJEndStatus {
    [_tableView.mj_header endRefreshing];
    if (_dataArray.count > 0 && _dataArray.count < _pageIndex * kPageSize) {
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [_tableView.mj_footer endRefreshing];
    }
}
#pragma mark - Navigation
#pragma mark - Setter and Getter
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
