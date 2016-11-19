//
//  ProductCell.m
//  LivingTags
//
//  Created by appsbeetech on 18/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ProductCell.h"

@implementation ProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.actIndicatorProduct setHidesWhenStopped:YES];
}

@end
