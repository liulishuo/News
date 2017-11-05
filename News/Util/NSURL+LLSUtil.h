//
//  NSURL+LLSUtil.h
//  News
//
//  Created by liulishuo on 2017/11/5.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (LLSUtil)

/**
 根据指定的参数名，从URL中找出并返回对应的参数值

 @param key 参数名
 @return 参数值
 */
- (nullable NSString *)lls_valueForKey:(nonnull NSString *)key;

@end
