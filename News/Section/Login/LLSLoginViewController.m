//
//  LoginViewController.m
//  News
//
//  Created by liulishuo on 2017/11/3.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import "LLSLoginViewController.h"
#import "LLSAPIManager+Token.h"
#import "LLSAPIManager+User.h"
#import "NSURL+LLSUtil.h"
#import "AppDelegate.h"

@interface LLSLoginViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;

@end

@implementation LLSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";

    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *clientId = appDelegate.clientId;
    NSString *redirectUrl = appDelegate.redirectUrl;
    
    NSString *urlString = [NSString stringWithFormat:@"https://www.oschina.net/action/oauth2/authorize?response_type=code&client_id=%@&redirect_uri=%@",clientId,redirectUrl];
    NSCharacterSet *characterSet = [NSCharacterSet  URLQueryAllowedCharacterSet];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:characterSet];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
    _webView.delegate = self;
    
    [_webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self showHUD];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self hideHUD];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *requestURL = [request URL];
    
    NSString *query = [requestURL query];
    
    if (query.length) {
        NSString *code = [requestURL lls_valueForKey:@"code"];
        
        if (code.length) {
            [LLSAPIManager fetchTokenWithCode:code success:^(NSDictionary *responseObject) {
                [LLSAPIManager fetchUserInfoWithSuccess:^(NSDictionary * _Nullable responseObject) {
                    [self dismissViewControllerAnimated:YES completion:^{
                    }];
                } failure:^(NSError * _Nullable error) {
                    
                }];
            } failure:^(NSError *error) {
                
            }];
            
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - Event Response

- (IBAction)clickToDismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
