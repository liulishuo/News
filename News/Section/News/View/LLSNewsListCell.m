//
//  NewsListCell.m
//  News
//
//  Created by liulishuo on 2017/11/4.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import "LLSNewsListCell.h"

@interface LLSNewsListCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

@end

@implementation LLSNewsListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithData:(NSDictionary *)data {
    _titleLabel.text = data[@"title"];
    _contentLabel.text = data[@"body"];//接口没有缩略内容字段
    _commentCountLabel.text = ((NSNumber *)data[@"commentCount"]).stringValue;
    _authorLabel.text = [NSString stringWithFormat:@"@%@",data[@"author"]];
}

@end
