//
//  PersonImageCell.m
//  LivingTags
//
//  Created by appsbeetech on 14/10/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "PersonImageCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation PersonImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imgBackground.layer.borderWidth=1.0f;
    self.imgBackground.layer.borderColor=[UIColor colorWithRed:144/255.0f green:146/255.0f blue:149/255.0f alpha:1.0].CGColor;
}

@end
