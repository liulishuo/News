//
//  LLSAPIManager.m
//  News
//
//  Created by liulishuo on 2017/11/4.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import "LLSAPIManager.h"
#import <YTKNetwork.h>
#import "AFURLRequestSerialization.h"

const NSInteger LLSAPICacheTime = 100;

@implementation LLSAPIManager

+ (void)POST:(NSString *)URLString
  parameters:(NSDictionary *)parameters
cacheTime:(NSInteger)cacheTime
     success:(LLSAPISuccessHandler)success
     failure:(LLSAPIFailureHandler)failure {
    
    LLSRequest *request = [[LLSRequest alloc] initWithUrl:URLString argument:parameters cacheTimeInSeconds:cacheTime];
    if ([request loadCacheWithError:nil]) {
        if (success) {
            success(request.responseObject);
        }
        return;
    }
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (success) {
            success(request.responseObject);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure) {
            failure(request.error);
        }
    }];
}

+ (void)upload:(NSString *)URLString data:(NSData *)data bodyParameters:(NSDictionary *)bodyParameters success:(LLSAPISuccessHandler)success failure:(LLSAPIFailureHandler)failure {
    __block NSData *tempData = data;
    LLSRequest *request = [[LLSRequest alloc] initWithUrl:URLString argument:nil cacheTimeInSeconds:-1];
    request.constructingBodyBlock = ^(id<AFMultipartFormData> formData) {
        NSString *name = bodyParameters[@"name"];
        NSString *formKey = bodyParameters[@"formKey"];
        NSString *type = bodyParameters[@"type"];
        [formData appendPartWithFileData:tempData name:formKey fileName:name mimeType:type];
    };
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (success) {
            success(request.responseObject);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure) {
            failure(request.error);
        }
    }];
}

+ (void)baseUrl:(NSString *)url {
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = url;
}
@end
