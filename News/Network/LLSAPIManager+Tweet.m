//
//  LLSAPIManager+Tweet.m
//  News
//
//  Created by liulishuo on 2017/11/4.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import "LLSAPIManager+Tweet.h"

@implementation LLSAPIManager (Tweet)

+ (void)fetchTweetListWithUserId:(NSInteger)userId pageIndex:(NSInteger)pageindex pageSize:(NSInteger)pageSize success:(LLSAPISuccessHandler)success failure:(LLSAPIFailureHandler)failure {
    [LLSAPIManager POST:@"tweet_list" parameters:@{
                                                  @"user":@(userId),
                                                  @"pageIndex":@(pageindex),
                                                  @"pageSize":@(pageSize),
                                                  }
                  cacheTime:-1
                success:success failure:failure];
}

+ (void)fetchTweetDatailWithTweetId:(NSInteger)tweetId success:(LLSAPISuccessHandler)success failure:(LLSAPIFailureHandler)failure {
    [LLSAPIManager POST:@"tweet_detail" parameters:@{
                                                  @"id":@(tweetId),
                                                  }
              cacheTime:LLSAPICacheTime
                success:success failure:failure];
}
@end
