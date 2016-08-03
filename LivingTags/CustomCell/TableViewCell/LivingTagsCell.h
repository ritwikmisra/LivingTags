//
//  LivingTagsCell.h
//  LivingTags
//
//  Created by appsbeetech on 09/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LivingTagsCell : UITableViewCell

@property (nonatomic,strong)IBOutlet UIImageView *imgTag;
@property(nonatomic,strong)IBOutlet UILabel *lblName;
@property(nonatomic,strong)IBOutlet UILabel *lblDate;
@property(nonatomic,strong)IBOutlet UILabel *lblLocation;

@property(nonatomic,strong)IBOutlet UIActivityIndicatorView *actIndicatorTag;

@end
