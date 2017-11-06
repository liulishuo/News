//
//  AppDelegate.h
//  News
//
//  Created by liulishuo on 2017/11/3.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, copy) NSString *clientId;
@property (nonatomic, copy) NSString *clientSecret;
@property (nonatomic, copy) NSString *redirectUrl;

@end

