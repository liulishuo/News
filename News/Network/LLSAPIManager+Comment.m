//
//  LLSAPIManager+Comment.m
//  News
//
//  Created by liulishuo on 2017/11/4.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import "LLSAPIManager+Comment.h"

@implementation LLSAPIManager (Comment)

+ (void)fetchCommentListWithItemId:(NSInteger)itemId catalog:(NSInteger)catalog pageIndex:(NSInteger)pageindex pageSize:(NSInteger)pageSize success:(LLSAPISuccessHandler)success failure:(LLSAPIFailureHandler)failure {
    [LLSAPIManager POST:@"comment_list" parameters:@{
                                                     @"id":@(itemId),
                                                  @"catalog":@(catalog),
                                                  @"pageIndex":@(pageindex),
                                                  @"pageSize":@(pageSize),
                                                  }
     cacheTime:-1
                success:success failure:failure];
}

@end
