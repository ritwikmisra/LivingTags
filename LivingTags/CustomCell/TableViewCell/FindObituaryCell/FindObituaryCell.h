//
//  FindObituaryCell.h
//  LivingTags
//
//  Created by appsbeetech on 01/12/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindObituaryCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UIImageView *imgObituaryTags;
@property(nonatomic,strong)IBOutlet UILabel *lblObituaryName;
@property(nonatomic,strong)IBOutlet UILabel *lblDate;
@property(nonatomic,strong) IBOutlet UIActivityIndicatorView *actTagsIndicator;
@end
