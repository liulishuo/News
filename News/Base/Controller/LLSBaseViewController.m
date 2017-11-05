//
//  LLSBaseViewController.m
//  News
//
//  Created by liulishuo on 2017/11/4.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import "LLSBaseViewController.h"
#import "LLSLoginViewController.h"
#import <MBProgressHUD.h>

@interface LLSBaseViewController ()

@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation LLSBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)processError:(NSError *)error {
    if (error.code == -1005) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController *nav = [storyboard instantiateViewControllerWithIdentifier:@"LoginVCNav"];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
        [self showMessage:@"登录失效，重新登录"];
    } else {
        [self showMessage:error.localizedDescription];
    }
}

- (void)showMessage:(NSString *)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    [hud hideAnimated:YES afterDelay:3.f];
}

- (void)showHUD {
    if (!_hud) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
}

- (void)hideHUD {
    [_hud hideAnimated:YES];
    [_hud removeFromSuperview];
    _hud = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
