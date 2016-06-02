//
//  GroupPopupCell.h
//  LivingTags
//
//  Created by appsbeetech on 31/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupPopupCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UILabel *lblName;
@property(nonatomic,strong)IBOutlet UIImageView *img;
@property(nonatomic,strong)IBOutlet UILabel *lblDied;
@property(nonatomic,strong)IBOutlet UIActivityIndicatorView *actIndicatorTag;

@end
