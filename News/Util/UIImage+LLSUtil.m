//
//  UIImage+LLSUtil.m
//  News
//
//  Created by liulishuo on 2017/11/5.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import "UIImage+LLSUtil.h"

@implementation UIImage (LLSUtil)

- (UIImage *)lls_resizeImageWithMaxPixelSize:(CGFloat)size {
    NSData *data = UIImageJPEGRepresentation(self, 1.0);
    CFDataRef dataRef = (__bridge CFDataRef)data;
    // Create thumbnail options
    CFDictionaryRef options = (__bridge CFDictionaryRef) @{
                                                           (id) kCGImageSourceCreateThumbnailWithTransform : @YES,
                                                           (id) kCGImageSourceCreateThumbnailFromImageAlways : @YES,
                                                           (id) kCGImageSourceThumbnailMaxPixelSize : @(size)
                                                           };
    // Create the image source
    CGImageSourceRef src = CGImageSourceCreateWithData(dataRef, NULL);
    // Generate the thumbnail
    CGImageRef thumbnail = CGImageSourceCreateThumbnailAtIndex(src, 0, options);
    CFRelease(src);
    
    UIImage *toReturn = [UIImage imageWithCGImage:thumbnail];
    CFRelease(thumbnail);
    return toReturn;
}

@end
