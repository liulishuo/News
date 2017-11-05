//
//  LLSAPIManager+User.h
//  News
//
//  Created by liulishuo on 2017/11/4.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import "LLSAPIManager.h"

@interface LLSAPIManager (User)

+ (void)fetchUserInfoWithSuccess:(nullable LLSAPISuccessHandler)success
                         failure:(nullable LLSAPIFailureHandler)failure;;

@end
