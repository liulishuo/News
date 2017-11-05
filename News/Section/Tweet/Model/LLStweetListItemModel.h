//
//  LLStweetListItemModel.h
//  News
//
//  Created by liulishuo on 2017/11/5.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLStweetListItemModel : NSObject

@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *authorid;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, readonly) NSAttributedString *bodyAttributedString;
@property (nonatomic, copy) NSString *commentCount;
@property (nonatomic, copy) NSString *itemId;
@property (nonatomic, copy) NSURL *portrait;
@property (nonatomic, copy) NSString *pubDate;
@property (nonatomic, copy) NSString *imgBig;
@property (nonatomic, copy) NSString *imgSmall;
@property (nonatomic, copy, readonly) NSArray<NSURL *> *originalPicUrls; //原图像Url
@property (nonatomic, copy, readonly) NSArray<NSURL *> *thumbnailPicUrls;//缩略图Url

@end
