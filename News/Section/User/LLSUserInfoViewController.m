//
//  UserInfoViewController.m
//  News
//
//  Created by liulishuo on 2017/11/4.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import "LLSUserInfoViewController.h"
#import "LLSUserAvatarCell.h"
#import "LLSUserInfoCell.h"
#import "LLSAPIManager+User.h"
#import "LLSAPIManager+Avatar.h"
#import <UIImageView+WebCache.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "UIImage+LLSUtil.h"

@interface LLSUserInfoViewController ()<UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSDictionary *dataDict;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@end

@implementation LLSUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的资料";
    _titleArray = @[@"头像",@"昵称",@"性别",@"所在地区"];
    _dataDict = [[NSUserDefaults standardUserDefaults] valueForKey: LLSReqUserInfo];
    
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController.allowsEditing = YES;
    
    _tableView.tableFooterView = [[UIView alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!_dataDict) {
        [self fetchUserInfo];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Event Response
#pragma mark - Network
- (void)fetchUserInfo {
    [LLSAPIManager fetchUserInfoWithSuccess:^(NSDictionary * _Nullable responseObject) {
        [_tableView reloadData];
    } failure:^(NSError * _Nullable error) {
        [self processError:error];
    }];
}
- (void)uploadImageWithData:(NSData *)data {
    [self showHUD];
    [LLSAPIManager updatePortraitWithData:data success:^(NSDictionary * _Nullable responseObject) {
        [self hideHUD];
        [self fetchUserInfo];
    } failure:^(NSError * _Nullable error) {
        [self hideHUD];
        [self processError:error];
    }];
}
#pragma mark - Delegate
#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = _titleArray[indexPath.row];
    if ([title isEqualToString:@"头像"]) {
        LLSUserAvatarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLSUserAvatarCell"];
            [cell.avatarImageView sd_setImageWithURL:_dataDict[@"avatar"] placeholderImage:nil];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = title;
        return cell;
    } else if ([title isEqualToString:@"昵称"]) {
        LLSUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLSUserInfoCell"];
        cell.textLabel.text = title;
        cell.subLabel.text = _dataDict[@"name"];
        return cell;
    } else if ([title isEqualToString:@"性别"]) {
        LLSUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLSUserInfoCell"];
        cell.textLabel.text = title;
        cell.subLabel.text = _dataDict[@"gender"];
        return cell;
    } else if ([title isEqualToString:@"所在地区"]) {
        LLSUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLSUserInfoCell"];
        cell.textLabel.text = title;
        cell.subLabel.text = _dataDict[@"location"];
        return cell;
    }
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"更换头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                [self showAlertWithMessage:@"请在设置-->隐私-->照片，中开启本应用的相机访问权限！"];
            } else {
                [self selectImageFromAlbum];
            }
        }];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [self showAlertWithMessage:@"请在设置-->隐私-->相机，中开启本应用的相机访问权限！"];
            } else {
                [self selectImageFromCamera];
            }
        }];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           
        }];
        [alertController addAction:action0];
        [alertController addAction:action1];
        [alertController addAction:action2];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 80;
    } else {
        return 44;
    }
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    //判断资源类型
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        UIImage *image = info[UIImagePickerControllerEditedImage];
        NSData *imageData = [self processImage:image];
        [self uploadImageWithData:imageData];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Methods
- (void)selectImageFromCamera {
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    _imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
    _imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

- (void)selectImageFromAlbum {
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

- (NSData *)processImage:(UIImage *)image {
    @autoreleasepool {
        UIImage *newImage = [image lls_resizeImageWithMaxPixelSize:1024.0f];
        image = nil;
        NSData *data = UIImageJPEGRepresentation(newImage, 0.8f);
        newImage = nil;
        
        CGFloat imageSize = data.length / 1024.0;
        NSLog(@"%f",imageSize);
        return data;
    }
}

- (void)showAlertWithMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Navigation
#pragma mark - Setter and Getter

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
