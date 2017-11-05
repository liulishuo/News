//
//  LLSRequest.m
//  News
//
//  Created by liulishuo on 2017/11/4.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import "LLSRequest.h"

NSString *const LLSReqAccessToken = @"LLSReqAccessToken";
NSString *const LLSReqUserInfo = @"LLSReqUserInfo";

@interface LLSRequest()

@property (nonatomic, copy) NSDictionary *argument;
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, assign) NSInteger cacheTime;

@end

@implementation LLSRequest

- (instancetype)initWithUrl:(NSString *)url argument:(NSDictionary *)argument cacheTimeInSeconds:(NSInteger)cacheTime {
    self = [super init];
    if (self) {
        _urlString = url;
        NSMutableDictionary *tempDict = [self defaultParametersDict];
        if (argument) {
            [tempDict addEntriesFromDictionary:argument];
        }
        _argument = tempDict.copy;
        _cacheTime = cacheTime;
    }
    return self;
}

- (NSString *)requestUrl {
    return _urlString;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return _argument;
}

- (NSInteger)cacheTimeInSeconds {
    return _cacheTime;
}

- (NSMutableDictionary *)defaultParametersDict {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:LLSReqAccessToken];
    if (token.length) {
        [dict setValue:token forKey:@"access_token"];
    }
    [dict setValue:@"json" forKey:@"dataType"];
    return dict;
}

@end
