//
//  SidePanelCell.m
//  LivingTags
//
//  Created by appsbeetech on 12/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "SidePanelCell.h"

@implementation SidePanelCell

- (void)awakeFromNib
{
    [self.actIndicatorSidePanel setHidesWhenStopped:YES];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imgSidePanelProfile.layer.cornerRadius=self.imgSidePanelProfile.frame.size.height/2;
    self.imgSidePanelProfile.layer.masksToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
