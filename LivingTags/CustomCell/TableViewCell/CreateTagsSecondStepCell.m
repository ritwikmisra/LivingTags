//
//  CreateTagsSecondStepCell.m
//  LivingTags
//
//  Created by appsbeetech on 13/07/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "CreateTagsSecondStepCell.h"

@implementation CreateTagsSecondStepCell

- (void)awakeFromNib
{
    self.btnBrowseUserPic.layer.cornerRadius=5.0f;
    self.btnGetLocation.layer.cornerRadius=5.0f;
    self.btnRemoveLocation.layer.cornerRadius=5.0f;
    self.btnSkipPressed.layer.cornerRadius=5.0f;
    self.btnBrowseCover.layer.cornerRadius=5.0f;
    self.btnNext.layer.cornerRadius=5.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
