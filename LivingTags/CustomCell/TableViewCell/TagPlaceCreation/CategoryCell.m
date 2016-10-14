//
//  CategoryCell.m
//  LivingTags
//
//  Created by appsbeetech on 14/10/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "CategoryCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation CategoryCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.imgBackground.layer.borderWidth=1.0f;
    self.imgBackground.layer.borderColor=[UIColor colorWithRed:144/255.0f green:146/255.0f blue:149/255.0f alpha:1.0].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
