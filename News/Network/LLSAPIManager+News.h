//
//  LLSAPIManager+News.h
//  News
//
//  Created by liulishuo on 2017/11/4.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import "LLSAPIManager.h"

@interface LLSAPIManager (News)

+ (void)fetchNewsListWithCatalog:(NSInteger)catalog
                       pageIndex:(NSInteger)pageindex
                        pageSize:(NSInteger)pageSize
                         success:(nullable LLSAPISuccessHandler)success
                         failure:(nullable LLSAPIFailureHandler)failure;

+ (void)fetchNewsDatailWithNewsId:(NSInteger)newsId
                         success:(nullable LLSAPISuccessHandler)success
                         failure:(nullable LLSAPIFailureHandler)failure;

@end
