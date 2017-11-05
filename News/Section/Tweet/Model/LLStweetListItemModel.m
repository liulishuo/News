//
//  LLStweetListItemModel.m
//  News
//
//  Created by liulishuo on 2017/11/5.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import "LLStweetListItemModel.h"
#import <UIKit/UIKit.h>

@implementation LLStweetListItemModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"itemId" : @"id",
            };
}

- (void)setImgBig:(NSString *)imgBig {
    _originalPicUrls = [self handleString:imgBig];
}

- (void)setImgSmall:(NSString *)imgSmall {
    _thumbnailPicUrls = [self handleString:imgSmall];
}

- (void)setBody:(NSString *)body {
    _body = body.copy;
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[_body dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    _bodyAttributedString = attrStr;
}

- (NSArray *)handleString:(NSString *)string {
    NSArray<NSString *> *items = [string componentsSeparatedByString:@"space/"];
    NSString *baseUrl = [NSString stringWithFormat:@"%@space/",items.firstObject];
    NSArray *images = [items.lastObject componentsSeparatedByString:@","];
    if (images.count == 1) {
        return @[];
    }
    NSMutableArray *imageUrls = [NSMutableArray new];
    [images enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *urlString = [NSString stringWithFormat:@"%@%@",baseUrl,obj];
        NSURL *url = [NSURL URLWithString:urlString];
        [imageUrls addObject:url];
    }];
    return imageUrls.copy;
}

@end
