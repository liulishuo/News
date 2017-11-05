//
//  LLSAPIManager.h
//  News
//
//  Created by liulishuo on 2017/11/4.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLSRequest.h"

FOUNDATION_EXTERN const NSInteger LLSAPICacheTime;

typedef void(^LLSAPISuccessHandler)(NSDictionary *_Nullable responseObject);
typedef void(^LLSAPIFailureHandler)(NSError *_Nullable error);

@interface LLSAPIManager : NSObject


/**
 POST方式请求

 @param URLString 目标接口
 @param parameters 参数
 @param cacheTime 缓存时间 -1为不缓存
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)POST:(nonnull NSString *)URLString
  parameters:(nullable NSDictionary *)parameters
cacheTime:(NSInteger)cacheTime
     success:(nullable LLSAPISuccessHandler)success
     failure:(nullable LLSAPIFailureHandler)failure;

+ (void)upload:(nonnull NSString *)URLString
          data:(nonnull NSData *)data
bodyParameters:(nonnull NSDictionary *)bodyParameters
       success:(nullable LLSAPISuccessHandler)success
       failure:(nullable LLSAPIFailureHandler)failure;


/**
 设置服务器地址

 @param url 服务器地址字符串
 */
+ (void)baseUrl:(nonnull NSString *)url;

@end
