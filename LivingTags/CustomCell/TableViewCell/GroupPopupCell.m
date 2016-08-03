//
//  GroupPopupCell.m
//  LivingTags
//
//  Created by appsbeetech on 31/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "GroupPopupCell.h"

@implementation GroupPopupCell

- (void)awakeFromNib {
    // Initialization code
    [self.actIndicatorTag setHidesWhenStopped:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
