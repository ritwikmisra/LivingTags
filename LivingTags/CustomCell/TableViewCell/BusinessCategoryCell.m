//
//  BusinessCategoryCell.m
//  LivingTags
//
//  Created by appsbeetech on 03/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "BusinessCategoryCell.h"

@implementation BusinessCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.layer.borderWidth=1.0f;
    self.contentView.layer.borderColor=[UIColor colorWithRed:144/255.0f green:146/255.0f blue:149/255.0f alpha:1.0].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
