//
//  LLSBaseViewController.h
//  News
//
//  Created by liulishuo on 2017/11/4.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLSBaseViewController : UIViewController


/**
 处理错误的通用方法

 @param error 网络请求的error
 */
- (void)processError:(NSError *)error;


/**
 HUD提示 默认3s

 @param message 提示美容
 */
- (void)showMessage:(NSString *)message;


/**
 显示loading HUD
 */
- (void)showHUD;


/**
 去掉loading HUD
 */
- (void)hideHUD;

@end
