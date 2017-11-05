//
//  LLSRequest.h
//  News
//
//  Created by liulishuo on 2017/11/4.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

FOUNDATION_EXTERN NSString *const _Nonnull LLSReqAccessToken;
FOUNDATION_EXTERN NSString *const _Nonnull LLSReqUserInfo;

@interface LLSRequest : YTKRequest


/**
 网络请求对象

 @param url 接口url
 @param argument 参数
 @param cacheTime 缓存时间
 @return 网络请求对象
 */
- (nonnull instancetype)initWithUrl:(nonnull NSString *)url argument:(nullable NSDictionary *)argument cacheTimeInSeconds:(NSInteger)cacheTime;

@end
