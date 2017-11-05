//
//  LLSAPIManager+Token.h
//  News
//
//  Created by liulishuo on 2017/11/4.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import "LLSAPIManager.h"

@interface LLSAPIManager (Token)

+ (void)fetchTokenWithCode:(nonnull NSString *)code
                   success:(nullable LLSAPISuccessHandler)success
                   failure:(nullable LLSAPIFailureHandler)failure;

@end
