//
//  LLSAPIManager+Token.m
//  News
//
//  Created by liulishuo on 2017/11/4.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import "LLSAPIManager+Token.h"

@implementation LLSAPIManager (Token)

+ (void)fetchTokenWithCode:(NSString *)code
                   success:(LLSAPISuccessHandler)success
                   failure:(LLSAPIFailureHandler)failure {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:LLSReqAccessToken];
    [LLSAPIManager POST:@"token" parameters:@{
                                              @"client_id":@"BtZoBtnOjnUc3tPlkwXs",
                                          @"client_secret":@"lMfgxMRZUqGItiEmsgTEddWgNTHqWk4R",
                                              @"grant_type":@"authorization_code",
                                              @"redirect_uri":@"http://www.travelease.com.cn",
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
