//
//  LivingTagsCell.m
//  LivingTags
//
//  Created by appsbeetech on 09/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "LivingTagsCell.h"

@implementation LivingTagsCell

- (void)awakeFromNib {
    [self.actIndicatorTag setHidesWhenStopped:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
