//
//  LLSAPIManager+News.m
//  News
//
//  Created by liulishuo on 2017/11/4.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import "LLSAPIManager+News.h"

@implementation LLSAPIManager (News)

+ (void)fetchNewsListWithCatalog:(NSInteger)catalog pageIndex:(NSInteger)pageindex pageSize:(NSInteger)pageSize success:(LLSAPISuccessHandler)success failure:(LLSAPIFailureHandler)failure {
    [LLSAPIManager POST:@"news_list" parameters:@{
                                                  @"catalog":@(catalog),
                                                  @"pageIndex":@(pageindex),
                                                  @"pageSize":@(pageSize),
                                                  }
                cacheTime:-1
                success:success failure:failure];
}

+ (void)fetchNewsDatailWithNewsId:(NSInteger)newsId success:(LLSAPISuccessHandler)success failure:(LLSAPIFailureHandler)failure {
    [LLSAPIManager POST:@"news_detail" parameters:@{
                                                  @"id":@(newsId),
                                                  }
              cacheTime:LLSAPICacheTime
                success:success
                failure:failure];
}

@end
