//
//  AddLogoCell.m
//  LivingTags
//
//  Created by appsbeetech on 14/10/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "AddLogoCell.h"

@implementation AddLogoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIColor *color = [UIColor colorWithRed:76/255.0f green:87/255.0f blue:95/255.0f alpha:1.0];
    self.txtAddLogo.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Add Logo" attributes:@{NSForegroundColorAttributeName: color}];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
