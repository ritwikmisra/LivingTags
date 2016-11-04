//
//  PersonNameCell.m
//  LivingTags
//
//  Created by appsbeetech on 13/10/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "PersonNameCell.h"

@implementation PersonNameCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    UIColor *color = [UIColor colorWithRed:144/255.0f green:146/255.0f blue:149/255.0f alpha:1.0];
    self.txtPersonName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Person Name" attributes:@{NSForegroundColorAttributeName: color}];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
