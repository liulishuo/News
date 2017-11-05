//
//  LLSAPIManager+Avatar.h
//  News
//
//  Created by liulishuo on 2017/11/4.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import "LLSAPIManager.h"
#import <UIKit/UIKit.h>

@interface LLSAPIManager (Avatar)

+ (void)updatePortraitWithData:(nonnull NSData *)data
                       success:(nullable LLSAPISuccessHandler)success
                       failure:(nullable LLSAPIFailureHandler)failure;

@end
