//
//  CategoryGridCell.m
//  LivingTags
//
//  Created by appsbeetech on 19/12/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "CategoryGridCell.h"

@implementation CategoryGridCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.vwLabel.layer.cornerRadius=5.0f;
    self.vwLabel.layer.borderWidth=1.0f;
    self.vwLabel.layer.borderColor=[UIColor colorWithRed:87/255.0f green:198/255.0f blue:249/255.0f alpha:1.0].CGColor;
}

@end
