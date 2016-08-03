//
//  EditProfilePicCellTableViewCell.m
//  LivingTags
//
//  Created by appsbeetech on 29/04/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "EditProfilePicCellTableViewCell.h"

@implementation EditProfilePicCellTableViewCell

- (void)awakeFromNib
{
    [self.actProfileIndicator setHidesWhenStopped:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
