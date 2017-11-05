//
//  NewsDetailViewController.m
//  News
//
//  Created by liulishuo on 2017/11/4.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import "LLSNewsDetailViewController.h"
#import <WebKit/WebKit.h>
#import "LLSAPIManager+News.h"
#import "LLSCommentListViewController.h"

@interface LLSNewsDetailViewController ()<WKNavigationDelegate,WKUIDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet WKWebView *webView;

@end

@implementation LLSNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"详情";
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    [self fetchNewsData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Event Response
- (IBAction)showCommentList:(id)sender {
    [self performSegueWithIdentifier:@"toCommentList" sender:@(self.newsId)];
}

#pragma mark - Network
- (void)fetchNewsData {
    [LLSAPIManager fetchNewsDatailWithNewsId:_newsId success:^(NSDictionary * _Nullable responseObject) {
        [self refreshUIWithData:responseObject];
    } failure:^(NSError * _Nullable error) {
        [self processError:error];
    }];
}
#pragma mark - Delegate
#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if (!navigationAction.targetFrame) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL options:@{} completionHandler:^(BOOL success) {
        }];
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - Methods
- (void)refreshUIWithData:(NSDictionary *)data {
    _titleLabel.text = data[@"title"];
    NSString *subString = [NSString stringWithFormat:@"@%@ 发布于：%@",data[@"author"],data[@"pubDate"]];
    _subTitleLabel.text = subString;
    NSString *bodyString = data[@"body"];
    [_webView loadHTMLString:bodyString baseURL:nil];
    
    NSNumber *commentCount = data[@"commentCount"];
    if ([commentCount isEqualToNumber:@0]) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    } else {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toCommentList"]) {
        LLSCommentListViewController *vc = segue.destinationViewController;
        vc.itemId = ((NSNumber *)sender).integerValue;
    }
}
#pragma mark - Setter and Getter




@end
