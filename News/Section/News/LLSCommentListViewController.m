//
//  LLSCommentListViewController.m
//  News
//
//  Created by liulishuo on 2017/11/4.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import "LLSCommentListViewController.h"
#import "LLSAPIManager+Comment.h"
#import <UIImageView+WebCache.h>
#import "MJRefresh.h"

static const NSUInteger kPageSize = 20;

@interface LLSCommentListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSUInteger pageIndex;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LLSCommentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"评论";
    
    _dataArray = [NSMutableArray new];
    
    __weak __typeof(self) weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageIndex = 1;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.tableView reloadData];
        [weakSelf fetchCommentList];
    }];
    
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageIndex ++;
        [weakSelf fetchCommentList];
    }];
    
    // 马上进入刷新状态
    [_tableView.mj_header beginRefreshing];
    _tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Event Response
#pragma mark - Network
- (void)fetchCommentList {
    [LLSAPIManager fetchCommentListWithItemId:_itemId catalog:1 pageIndex:_pageIndex pageSize:kPageSize success:^(NSDictionary * _Nullable responseObject) {
        [_dataArray addObjectsFromArray:responseObject[@"commentList"]];
        [_tableView reloadData];
        [self refershMJEndStatus];
    } failure:^(NSError * _Nullable error) {
        [self processError:error];
        [self refershMJEndStatus];
    }];
}
#pragma mark - Delegate
#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *commentInfo = _dataArray[section];
    NSArray *refersArray = commentInfo[@"refers"];
    return refersArray.count + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *commentInfo = _dataArray[indexPath.section];
    NSArray *refersArray = commentInfo[@"refers"];
    
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rowHead"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"rowHead"];
            cell.textLabel.numberOfLines = 0;
            cell.detailTextLabel.numberOfLines = 0;
        }
        [cell.imageView sd_setImageWithURL:commentInfo[@"commentPortrait"] placeholderImage:[UIImage imageNamed:@"portrait_loading"]];
        cell.textLabel.text = commentInfo[@"commentAuthor"];
        cell.detailTextLabel.text = commentInfo[@"pubDate"];
        return cell;
    } else if (indexPath.row == refersArray.count + 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rowTail"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rowTail"];
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.font = [UIFont systemFontOfSize:15];
        }
        NSString *contentString = commentInfo[@"content"];
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[contentString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        cell.textLabel.attributedText = attrStr;
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rowRefers"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"rowRefers"];
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.detailTextLabel.numberOfLines = 0;
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
        }
        
        NSInteger level = refersArray.count - indexPath.row + 1;
        CGFloat width = cell.contentView.frame.size.width;
        NSInteger maxLevel = width / cell.indentationWidth;
        
        cell.indentationLevel = level > maxLevel ? maxLevel : level;
        NSDictionary *referInfo = refersArray[indexPath.row - 1];
        cell.textLabel.text = referInfo[@"refertitle"];
        
        NSString *contentString = referInfo[@"referbody"];
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[contentString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        cell.detailTextLabel.attributedText = attrStr;
        return cell;
    }
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 2;
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
