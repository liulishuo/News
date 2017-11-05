//
//  NewsViewController.m
//  News
//
//  Created by liulishuo on 2017/11/3.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import "LLSNewsViewController.h"
#import "LLSNewsListCell.h"
#import "LLSAPIManager+News.h"
#import "LLSNewsDetailViewController.h"
#import "MJRefresh.h"

static const NSUInteger kPageSize = 20;

@interface LLSNewsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSUInteger pageIndex;

@end

@implementation LLSNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新闻";
    
    _dataArray = [NSMutableArray new];
    
    __weak __typeof(self) weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageIndex = 1;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.tableView reloadData];
        [weakSelf fetchNewsList];
    }];
    
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageIndex ++;
        [weakSelf fetchNewsList];
    }];
    
    [_tableView.mj_header beginRefreshing];
    
    _tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Event Response
#pragma mark - Network
- (void)fetchNewsList {
    [LLSAPIManager fetchNewsListWithCatalog:1 pageIndex:_pageIndex pageSize:kPageSize success:^(NSDictionary * _Nullable responseObject) {
        NSArray *newsListArray = responseObject[@"newslist"];
        [_dataArray addObjectsFromArray:newsListArray];
        [_tableView reloadData];
        [self refershMJEndStatus];
    } failure:^(NSError * _Nullable error) {
        [self processError:error];
        if (_pageIndex > 1) {
            _pageIndex --;
        }
        [self refershMJEndStatus];
    }];
}
#pragma mark - Delegate
#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LLSNewsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLSNewsListCell"];
    [cell configureWithData:_dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSDictionary *newsInfo = _dataArray[indexPath.row];
    NSNumber *newsId = newsInfo[@"id"];
    [self performSegueWithIdentifier:@"toDetail" sender:newsId];
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
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toDetail"]) {
        LLSNewsDetailViewController *vc = segue.destinationViewController;
        vc.hidesBottomBarWhenPushed = YES;
        vc.newsId = ((NSNumber *)sender).unsignedIntegerValue;
    }
}
#pragma mark - Setter and Getter




@end
