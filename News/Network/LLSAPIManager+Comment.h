//
//  LLSAPIManager+Comment.h
//  News
//
//  Created by liulishuo on 2017/11/4.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import "LLSAPIManager.h"

@interface LLSAPIManager (Comment)

+ (void)fetchCommentListWithItemId:(NSInteger)itemId
                           catalog:(NSInteger)catalog
                         pageIndex:(NSInteger)pageindex
                          pageSize:(NSInteger)pageSize
                           success:(nullable LLSAPISuccessHandler)success
                           failure:(nullable LLSAPIFailureHandler)failure;

@end
