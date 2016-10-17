//
//  BirthDeathDateCell.m
//  LivingTags
//
//  Created by appsbeetech on 13/10/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "BirthDeathDateCell.h"

@implementation BirthDeathDateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIColor *color = [UIColor colorWithRed:76/255.0f green:87/255.0f blue:95/255.0f alpha:1.0];
    self.txtBirth.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Birth Date" attributes:@{NSForegroundColorAttributeName: color}];

    UIColor *color2 = [UIColor colorWithRed:76/255.0f green:87/255.0f blue:95/255.0f alpha:1.0];
    self.txtDeath.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Death Date" attributes:@{NSForegroundColorAttributeName: color2}];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
