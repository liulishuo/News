//
//  LLSTweetListCell.h
//  News
//
//  Created by liulishuo on 2017/11/5.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import "LLSBaseCell.h"
#import "LLStweetListItemModel.h"

@interface LLSTweetListCell : LLSBaseCell

- (void)configureWithData:(LLStweetListItemModel *)model;
- (void)reset;

@end
