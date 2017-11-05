//
//  NSURL+LLSUtil.m
//  News
//
//  Created by liulishuo on 2017/11/5.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import "NSURL+LLSUtil.h"

@implementation NSURL (LLSUtil)

- (NSString *)lls_valueForKey:(NSString *)key {
    NSString *queryString = [self query];
    if (queryString.length == 0) {
        return nil;
    }
    
    NSString * str = nil;
    NSRange start = [queryString rangeOfString:[key stringByAppendingString:@"="]];
    if (start.location != NSNotFound) {
        NSRange end = [[queryString substringFromIndex:start.location + start.length] rangeOfString:@"&"];
        NSUInteger offset = start.location+start.length;
        str = end.location == NSNotFound
        ? [queryString substringFromIndex:offset]
        : [queryString substringWithRange:NSMakeRange(offset, end.location)];
    }
    
    return str;
}

@end
