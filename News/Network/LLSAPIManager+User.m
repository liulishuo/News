//
//  LLSAPIManager+User.m
//  News
//
//  Created by liulishuo on 2017/11/4.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import "LLSAPIManager+User.h"

@implementation LLSAPIManager (User)

+ (void)fetchUserInfoWithSuccess:(LLSAPISuccessHandler)success failure:(LLSAPIFailureHandler)failure {
    [LLSAPIManager POST:@"user" parameters:nil
              cacheTime:-1
                success:^(NSDictionary * _Nullable responseObject) {
                                                 [[NSUserDefaults standardUserDefaults] setValue:responseObject forKey:LLSReqUserInfo];
                                                 success(responseObject);
                                             } failure:failure];
}

@end
