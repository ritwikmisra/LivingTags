//
//  ProfileCell.m
//  LivingTags
//
//  Created by appsbeetech on 07/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ProfileCell.h"

@implementation ProfileCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.btnEdit.layer.cornerRadius=10.0f;
    [self.actIndicatorProfilePic setHidesWhenStopped:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
