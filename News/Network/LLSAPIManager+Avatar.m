//
//  LLSAPIManager+Avatar.m
//  News
//
//  Created by liulishuo on 2017/11/4.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import "LLSAPIManager+Avatar.h"

@implementation LLSAPIManager (Avatar)

+ (void)updatePortraitWithData:(NSData *)data
                        success:(LLSAPISuccessHandler)success
                        failure:(LLSAPIFailureHandler)failure {

    NSString *pictureDataString = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    [LLSAPIManager POST:@"portrait_update" parameters:@{
                                                        @"portrait":pictureDataString,
                                                        }
     cacheTime:-1
                success:success
                failure:failure];
}

@end
