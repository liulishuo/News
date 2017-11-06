//
//  LLSAPIManager+Token.m
//  News
//
//  Created by liulishuo on 2017/11/4.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import "LLSAPIManager+Token.h"
#import "AppDelegate.h"

@implementation LLSAPIManager (Token)

+ (void)fetchTokenWithCode:(NSString *)code
                   success:(LLSAPISuccessHandler)success
                   failure:(LLSAPIFailureHandler)failure {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:LLSReqAccessToken];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *clientId = appDelegate.clientId;
    NSString *redirectUrl = appDelegate.redirectUrl;
    NSString *clientSecret = appDelegate.clientSecret;
    
    [LLSAPIManager POST:@"token" parameters:@{
                                              @"client_id":clientId,
                                          @"client_secret":clientSecret,
                                              @"grant_type":@"authorization_code",
                                              @"redirect_uri":redirectUrl,
                                              @"code":code,
                                              }
              cacheTime:-1
                success:^(NSDictionary * _Nullable responseObject) {
                                                  NSString *token = responseObject[@"access_token"];
                                                  [[NSUserDefaults standardUserDefaults] setValue:token forKey:LLSReqAccessToken];
                                                  success(responseObject);
                                              } failure:failure];
}

@end
