//
//  UIImage+LLSUtil.h
//  News
//
//  Created by liulishuo on 2017/11/5.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LLSUtil)

/**
 重置image尺寸

 @param size 最大尺寸
 @return 重置后的图片
 */
- (UIImage *)lls_resizeImageWithMaxPixelSize:(CGFloat)size;

@end
