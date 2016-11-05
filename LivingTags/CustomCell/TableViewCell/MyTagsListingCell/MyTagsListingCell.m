//
//  MyTagsListingCell.m
//  LivingTags
//
//  Created by appsbeetech on 05/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "MyTagsListingCell.h"

@implementation MyTagsListingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btnEdit.layer.cornerRadius=10.0f;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
