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
                                              @"client_id":@"t09FuxDJtotkQknW9L2o",
                                              @"client_secret":@"J7bwzyvEMOxfdQABa2Yk09K4ItSa0sxw",
                                              @"grant_type":@"authorization_code",
                                              @"redirect_uri":@"https://www.baidu.com/",
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
