//
//  LLSTweetListCell.m
//  News
//
//  Created by liulishuo on 2017/11/5.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import "LLSTweetListCell.h"
#import <UIImageView+WebCache.h>
#import <XLPhotoBrowser.h>

static const CGFloat kGap = 5;

@interface LLSTweetListCell ()<XLPhotoBrowserDelegate, XLPhotoBrowserDatasource>

@property (weak, nonatomic) IBOutlet UIImageView *portraitImageView;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *imageContainerView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageContainerViewHeight;
@property (nonatomic, strong) LLStweetListItemModel *model;

@end

@implementation LLSTweetListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithData:(LLStweetListItemModel *)model {
    _model = model;
    [_portraitImageView sd_setImageWithURL:model.portrait placeholderImage:[UIImage imageNamed:@"portrait_loading"]];
    _authorLabel.text = model.author;
    
    _contentLabel.attributedText = model.bodyAttributedString;
    NSUInteger imagesCount = model.thumbnailPicUrls.count;
    NSUInteger imagesRows = ceilf(imagesCount / 3.0);
    CGFloat contentWidth = self.imageContainerView.frame.size.width;
    CGFloat imageWidth = (contentWidth - kGap * 2) / 3;
    if (imagesRows) {
        _imageContainerViewHeight.constant = imagesRows * imageWidth + (imagesRows - 1) * kGap;
    } else {
        _imageContainerViewHeight.constant = 0;
    }

    BOOL flag = NO;
    for (int i = 0; i < 3; i ++) {
        for (int j = 0; j < 3; j ++) {
            NSUInteger index = i * 3 + j;
            if (index < imagesCount) {
                CGFloat originX = (imageWidth + kGap) * j;
                CGFloat originY = (imageWidth + kGap) * i;
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(originX, originY, imageWidth, imageWidth)];
                imageView.tag = index + 100;
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                [_imageContainerView addSubview:imageView];
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
                imageView.userInteractionEnabled = YES;
                [imageView addGestureRecognizer:tap];
                
                NSURL *url = _model.originalPicUrls[index];
                [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@""]];
            } else {
                flag = YES;
                break;
            }
        }
        if (flag) {
            break;
        }
    }
    _dateLabel.text = model.commentCount;
    
    [self updateConstraints];
}

- (void)tapImageView:(UITapGestureRecognizer *)tap {
    UIView *imageView = tap.view;
    NSInteger tag = imageView.tag - 100;
    // 快速创建并进入浏览模式
    XLPhotoBrowser *browser = [XLPhotoBrowser showPhotoBrowserWithCurrentImageIndex:tag imageCount:self.model.thumbnailPicUrls.count datasource:self];
    
    // 自定义pageControl的一些属性
    browser.pageDotColor = [UIColor grayColor]; ///< 此属性针对动画样式的pagecontrol无效
    browser.currentPageDotColor = [UIColor whiteColor];
    browser.pageControlStyle = XLPhotoBrowserPageControlStyleClassic;///< 修改底部pagecontrol的样式为系统样式,默认是弹性动画的样式
}

- (void)reset {
    [_imageContainerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    _imageContainerViewHeight.constant = 0;
}

#pragma mark - XLPhotoBrowserDatasource

- (UIImage *)photoBrowser:(XLPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    UIImageView *imageView = [self.imageContainerView viewWithTag:index + 100];
    return imageView.image;
}

- (UIView *)photoBrowser:(XLPhotoBrowser *)browser sourceImageViewForIndex:(NSInteger)index {
    UIImageView *imageView = [self.imageContainerView viewWithTag:index + 100];
    return imageView;
}

//-(void)updateConstraints {
//    NSUInteger imagesCount = _model.thumbnailPicUrls.count;
//    NSUInteger imagesRows = ceilf(imagesCount / 3.0);
//    CGFloat contentWidth = self.imageContainerView.frame.size.width;
//    CGFloat imageWidth = (contentWidth - kGap * 2) / 3;
//    if (imagesRows) {
//        _imageContainerViewHeight.constant = imagesRows * imageWidth + (imagesRows - 1) * kGap;
//    } else {
//        _imageContainerViewHeight.constant = 0;
//    }
//
//    [super updateConstraints];
//}
@end
